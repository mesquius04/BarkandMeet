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

  _UserSessionState();

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
            if (_userFuture == null || snapshot.connectionState == ConnectionState.waiting) {
              _userFuture = UserProfile.usuariExisteix(snapshot.data!.uid);
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
                  Map<String, dynamic> data =
                      userSnapshot.data!.data() as Map<String, dynamic>;

                  // Get the dogs array from the data
                  List<dynamic> dogsData = data['dogs'] ?? [];

                  // Convert the dynamic array to a List<String>
                  List<String> dogs =
                      dogsData.map((item) => item.toString()).toList();

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
                      additionalInfo: data['additionalInfo'],
                      dogsIds: dogs);

                  // S'ha d'arreglar tot això, és una aberració.
                  // S'ha de fer un mètode estàtic per agafar el perfil de l'usuari
                  // i un altre per agafar el gos de l'usuari.
                  if (userProfile.numDogs > 0) {
                    return FutureBuilder<Dog?>(
                      future: userProfile.dogsIds.isNotEmpty ? Dog.getDog(
                          userProfile.dogsIds[0], firestoreInstance: FirebaseFirestore.instance) : Future.value(null),
                      builder: (context, dogSnapshot) {
                        if (dogSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (dogSnapshot.hasData) {
                          Dog dog = dogSnapshot.data!;
                          dog.owner = userProfile;

                          userProfile.dogs.add(dog);

                          return UserProfileScreen(user: userProfile);
                        } else if (dogSnapshot.hasError) {
                          return Center(
                            child: Text(
                                'Failed to get dog: ${dogSnapshot.error}'),
                          );
                        } else {
                          return Center(
                            child: Text('Dog not found'),
                          );
                        }
                      },
                    );
                  } else {
                    return UserProfileScreen(user: userProfile);
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
