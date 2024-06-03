import 'dart:io';
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
    File? profilePhoto,
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
  })  : dogs = dogs,
        parks = parks;

  // Constructor que només demana el correu, nom d'usuari i tot el demés per defecte.
  UserProfile.basic({
    required this.email,
  })  : username = '',
        name = '',
        surname = '',
        numDogs = 0,
        gossera = false,
        premium = false,
        city = '',
        dogs = [],
        parks = [],
        additionalInfo = '';

  List<Dog> getDogs() {
    // Agafar els gossos de la base de dades



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
        owner: olivia,
        male: false,
        castrat: false,
        raca2: "a",
        dateOfBirth: "12/12/2012",
        name: 'Sanche',
        size: 3,
        endurance: 4,
        sociability: 5, friends: []));

    return dogs;
  }
}
