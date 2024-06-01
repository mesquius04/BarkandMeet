import 'package:bark_and_meet/user.dart';
import 'package:bark_and_meet/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'Mainpage.dart';

class Usersessionstate extends StatelessWidget {
  const Usersessionstate({Key? key}) : super(key: key);




  
  @override
  Widget build(BuildContext context) {





    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserProfile userProfile = UserProfile(
                username: "Olivia",
                email: "no@no",
                name: "Olivia",
                surname: "Rodrigo",
                numDogs: 0,
                gossera: false,
                premium: true,
                city: "Llafranc",
                additionalInfo: "I'm so american");
            return UserProfileScreen(user: userProfile);
          } else {
            return HomeScreen();
          }
        },
      ),
    );
    
  }
}