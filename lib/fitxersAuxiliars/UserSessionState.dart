import 'package:bark_and_meet/NewAccountScreen.dart';
import 'package:bark_and_meet/user.dart';
import 'package:bark_and_meet/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../dog.dart';
import '../home.dart';


class UserSession extends StatefulWidget {
  const UserSession({super.key});

  @override
  _UserSessionState createState() => _UserSessionState();
}

class _UserSessionState extends State<UserSession> {

  Future<DocumentSnapshot>? _userFuture;


  @override
  void initState() {
    super.initState();
    _userFuture = UserProfile.usuariExisteix(FirebaseAuth.instance.currentUser!.uid);
  }

  _UserSessionState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (_userFuture == null || snapshot.connectionState == ConnectionState.waiting) {
              _userFuture = UserProfile.usuariExisteix(snapshot.data!.uid);
            }
            return FutureBuilder<DocumentSnapshot>(
              future: _userFuture,
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (userSnapshot.hasData && userSnapshot.data!.exists) {
                  UserProfile userProfile = UserProfile.userFromDocumentSnapshot(userSnapshot.data!);
                  if (userProfile.numDogs > 0) {
                    return FutureBuilder<void>(
                      future: userProfile.getUserDogs() ,
                      builder: (context, dogsSnapshot) {
                        if (dogsSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return UserProfileScreen(user: userProfile);
                        }
                      },
                    );
                  } else {
                    return UserProfileScreen(user: userProfile);
                  }
                } else {
                  User user = FirebaseAuth.instance.currentUser!;
                  UserProfile userProfile = UserProfile.basic(email: user.email!);
                  return NewAccountScreen(user: userProfile);
                }
              },
            );
          } else {
            return const HomeScreen();
          }
        },
      ),
    );
  }
}
