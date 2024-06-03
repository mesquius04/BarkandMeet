import 'dart:io';

class Park {
  File? parkPhoto;
  String name;
  String city;
  double score;
  List<String> attributes;

  Park({
    File? parkPhoto=null,
    required this.name,
    required this.city,
    this.score = 0.0,
    this.attributes = const [],
  });
}
