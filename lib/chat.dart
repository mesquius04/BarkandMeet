import 'package:flutter/material.dart';
import 'user.dart';
import 'mapa.dart';
import 'Mainpage.dart';
import 'user_profile.dart';
import 'package:bark_and_meet/fonts/bark_meet_icons.dart';

class ChatScreen extends StatelessWidget {
  UserProfile user;
  ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla Chat'),
      ),
      body: const Center(
        child: Text('Aqui van els chats'),
      ),bottomNavigationBar: BottomNavigationBar(
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mainpage(
                        user: user
                      ),
                    ),
                  );
                } else if (index==1){
                  //do nothing
                }
                else if (index==2){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        user: user
                      ),
                    ),
                  );
                }
                else{
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(
                        user: user
                      ),
                    ),
                  );
                }
              },
            ),
    );
  }
}