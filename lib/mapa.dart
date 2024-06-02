import 'package:flutter/material.dart';
import 'main.dart';
import 'Mainpage.dart';
import 'chat.dart';
import 'dog.dart';
import 'user.dart';
import 'user_profile.dart';
import 'dogProfile.dart';
import 'package:bark_and_meet/fonts/bark_meet_icons.dart';

class MapScreen extends StatelessWidget {
  UserProfile user;
  MapScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pantalla Mapa'),
      ),
      body: Center(
        child: Text('Aqui va el mapa'),
      ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              items: [
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        user: user
                      ),
                    ),
                  );
                }
                else if (index==2){
                  //do nothing
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