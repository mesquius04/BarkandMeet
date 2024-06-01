import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'user.dart';
import 'confirmation.dart'; // Cambiado el nombre del archivo importado

class NewAccountScreen extends StatefulWidget {
  final User user;
  NewAccountScreen({required this.user});
  @override
  _NewAccountScreenState createState() => _NewAccountScreenState(user: user);
}

class _NewAccountScreenState extends State<NewAccountScreen> {
  final User user;
  _NewAccountScreenState({required this.user});

  final _formKey = GlobalKey<FormState>();
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
        user.profilePhoto=File(pickedFile.path);
      });
    }
  }

  void _selectLocation() {
    setState(() {
      _locationController.text = '';
      user.city='';
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Guardar los datos del usuario en UserData
      user.profilePhoto = _profilePhoto;
      user.name = _nameController.text;
      user.surname = _surnameController.text;
      user.city = _locationController.text;
      user.additionalInfo = _additionalInfoController.text;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileCreatedScreen(
            user: user
          ),
        ),
      );
    }
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.white,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey),
              onPressed: () {
                Navigator.pop(context);
              },
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
                    SizedBox(height: 48),
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
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Nom',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Comfortaa',
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    labelText: '',
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
                              ),
                              SizedBox(height: 16),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Cognom',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'Comfortaa',
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                child: TextFormField(
                                  controller: _surnameController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black, width: 2.0),
                                    ),
                                    labelText: '',
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
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
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
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Localització',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Comfortaa',
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        labelText: '',
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
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Informació Addicional',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Comfortaa',
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    TextFormField(
                      controller: _additionalInfoController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0),
                        ),
                        labelText: '',
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
