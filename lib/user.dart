import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dog.dart';
import 'park.dart';

class UserProfile {
  File? profilePhoto;
  String profilePhotoUrl = '';
  String username;
  final String email;
  String name;
  String surname;
  int numDogs;
  bool gossera;
  bool premium;
  List<Dog> dogs;
  List<Park> parks;
  String city;
  String additionalInfo;

  UserProfile({
    File? profilePhoto = null,
    required this.username,
    required this.email,
    required this.name,
    required this.surname,
    required this.numDogs,
    required this.gossera,
    required this.premium,
    required this.city,
    required this.profilePhotoUrl,
    List<Dog> dogs = const [],
    List<Park> parks = const [],
    required this.additionalInfo,
  })  : this.dogs = dogs,
        this.parks = parks;

  // Constructor que només demana el correu, nom d'usuari i tot el demés per defecte.
  UserProfile.basic({
    required this.email,
  })  : this.username = '',
        this.name = '',
        this.surname = '',
        this.numDogs = 0,
        this.gossera = false,
        this.premium = false,
        this.city = '',
        this.dogs = [],
        this.parks = [],
        this.additionalInfo = '';

  List<Dog> getDogs() {
    //Algorisme martí
    List<Dog> dogs = [];
    List<int> scores = [];
    for (int i = 1; i <= 20; i++) {}

    //PQ FUNCIONI DE MENTRES
    UserProfile olivia = UserProfile(
        username: 'oliviarodrigo',
        email: 'mailprova',
        name: 'Olivia',
        surname: 'Rodrigo',
        profilePhotoUrl: "",
        numDogs: 2,
        gossera: false,
        premium: false,
        city: 'Barcelona',
        additionalInfo: 'Fan de don Xavier Cañadas');
    dogs.add(Dog(
        activityLevel: 5,
        adopcio: false,
        age: 2,
        owner: olivia,
        male: false,
        castrat: false,
        raca: 'bulldog',
        name: 'Sanche',
        size: 3,
        endurance: 4,
        sociability: 5));

    return dogs;
  }
}
