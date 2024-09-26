import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'about_page.dart';
import 'explore_page.dart';
import 'home_screen.dart';
import 'main.dart';
import 'site_detail_screen.dart';
import 'site.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  Future<List<String>> getFavoriteSiteIds() async {
    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    final userDoc = await userRef.get();
    return List<String>.from(userDoc.data()?['favorites']);
  }

  Future<List<DocumentSnapshot>> getFavoriteSites(List<String> siteIds) async {
    final sitesRef = FirebaseFirestore.instance.collection('sites');
    return Future.wait(siteIds.map((id) => sitesRef.doc(id).get()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Profile",
            style: TextStyle(
              color: Color.fromRGBO(255, 215, 0, 100),
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(0, 51, 102, 5),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const HomeScreen()));
                },
                icon: const Icon(
                  Icons.home,
                  color: Colors.yellowAccent,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ExplorePage()));
                },
                icon: const Icon(
                  Icons.pin_drop,
                  color: Colors.yellowAccent,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutScreen()));
                },
                icon: const Icon(
                  Icons.person_3,
                  color: Colors.yellowAccent,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserProfile()));
                },
                icon: const Icon(
                  Icons.person,
                  color: Colors.yellowAccent,
                ),
              ),
              IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.yellowAccent,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(0, 112, 115, 10),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text("No user profile found.");
          }

          final user = snapshot.data?.data() as Map<String, dynamic>;

          return Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CircleAvatar(
                  radius: 75,
                  backgroundImage: AssetImage(user['photoUrl']),
                ),
                const SizedBox(height: 10),
                Text(
                  "${user['firstName']} ${user['lastName']}",
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user['email'],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Favorites:",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                FutureBuilder<List<String>>(
                  future: getFavoriteSiteIds(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return FutureBuilder<List<DocumentSnapshot>>(
                        future: getFavoriteSites(snapshot.data ?? []),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Expanded(
                              child: ListView(
                                children: (snapshot.data ?? [])
                                    .map((doc) => InkWell(
                                          onTap: () {
                                            var siteData = (doc.data()
                                                as Map<String, dynamic>);
                                            // print(
                                            //     'Site data: $siteData');
                                            var site = Site.fromMap(siteData);
                                            if (site != null) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SiteDetailPage(
                                                          site: site),
                                                ),
                                              );
                                            }
                                            // } else {
                                            //   print(
                                            //       'Site is null for doc id: ${doc.id}');
                                            // }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                const SizedBox(width: 8),
                                                Image.asset(
                                                  (doc.data() as Map<String,
                                                      dynamic>)['photo'],
                                                ),
                                                const SizedBox(width: 8),
                                                Text((doc.data() as Map<String,
                                                    dynamic>)['name']),
                                              ],
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            );
                          }
                        },
                      );
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
