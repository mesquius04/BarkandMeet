import 'user.dart';
import 'dart:io';

class Dog {
  File? dogPhoto;
  String name;
  UserProfile owner;
  int age;
  bool adopcio;
  bool castrat;
  bool male;
  List<Dog> friends;
  String raca;
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
    this.friends = const [],
    required this.raca,
    this.description = '',
    required this.size,
    required this.endurance,
    required this.sociability,
    required this.activityLevel,
  });
}
