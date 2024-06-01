import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dog.dart';
import 'park.dart';

class User {
  File? profilePhoto;
  String username;
  String email;
  String name;
  String surname;
  int numDogs;
  bool gossera;
  bool premium;
  List<Dog> dogs;
  List<Park> parks;
  String city;
  String additionalInfo;

  User({
    File? profilePhoto=null,
    required this.username,
    required this.email,
    required this.name,
    required this.surname,
    required this.numDogs,
    required this.gossera,
    required this.premium,
    required this.city,
    List<Dog> dogs = const [],
    List<Park> parks = const [],
    required this.additionalInfo,
  })  : this.dogs = dogs,
        this.parks = parks;
  
  static List<Dog> getDogs() { //Algorisme martí
    List<Dog> dogs = [];
    List<int> scores= [];
    for (int i = 1; i <= 20; i++) {
      
    }
    return dogs;
  }
}
