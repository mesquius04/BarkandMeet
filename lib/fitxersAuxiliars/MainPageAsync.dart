import 'package:bark_and_meet/Mainpage.dart';
import 'package:bark_and_meet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


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
    if (user.dogsToShow.isNotEmpty){
      return MainPage(user: user);
    }
    return Scaffold(
      body: FutureBuilder<void>(
        future: user.getDogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return MainPage(user: user);
          }
        },
      ),
    );
  }
}
