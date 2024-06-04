import 'package:bark_and_meet/HomeScreen.dart';
import 'package:bark_and_meet/fitxersAuxiliars/MainPageAsync.dart';
import 'package:bark_and_meet/mapa.dart';
import 'package:bark_and_meet/user.dart';
import 'package:bark_and_meet/user_profile.dart';
import 'package:flutter/material.dart';

import 'fonts/bark_meet_icons.dart';

class VistaInici extends StatefulWidget {
  UserProfile user;

  VistaInici({super.key, required this.user});

  @override
  _VistaIniciState createState() => _VistaIniciState(user: user);
}

class _VistaIniciState extends State<VistaInici> {

  final UserProfile user;
  _VistaIniciState({required this.user});

  int index = 3;

  @override
  Widget build(BuildContext context) {

    List<Widget> vistes = [
      MainPageAsync(user: user),
      HomeChatScreen(user: user),
      MapScreen(user: user),
      UserProfileScreen(user: user),
    ];

    return Scaffold(
      body: vistes[index],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            this.index = index;
          });
        },

        selectedIndex: index,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(BarkMeet.step),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(BarkMeet.message),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(BarkMeet.map),
            label: 'Mapa',
          ),
          NavigationDestination(
            icon: Icon(BarkMeet.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}