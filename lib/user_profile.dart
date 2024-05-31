import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  final File? profilePhoto;
  final String name;
  final String surname;
  final String email;
  final String location;
  final String additionalInfo;

  UserProfileScreen({
    required this.profilePhoto,
    required this.name,
    required this.surname,
    required this.email,
    required this.location,
    required this.additionalInfo,
  });

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<File?> dogs = [];

  void _addDog() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        dogs.add(File(pickedFile.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: widget.profilePhoto != null
                      ? FileImage(widget.profilePhoto!)
                      : null,
                  child: widget.profilePhoto == null
                      ? Icon(Icons.account_circle, size: 50)
                      : null,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.name, style: TextStyle(fontSize: 18)),
                    Text(widget.surname, style: TextStyle(fontSize: 18)),
                    Text(widget.email, style: TextStyle(color: Colors.grey)),
                    Text(widget.location, style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Descripció',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              widget.additionalInfo,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 20),
            Text('Els meus gossos', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addDog,
              child: Text('Afegir un nou gos'),
            ),
            SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemCount: dogs.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: dogs[index] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(dogs[index]!, fit: BoxFit.cover),
                          )
                        : Center(child: Text('No image')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
