import 'package:csc_315_term_project/explore_page.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'about_page.dart';
import 'main.dart';
import 'user_profile.dart';
// import 'site.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Seahawk Explorer",
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'University of North Carolina Wilmington',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Image.asset("assets/images/uncw_picture.jpeg"),
          const SizedBox(height: 20),
          const Text(
            'About',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const Text(
            'UNCW offers a wide range of undergraduate and graduate programs across various disciplines, '
            'including arts and sciences, business, education, health and human services, and more. '
            'The university is home to diverse student organizations, athletic teams known as the Seahawks, '
            'and initiatives focused on sustainability and community engagement.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Image.asset("assets/images/uncw_old.jpeg"),
          const SizedBox(height: 20),
          const Text(
            'History',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const Text(
            'The University of North Carolina Wilmington (UNCW) was founded in 1947 as Wilmington College. '
            'It became a part of the University of North Carolina system in 1969 and was renamed UNCW. '
            'The university has grown significantly since its founding and is known for its coastal location, '
            'strong academic programs, and vibrant campus community.',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}


// ElevatedButton(
          //   child: const Text('Logout'),
          //   onPressed: () {
          //     FirebaseAuth.instance.signOut();
          //     Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(builder: (context) => const LoginScreen()),
          //         (route) => false);
          //   },
          // ),

// Center(
//         child: Text('Welcome ${FirebaseAuth.instance.currentUser?.email} to our app!'),
// ),