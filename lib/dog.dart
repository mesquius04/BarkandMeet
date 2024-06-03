import 'user.dart';
import 'dart:io';

class Dog {
  String ownerUsername = '';
  List<String> photosUrls = [];
  String city = '';

  File? dogPhoto;
  List<File?> dogPhotos;
  String name;
  UserProfile owner;
  int age;
  DateTime? dateOfBirth;
  bool adopcio;
  bool castrat;
  bool male;
  List<Dog> friends;
  bool raca;
  String raca2 = '';
  String description;
  int size;
  int endurance;
  int sociability;
  int activityLevel;

  Dog({
    File? dogPhoto = null,
    required this.name,
    required this.owner,
    required this.age,
    required this.adopcio,
    required this.castrat,
    required this.male,
    this.dateOfBirth,
    required this.raca,
    this.description = '',
    required this.size,
    required this.endurance,
    required this.sociability,
    required this.activityLevel,
    List<Dog> friends = const [],
    List<File?> dogPhotos = const [null, null, null],
  })  : this.friends = friends,
        this.dogPhotos = dogPhotos;
}
