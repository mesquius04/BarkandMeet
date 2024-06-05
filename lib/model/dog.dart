import 'package:cloud_firestore/cloud_firestore.dart';

import 'user.dart';
import 'dart:io';

class Dog {
  String ownerId = '';
  String ownerUsername = '';
  List<String> photosUrls = [];
  String city = '';
  String dogId = '';

  File? dogPhoto;
  List<File?> dogPhotos;
  String name;
  UserProfile? owner;
  bool adopcio;
  bool castrat;
  String dateOfBirth;
  bool male;
  List<Dog> friends;
  String raca2 = '';
  String description;
  int size;
  int endurance;
  int sociability;
  int activityLevel;

  // testing
  static late CollectionReference dogCollection;

  Dog({
    File? dogPhoto,
    required this.name,
    required this.adopcio,
    required this.castrat,
    required this.male,
    required this.dateOfBirth,
    required this.size,
    required this.endurance,
    required this.sociability,
    required this.activityLevel,
    this.description = '',
    this.raca2 = '',
    this.owner,
    this.ownerId = '',
    this.ownerUsername = '',
    this.dogId = '',
    this.city = '',
    this.photosUrls = const [],
    List<Dog> friends = const [],
    List<File?> dogPhotos = const [null, null, null],
  })  : friends = friends,
        dogPhotos = dogPhotos;




  // Agafar un gos de la base de dades
  static Future<Dog> getDog(String gosId, {required FirebaseFirestore firestoreInstance}) async {

    // Agafar el gos de la base de dades
    final dogCollection = firestoreInstance.collection('Gossos');
    final dogQuery = await dogCollection.doc(gosId).get();

    if (!dogQuery.exists) {
      throw Exception('Dog does not exist');
    }

    Map<String, dynamic> data = dogQuery.data() as Map<String, dynamic>;

    // Get the dogs array from the data
    List<dynamic> photosData = data['photosUrls'];

    // Convert the dynamic array to a List<String>
    List<String> photosUrl =
    photosData.map((item) => item.toString()).toList();

    // cear el gos
    Dog dog = Dog(
        name: data['name'],
        adopcio: data['adoption'],
        castrat: data['castrat'],
        description: data['description'],
        endurance: data['endurance'],
        activityLevel: data['activityLevel'],
        size: data['size'],
        sociability: data['sociability'],
        raca2: data['raça'],
        male: data['male'],
        dateOfBirth: data['birthday'],
        ownerId: data['ownerId'],
        ownerUsername: data['ownerUsername'],
        dogId: gosId,
        city: data['city'],
        photosUrls: photosUrl,
        dogPhotos: [null, null, null]
    );

    return dog;
  }
}
