import 'package:bark_and_meet/NewAccountScreen.dart';
import 'package:bark_and_meet/user.dart';
import 'package:bark_and_meet/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import '../Mainpage.dart';

class Usersessionstate extends StatelessWidget {
  const Usersessionstate({Key? key}) : super(key: key);

  Future<DocumentSnapshot> _usuariExisteix(String uid) async {
    final userCollection = FirebaseFirestore.instance.collection('Usuaris');
    final userQuery = await userCollection.doc(uid).get();

    // agafar el nom del user i imprimirlo
    print(userQuery.data()?['name']);

    return userQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            return FutureBuilder<DocumentSnapshot>(
              future: _usuariExisteix(snapshot.data!.uid),
              builder: (context, snapshot) {

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(), // Muestra un indicador de carga mientras se espera
                  );
                } else if (snapshot.data!.exists) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;

                  UserProfile userProfile = UserProfile(
                      username: data['username'],
                      email: data['email'],
                      name: data['name'],
                      surname: data['surname'],
                      numDogs: data['numDogs'],
                      gossera: data['gossera'],
                      premium: data['premium'],
                      city: data['city'],
                      profilePhotoUrl: data['photoURL'],
                      additionalInfo: data['additionalInfo']);
                  return UserProfileScreen(user: userProfile);

                } else {
                  User user = FirebaseAuth.instance.currentUser!;
                  UserProfile userProfile = UserProfile.basic(
                      email: user.email!);

                  return NewAccountScreen(user: userProfile);
                }
              },
            );
          } else {
            return HomeScreen();
          }
        },
      ),
    );
  }
}
