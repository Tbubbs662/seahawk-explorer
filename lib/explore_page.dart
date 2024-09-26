import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'about_page.dart';
import 'home_screen.dart';
import 'site.dart';
import 'site_detail_screen.dart';
import 'main.dart';
import 'user_profile.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Explore",
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
        body: const SitesList());
  }
}

class SitesList extends StatefulWidget {
  const SitesList({Key? key}) : super(key: key);

  @override
  _SitesListState createState() => _SitesListState();
}

class _SitesListState extends State<SitesList> {
  final sitesRef = FirebaseFirestore.instance.collection('sites');
  final userRef = FirebaseFirestore.instance.collection('users');
  final currentUser = FirebaseAuth.instance.currentUser;

  // this method is to add / remove a site to a users favorites
  Future<void> toggleFavorite(String siteId) async {
    final DocumentSnapshot userSnapshot =
        await userRef.doc(currentUser!.uid).get();

    if (userSnapshot.exists) {
      final Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> favorites = userData['favorites'] ?? [];

      if (favorites.contains(siteId)) {
        favorites.remove(siteId);
      } else {
        favorites.add(siteId);
      }

      await userRef.doc(currentUser!.uid).update({'favorites': favorites});
      setState(() {}); // Trigger rebuild so heart icons change
    }
  }

  // this method is used to check if a user has a site favorited
  Future<bool> isFavorited(String siteId) async {
    final DocumentSnapshot userSnapshot =
        await userRef.doc(currentUser!.uid).get();

    if (userSnapshot.exists) {
      final Map<String, dynamic> userData =
          userSnapshot.data() as Map<String, dynamic>;
      final List<dynamic> favorites = userData['favorites'] ?? [];

      return favorites.contains(siteId);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sitesRef.snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const CircularProgressIndicator();
        }

        var sitesDocs = snapshot.data!.docs; // get snapshot of sites document

        // transition the snapshot of the sites into a list of Site objects that is used in the GridView
        List<Site> sites = sitesDocs.map(
          (doc) {
            return Site(
              id: doc.id,
              name: doc['name'],
              yearOpened: doc['yearOpened'],
              description: doc['siteInfo'],
              imageUrl: doc['photo'],
            );
          },
        ).toList();

        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: sites.length,
          itemBuilder: (context, index) {
            return Card(
              child: Stack(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              SiteDetailPage(site: sites[index]),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.asset(
                            sites[index].imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            sites[index].name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: () {
                        toggleFavorite(sitesDocs[index].id);
                      },
                      child: FutureBuilder<bool>(
                        future: isFavorited(sitesDocs[index].id),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }

                          if (snapshot.hasData && snapshot.data!) {
                            return const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            );
                          }
                          return const Icon(
                            Icons.favorite_border_outlined,
                            color: null,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
