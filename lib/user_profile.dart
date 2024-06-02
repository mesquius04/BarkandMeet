import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'home.dart';
import 'chat.dart';
import 'mapa.dart';
import 'user.dart';
import 'package:bark_and_meet/fonts/bark_meet_icons.dart';
import 'Mainpage.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfile user;

  UserProfileScreen({
    required this.user
  });
  
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState(user:user);
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<File?> dogs = [];
  UserProfile user;
  _UserProfileScreenState({required this.user});
  void _addDog() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        dogs.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user.profilePhotoUrl != ""
                      ? Image.network(user.profilePhotoUrl).image
                      : null,
                  child: user.profilePhotoUrl == ""
                      ? Icon(Icons.account_circle, size: 50)
                      : null,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${user.name} ${user.surname}", style: Theme.of(context).textTheme.headlineSmall),
                    Text("@${user.username} · ${user.city}", style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Descripció',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              user.additionalInfo,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Text('Els meus gossos', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addDog,
              child: Text('Afegir un nou gos'),
            ),
            SizedBox(height: 10),

            // Botó log out
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                        (route) => false,
                  );
                },
              child: Text('Log out'),
            ),
            SizedBox(height: 10),

            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: dogs.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: dogs[index] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(dogs[index]!, fit: BoxFit.cover),
                          )
                        : Center(child: Text('No image')),
                  );
                },
              ),
            ),
          ],
        ),
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
                  //do nothing
                }
              },
            ),
    );
  }
}
