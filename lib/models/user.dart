import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String passwordcheck;
  final String photoUrl;
  final String username;
  final String password;

  const User({
    required this.uid,
    required this.username,
    required this.email,
    required this.passwordcheck,
    required this.photoUrl,
    required this.password,
  });

  Map<String, dynamic> toJason() => {
        'uid': uid,
        'username': username,
        'passwordcheck': passwordcheck,
        'email': email,
        'password': password,
        'photoUrl': photoUrl,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      uid: snapshot['uid'],
      username: snapshot['username'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
      password: snapshot['password'],
      passwordcheck: snapshot['passwordcheck'],
    );
  }
}
