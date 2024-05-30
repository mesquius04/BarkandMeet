import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class NewAccountScreen extends StatefulWidget {
  @override
  _NewAccountScreenState createState() => _NewAccountScreenState();
}

class _NewAccountScreenState extends State<NewAccountScreen> {
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
      });
    }
  }

  void _selectLocation() {
    setState(() {
      _locationController.text = '';
    });
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserProfileScreen(
            profilePhoto: _profilePhoto,
            name: _nameController.text,
            surname: _surnameController.text,
            email:
                'usuario@gmail.com', // Asumiendo un correo fijo para el ejemplo
            location: _locationController.text,
            additionalInfo: _additionalInfoController.text,
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
                          return 'Si us plau, selecciona la teva localització';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Informació addicional',
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
                      maxLines: 4,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Si us plau, introdueix informació addicional';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                        ),
                        onPressed: _saveProfile,
                        child: Text('Crear Perfil'),
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
