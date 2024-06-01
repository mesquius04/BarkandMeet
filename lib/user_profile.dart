import 'package:flutter/material.dart';
import 'dart:io';
import 'user.dart';
import 'package:image_picker/image_picker.dart';

class UserProfileScreen extends StatefulWidget {
  final User user;

  UserProfileScreen({
    required this.user
  });
  
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState(user:user);
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<File?> dogs = [];
  final User user;
  _UserProfileScreenState({required this.user});
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
                  backgroundImage: user.profilePhoto != null
                      ? FileImage(user.profilePhoto!)
                      : null,
                  child: user.profilePhoto == null
                      ? Icon(Icons.account_circle, size: 50)
                      : null,
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(user.name, style: TextStyle(fontSize: 18)),
                    Text(user.surname, style: TextStyle(fontSize: 18)),
                    Text(user.email, style: TextStyle(color: Colors.grey)),
                    Text(user.city, style: TextStyle(color: Colors.grey)),
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
              user.additionalInfo,
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
