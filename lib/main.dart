import 'dart:async';
import 'package:bark_and_meet/fitxersAuxiliars/UserSessionState.dart';
import 'package:bark_and_meet/fitxersAuxiliars/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home.dart';



Future<void> main() async {
  // inicialitza firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bark & Meet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Usersessionstate()
    );
  }
}
