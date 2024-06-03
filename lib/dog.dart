import 'user.dart';
import 'dart:io';

class Dog {
  String ownerId = '';
  List<String> photosUrls = [];
  String city = '';

  File? dogPhoto;
  List<File?> dogPhotos;
  String name;
  UserProfile owner;
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

  Dog({
    File? dogPhoto,
    required this.name,
    required this.owner,
    required this.adopcio,
    required this.castrat,
    required this.male,
    required this.dateOfBirth,
    this.description = '',
    this.raca2 = '',
    required this.size,
    required this.endurance,
    required this.sociability,
    required this.activityLevel,
    List<Dog> friends = const [],
    List<File?> dogPhotos = const [null, null, null],
  })  : friends = friends,
        dogPhotos = dogPhotos;
}