import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'explore_page.dart';
import 'main.dart';
import 'user_profile.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "About",
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
      body: const Center(
        child: Text("App created by Michael Benton-Sanchez and Caleb Tubbs."),
      ),
    );
  }
}
