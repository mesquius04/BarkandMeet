import 'package:flutter/material.dart';
import '../model/user.dart';

class MapScreen extends StatelessWidget {
  final UserProfile user;

  const MapScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Mapa'),
      ),
      body: const Center(
        child: Text('Aqui va el mapa'),
      ),
      /*
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(BarkMeet.step, color: Colors.black),
            label: 'Inici',
          ),
          BottomNavigationBarItem(
            icon: Icon(BarkMeet.message),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(BarkMeet.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(BarkMeet.person),
            label: 'Perfil',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          if (index == 0) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MainPageAsync(user: user),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    HomeChatScreen(user: user),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          } else if (index == 2) {
            //do nothing
          } else {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    UserProfileScreen(user: user),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          }
        },
      ),
      */
    );
  }
}
