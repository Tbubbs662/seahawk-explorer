import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  final String firstName;
  final String lastName;
  final String uid;
  final String email;
  final String photoUrl;
  final Timestamp accountCreated;
  final List<String> favorites;

  OurUser({
    required this.firstName,
    required this.lastName,
    required this.uid,
    required this.email,
    required this.photoUrl,
    required this.accountCreated,
    required this.favorites,
  });

  Map<String, Object?> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'uid': uid,
      'email': email,
      'photoUrl': photoUrl,
      'accountCreated': accountCreated,
      'favorites': favorites,
    };
  }
}
