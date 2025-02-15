import 'package:bark_and_meet/chat/chat.dart';
import 'package:bark_and_meet/fitxersAuxiliars/MainPageAsync.dart';
import 'package:bark_and_meet/altres/mapa.dart';
import 'package:bark_and_meet/model/user.dart';
import 'package:bark_and_meet/perfil_usuari/user_profile.dart';
import 'package:flutter/material.dart';

import 'MainPage.dart';
import 'fitxersAuxiliars/fonts/bark_meet_icons.dart';

class VistaInici extends StatefulWidget {
  UserProfile user;
  int index;

  VistaInici({super.key, required this.user, required this.index});

  @override
  _VistaIniciState createState() => _VistaIniciState(user: user, index: index);
}

class _VistaIniciState extends State<VistaInici> {
   UserProfile user;
   int index;


  _VistaIniciState({required this.user, required this.index});

  @override
  Widget build(BuildContext context) {
    List<Widget> vistes = [
      (user.dogsToShow.isNotEmpty)
          ? MainPage(user: user) : MainPageAsync(user: user),
      ChatScreen(user: user),
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
