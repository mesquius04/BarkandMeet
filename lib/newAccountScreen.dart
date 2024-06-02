import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'user.dart';
import 'confirmation.dart'; // Cambiado el nombre del archivo importado

class NewAccountScreen extends StatefulWidget {
  final UserProfile user;

  NewAccountScreen({required this.user});

  @override
  _NewAccountScreenState createState() => _NewAccountScreenState(user: user);
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  UserProfile user;

  _NewAccountScreenState({required this.user});

  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _additionalInfoController = TextEditingController();
  final _locationController = TextEditingController();
  bool _isGossera = false;
  File? _profilePhoto;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profilePhoto = File(pickedFile.path);
        user.profilePhoto = File(pickedFile.path);
      });
    }
  }

  void _selectLocation() {
    setState(() {
      _locationController.text = '';
      user.city = '';
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Guardar los datos del usuario en UserData
      user.username = _usernameController.text.trim();
      user.profilePhoto = _profilePhoto;
      user.name = _nameController.text.trim();
      user.surname = _surnameController.text.trim();
      user.city = _locationController.text.trim();
      user.additionalInfo = _additionalInfoController.text.trim();

      // Afegir l'usuari a la base de dades
      _addUser(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileCreatedScreen(user: user),
        ),
      );
    }
  }

  Future<void> _addUser(BuildContext context) async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;

      // s'intenta afegir l'usuari a la base de dades
      await FirebaseFirestore.instance
          .collection("Usuaris")
          .doc(firebaseUser!.uid)
          .set({
        'username': user.username,
        'email': user.email,
        'name': user.name,
        'surname': user.surname,
        'numDogs': user.numDogs,
        'gossera': user.gossera,
        'premium': user.premium,
        'city': user.city,
        'additionalInfo': user.additionalInfo,
      });
    } catch (e) {
      // Si hi ha un error, mostra un missatge d'error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Hi ha hagut un error al crear el teu perfil. Si us plau, torna a intentar-ho.'),
            actions: [
              TextButton(
                child: const Text('Tancar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  // es crida aquest mètode per alliberar recursos de memòria quan no s'utilitzen.
  // en aquest cas es llibera la memòria dels controladors del correu i contrasenya
  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _surnameController.dispose();
    _locationController.dispose();
    _additionalInfoController.dispose();
    _profilePhoto = null;
    super.dispose();
  }

  void _showGosseraInfo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: Text(
              'Clica aquí només si vols que el teu perfil sigui considerat una gossera que pugui posar gossos en adopció.\n\n'
              'Si ets un propietari de gos o vols adoptar un ignora aquesta casella.'),
          actions: [
            TextButton(
              child: Text('Tancar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      'Registre',
                      style: TextStyle(
                        fontSize: 32,
                        fontFamily: 'Comfortaa',
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Foto de perfil',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Comfortaa',
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _pickImage,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: _profilePhoto != null
                                    ? FileImage(_profilePhoto!)
                                    : null,
                                child: _profilePhoto == null
                                    ? Icon(Icons.add_a_photo, size: 60)
                                    : null,
                              ),
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  value: _isGossera,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isGossera = value ?? false;
                                    });
                                  },
                                ),
                                Text('Gossera'),
                                IconButton(
                                  icon: Icon(Icons.help_outline),
                                  onPressed: _showGosseraInfo,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  labelText: "Nom d'usuari",
                                  labelStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Si us plau, introdueix el teu nom';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  labelText: 'Nom',
                                  labelStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Si us plau, introdueix el teu nom';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _surnameController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 2.0),
                                  ),
                                  labelText: 'Cognom',
                                  labelStyle: TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Si us plau, introdueix el teu cognom';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        labelText: 'Localització',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.location_on),
                          onPressed: _selectLocation,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Si us plau, introdueix la teva localització';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _additionalInfoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        labelText: 'Informació Addicional',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _saveProfile,
                        child: Text('Guardar Perfil'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
