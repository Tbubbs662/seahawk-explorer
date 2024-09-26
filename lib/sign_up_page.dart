import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'main.dart';
import 'user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String photoUrl = 'assets/images/stock_image.jpg';
  String? error;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final userRef = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(0, 51, 102, 5),
              Color.fromRGBO(0, 112, 115, 10)
            ],
          ),
        ),
        child: Center(
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _header(context),
                const SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: const Color.fromRGBO(255, 255, 0, .1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person, color: Colors.black),
                    ),
                    onChanged: (value) {
                      firstName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: const Color.fromRGBO(255, 255, 0, .1),
                      filled: true,
                      prefixIcon: const Icon(Icons.person, color: Colors.black),
                    ),
                    onChanged: (value) {
                      lastName = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter an email',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: const Color.fromRGBO(255, 255, 0, .1),
                      filled: true,
                      prefixIcon: const Icon(Icons.email, color: Colors.black),
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter an email address.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'Enter a password',
                      hintStyle: const TextStyle(color: Colors.black),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: const Color.fromRGBO(255, 255, 0, .1),
                      filled: true,
                      prefixIcon: const Icon(Icons.lock, color: Colors.black),
                    ),
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password.';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      try {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email!, password: password!);
                        OurUser user = OurUser(
                            firstName: firstName!,
                            lastName: lastName!,
                            uid: FirebaseAuth.instance.currentUser!.uid,
                            email: email!,
                            photoUrl: photoUrl,
                            accountCreated: Timestamp.now(),
                            favorites: []);
                        signUp(user);
                        Navigator.of(context).pop();
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                        setState(() {});
                      } on FirebaseAuthException catch (e) {
                        error = e.message;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromRGBO(255, 215, 0, 100),
                    ),
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromRGBO(255, 215, 0, 100),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                  ),
                ),
                if (error != null)
                  Text(
                    "Error: $error",
                    style: TextStyle(color: Colors.red[800], fontSize: 12),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signUp(
    OurUser user,
  ) async {
    try {
      userRef.doc(user.uid).set(user.toMap());

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("User added to the database with ID: ${user.uid}"),
      ));
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to add user to the database: ${e.message}"),
      ));
    }
  }
}

_header(context) {
  return Column(
    children: [
      Image.asset(
        "assets/images/uncw-logo.png",
        width: 200,
        height: 200,
      ),
      const Text(
        "Seahawk Explorer",
        style: TextStyle(
          color: Color.fromRGBO(255, 215, 0, 100),
          fontSize: 36,
        ),
      ),
    ],
  );
}
