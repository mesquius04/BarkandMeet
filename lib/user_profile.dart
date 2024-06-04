// ignore_for_file: prefer_const_constructors

import 'package:bark_and_meet/create_dog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'home.dart';
import 'fitxersAuxiliars/MainPageAsync.dart';
import 'HomeScreen.dart';
import 'mapa.dart';
import 'user.dart';
import 'package:bark_and_meet/fonts/bark_meet_icons.dart';
import 'Mainpage.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  UserProfile user;

  UserProfileScreen({super.key, required this.user});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState(user: user);
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<File?> dogs = [];
  UserProfile user;

  _UserProfileScreenState({required this.user});

  final CarouselController _carouselController1 = CarouselController();

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
        backgroundColor: Color(0xFFFFFCFC),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.logout,
              size: 24,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
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
                    Text("${user.name} ${user.surname}",
                        style: Theme.of(context).textTheme.headlineSmall),
                    Text("@${user.username} · ${user.city}",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey)),
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
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: SizedBox(
                  width: double.infinity,
                  height: 127,
                  child: CarouselSlider(
                    items: user.dogs.isEmpty
                        ? [
                            // Mostrar solo un elemento si la lista está vacía
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DogCreateScreen(user: user)),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "https://cdn0.iconfinder.com/data/icons/circles-2/100/sign-square-dashed-plus-512.png",
                                  width: 150,
                                  height: 130,
                                  fit: BoxFit.contain,
                                  alignment: Alignment(0, 0),
                                ),
                              ),
                            ),
                          ]
                        : List.generate(user.dogs.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                print('Imagen ${index + 1} seleccionada');
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "https://cdn0.iconfinder.com/data/icons/circles-2/100/sign-square-dashed-plus-512.png",
                                  width: 150,
                                  height: 130,
                                  fit: BoxFit.contain,
                                  alignment: Alignment(0, 0),
                                ),
                              ),
                            );
                          }),
                    carouselController: _carouselController1,
                    options: CarouselOptions(
                      initialPage: 1,
                      viewportFraction: 0.3,
                      disableCenter: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.25,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: false,
                      onPageChanged: (index, _) =>
                          print('Page changed to $index'),
                    ),
                  )),
            ),
            SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional(-1, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25, 35, 0, 10),
                child: Text(
                  'Parcs preferits',
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0, 0),
              child: SizedBox(
                  width: double.infinity,
                  height: 127,
                  child: CarouselSlider(
                    items: user.dogs.isEmpty
                        ? [
                            // Mostrar solo un elemento si la lista está vacía
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MapScreen(user: user)),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "https://cdn0.iconfinder.com/data/icons/circles-2/100/sign-square-dashed-plus-512.png",
                                  width: 150,
                                  height: 130,
                                  fit: BoxFit.contain,
                                  alignment: Alignment(0, 0),
                                ),
                              ),
                            ),
                          ]
                        : List.generate(user.dogs.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                print('Imagen ${index + 1} seleccionada');
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  "https://cdn0.iconfinder.com/data/icons/circles-2/100/sign-square-dashed-plus-512.png",
                                  width: 150,
                                  height: 130,
                                  fit: BoxFit.contain,
                                  alignment: Alignment(0, 0),
                                ),
                              ),
                            );
                          }),
                    carouselController: _carouselController1,
                    options: CarouselOptions(
                      initialPage: 1,
                      viewportFraction: 0.3,
                      disableCenter: true,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.25,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: false,
                      onPageChanged: (index, _) =>
                          print('Page changed to $index'),
                    ),
                  )),
            ),
            SizedBox(height: 10),
            Align(
              alignment: AlignmentDirectional(-1, 0),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: user.numDogs,
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          user.dogs[index].photosUrls[0],
                        ),
                      ));
                },
              ),
            ),
          ],
        ),
      ),
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
          pageBuilder: (context, animation, secondaryAnimation) => MainPageAsync(user: user),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
          pageBuilder: (context, animation, secondaryAnimation) => HomeChatScreen(user: user),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
          );
          } else if (index == 2) {
            Navigator.push(
              context,
              PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MapScreen(user: user),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
          );;
          } else {
            //do nothing
          }
        },
      ),
    );
  }
}
