import 'package:bark_and_meet/perfil_gos/create_dog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../inici_sessio/home.dart';
import '../altres/mapa.dart';
import '../model/user.dart';
import 'package:image_picker/image_picker.dart';
import '../perfil_gos/perfil_gos.dart'; // Importa la pantalla de perfil del perro

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

 CarouselController _carouselController1 = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: const Color(0xFFFFFCFC),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              size: 24,
            ),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: user.profilePhotoUrl.isNotEmpty
                        ? Image.network(user.profilePhotoUrl).image
                        : null,
                    child: user.profilePhotoUrl.isEmpty
                        ? const Icon(Icons.account_circle, size: 50)
                        : null,
                  ),
                  const SizedBox(width: 10),
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
              const SizedBox(height: 20),
              const Text(
                'Descripció',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                user.additionalInfo,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Els meus gossos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DogCreateScreen(user: user)),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: CarouselSlider(
  items: user.dogs.isEmpty
    ? [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DogCreateScreen(user: user),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              "https://cdn0.iconfinder.com/data/icons/circles-2/100/sign-square-dashed-plus-512.png",
              width: 150,
              height: 130,
              fit: BoxFit.contain,
              alignment: const Alignment(0, 0),
            ),
          ),
        ),
      ]
    : List.generate(user.dogs.length, (index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DogProfileScreen(
                      currentdog: user.dogs[index],
                    ),
                  ),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  user.dogs[index].photosUrls.isNotEmpty
                    ? user.dogs[index].photosUrls[0]
                    : "https://cdn0.iconfinder.com/data/icons/circles-2/100/sign-square-dashed-plus-512.png",
                  width: 150,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user.dogs[index].name,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        );
      }),
  carouselController: _carouselController1,
  options: CarouselOptions(
    initialPage: 1,
    viewportFraction: 0.35,
    disableCenter: true,
    enlargeCenterPage: false,
    enlargeFactor: 0,
    enableInfiniteScroll: false, // <--- Cambia esto a false
    scrollDirection: Axis.horizontal,
    autoPlay: false,
    onPageChanged: (index, _) => print('Page changed to $index'),
  ),
)
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Parcs preferits',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: SizedBox(
                  width: double.infinity,
                  height: 127,
                  child: CarouselSlider(
                    items: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapScreen(user: user)),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            "https://cdn0.iconfinder.com/data/icons/circles-2/100/sign-square-dashed-plus-512.png",
                            width: 150,
                            height: 130,
                            fit: BoxFit.contain,
                            alignment: const Alignment(0, 0),
                          ),
                        ),
                      ),
                    ],
                    carouselController: _carouselController1,
                    options: CarouselOptions(
                      initialPage: 0,
                      viewportFraction: 0.35,
                      disableCenter: true,
                      enlargeCenterPage: false,
                      enlargeFactor: 0.25,
                      enableInfiniteScroll: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: false,
                      onPageChanged: (index, _) =>
                          print('Page changed to $index'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
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
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    MapScreen(user: user),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
              ),
            );
          } else {
            //do nothing
          }
        },
      ),*/
    );
  }
}
