import 'package:bark_and_meet/Mainpage.dart';
import 'package:bark_and_meet/NewAccountScreen.dart';
import 'package:bark_and_meet/user.dart';
import 'package:bark_and_meet/user_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../dog.dart';
import '../home.dart';


class MainPageAsync extends StatefulWidget {
  UserProfile user;

  MainPageAsync({super.key, required this.user});
  @override
  _MainPageAsync createState() => _MainPageAsync(user: user);
}

class _MainPageAsync extends State<MainPageAsync> {

  Future<DocumentSnapshot>? _userFuture;
  UserProfile user;

  _MainPageAsync({required this.user});
  
  @override
  Widget build(BuildContext context) {
    if (!user.dogsToShow.isEmpty){
      return Mainpage(user: user);
    }
    return Scaffold(
      body: FutureBuilder<void>(
        future: user.getDogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            print("NENE");
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print("HOLAHOLA");
            print(user.dogsToShow.length);
            return Mainpage(user: user);
          }
        },
      ),
    );
  }
}
