import 'package:bark_and_meet/perfil_usuari/new_account.dart';
import 'package:bark_and_meet/model/user.dart';
import 'package:bark_and_meet/vista_inici.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/dog.dart';
import '../inici_sessio/home.dart';


class UserSession extends StatefulWidget {
  const UserSession({super.key});

  @override
  _UserSessionState createState() => _UserSessionState();
}

class _UserSessionState extends State<UserSession> {

  Future<DocumentSnapshot>? _userFuture;

  _UserSessionState();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (_userFuture == null || snapshot.connectionState == ConnectionState.waiting) {
              _userFuture = UserProfile.usuariExisteix(snapshot.data!.uid, firestoreInstance: FirebaseFirestore.instance);
            }
            return FutureBuilder<DocumentSnapshot>(
              future: _userFuture,
              builder: (context, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child:
                        CircularProgressIndicator(), // Muestra un indicador de carga mientras se espera
                  );
                } else if (userSnapshot.data!.exists && userSnapshot.hasData) {

                  UserProfile userProfile = UserProfile.userFromDocumentSnapshot(userSnapshot.data!);

                  // S'ha d'arreglar tot això, és una aberració.
                  // S'ha de fer un mètode estàtic per agafar el perfil de l'usuari
                  // i un altre per agafar el gos de l'usuari.
                  if (userProfile.numDogs > 0) {
                    return FutureBuilder<List<Dog>>(
                      future: UserProfile.getUserDogs(userProfile, firestoreInstance: FirebaseFirestore.instance),
                      builder: (context, dogsSnapshot) {
                        if (dogsSnapshot.connectionState == ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {

                          userProfile.dogs = dogsSnapshot.data!;

                          return VistaInici(user: userProfile, index: 0);
                        }
                      },
                    );
                  } else {
                    return VistaInici(user: userProfile, index: 3);
                  }
                } else {
                  User user = FirebaseAuth.instance.currentUser!;
                  UserProfile userProfile =
                      UserProfile.basic(email: user.email!);

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
