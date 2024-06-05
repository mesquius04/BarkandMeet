import 'package:bark_and_meet/perfil_gos/create_dog.dart';
import 'package:bark_and_meet/vista_inici.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../inici_sessio/home.dart';
import '../altres/mapa.dart';
import '../model/user.dart';
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
  File? _profileImage;

  _UserProfileScreenState({required this.user});

  CarouselController _carouselController1 = CarouselController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text( 
overflow: TextOverflow.ellipsis,'Perfil'),
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
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : user.profilePhotoUrl.isNotEmpty
                              ? Image.network(user.profilePhotoUrl).image
                              : null,
                      child:
                          _profileImage == null && user.profilePhotoUrl.isEmpty
                              ? const Icon(Icons.account_circle, size: 50)
                              : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text( 
overflow: TextOverflow.ellipsis,
"${user.name} ${user.surname}",
                          style: Theme.of(context).textTheme.headlineSmall),
                      Text( 
overflow: TextOverflow.ellipsis,
"@${user.username} · ${user.city}",
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
overflow: TextOverflow.ellipsis,
                'Descripció',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey[200],
                child: Text( 
overflow: TextOverflow.ellipsis,
                  
                  user.additionalInfo,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text( 
overflow: TextOverflow.ellipsis,'Els meus gossos',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 10),
                  Transform.rotate(
                    angle: 0, // Rotar 180 grados para apuntar a la izquierda
                    child: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  const SizedBox(width: 10), // Espaciado
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
                  child: CarouselSlider.builder(
                    itemCount: user.dogs.isEmpty ? 1 : user.dogs.length,
                    itemBuilder: (context, index, realIndex) {
                      if (user.dogs.isEmpty) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DogCreateScreen(user: user),
                              ),
                            );
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                "https://cdn0.iconfinder.com/data/icons/circles-2/100/sign-square-dashed-plus-512.png",
                                width: 140,
                                height: 130,
                                fit: BoxFit.contain,
                                alignment: const Alignment(0, 0),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Column(
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
overflow: TextOverflow.ellipsis,
                                user.dogs[index].name,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    carouselController: _carouselController1,
                    options: CarouselOptions(
                      initialPage: 1,
                      viewportFraction: 0.34,
                      disableCenter: true,
                      enlargeCenterPage: false,
                      enlargeFactor: 0.25,
                      enableInfiniteScroll: false,
                      scrollDirection: Axis.horizontal,
                      autoPlay: false,
                      onPageChanged: (index, _) =>
                          print('Page changed to $index'),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text( 
overflow: TextOverflow.ellipsis,
                    'Parcs preferits',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Transform.rotate(
                    angle: 0, // Rotar 180 grados para apuntar a la izquierda
                    child: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
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
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VistaInici(user: user, index: 2)),
                            (route) => false,
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
                      initialPage: 1,
                      viewportFraction: 0.35,
                      disableCenter: true,
                      enlargeCenterPage: false,
                      enlargeFactor: 0.25,
                      enableInfiniteScroll: false,
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
    );
  }
}
