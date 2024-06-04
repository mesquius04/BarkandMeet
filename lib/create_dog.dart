import 'package:bark_and_meet/dog.dart';
import 'package:bark_and_meet/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class DogCreateScreen extends StatefulWidget {
  final UserProfile user;

  const DogCreateScreen({super.key, required this.user});

  @override
  _DogCreateState createState() => _DogCreateState(user: user);
}

class _DogCreateState extends State<DogCreateScreen> {
  UserProfile user;
  Dog? dog;

  _DogCreateState({required this.user});

  final dateController = TextEditingController();
  final textFieldFocusNode1 = FocusNode();

  final nomTextController2 = TextEditingController();
  final textFieldFocusNode2 = FocusNode();

  final descripcioTextController3 = TextEditingController();
  final textFieldFocusNode3 = FocusNode();

  final racaTextController = TextEditingController();

  bool? maleDropDownValue1 = false;
  bool? castratDropDownValue3 = false;

  int midaSliderValue1 = 3;
  int resistenciaSliderValue2 = 3;
  int mogudesaSliderValue3 = 3;
  int sociabilitatSliderValue4 = 3;

  @override
  void initState() {
    super.initState();
    dog = Dog(
      name: "null",
      owner: user,
      dateOfBirth: "03-05-2024",
      adopcio: false,
      castrat: false,
      male: false,
      size: 0,
      endurance: 0,
      sociability: 0,
      activityLevel: 0,
      friends: [],
      // or some other default value
      dogPhotos: [null, null, null], // or some other default value
    );
  }

  List<File?> images = [null, null, null];

  String defaultPhoto =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlsVMLy_CE0EXDGSnLrMPU04z9_FZVRjYR5w&s';

  void _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        for (int i = 0; i < images.length; i++) {
          if (images[i] == null) {
            images[i] = File(image.path);
            break;
          }
        }
      });
    }
  }

  bool _validateForm() {
    if (dateController.text.isEmpty) return false;

    if (racaTextController.text.isEmpty) return false;

    if (nomTextController2.text.isEmpty) return false;


    if (maleDropDownValue1 == null) return false;


    if (castratDropDownValue3 == null) return false;

    if (midaSliderValue1 == 0) return false;


    if (descripcioTextController3.text.isEmpty) return false;

    if (images[0] == null) {
      return false;
    }

    return true;
  }

  Future<void> _saveDog() async {

    // Guardar les noves dades de dog
    dog!.name = nomTextController2.text.trim();
    dog!.dateOfBirth = dateController.text.trim();
    dog!.raca2 = racaTextController.text.trim();
    dog!.description = descripcioTextController3.text.trim();

    dog!.adopcio = user.gossera;
    dog!.castrat = castratDropDownValue3!;
    dog!.male = maleDropDownValue1!;

    dog!.size = midaSliderValue1;
    dog!.endurance = resistenciaSliderValue2;
    dog!.sociability = sociabilitatSliderValue4;
    dog!.activityLevel = mogudesaSliderValue3;

    user.numDogs++;

    List<String> photosUrl = await _savePhotosInCloud();

    dog!.photosUrls = photosUrl;

    await _addDogInCloud(context, photosUrl);


    //user.dogs.add(dog!);
  }

  Future<void> _addDogInCloud(BuildContext context, List<String> photosUrl) async {
    try {
      User? firebaseUser = FirebaseAuth.instance.currentUser;

      dog!.ownerId = firebaseUser!.uid;

      // Guardar el gos a Firebase Firestore

      String dogId = "${firebaseUser.uid}_${user.numDogs}";

      await FirebaseFirestore.instance.collection('Gossos').doc(dogId).set({
        'name': dog?.name,
        'ownerId': firebaseUser.uid,
        'birthday': dog?.dateOfBirth,
        'adoption': dog?.adopcio,
        'castrat': dog?.castrat,
        'city': user.city,
        'description': dog?.description,
        'endurance': dog?.endurance,
        'activityLevel': dog?.activityLevel,
        'size': dog?.size,
        'sociability': dog?.sociability,
        'raça': dog?.raca2,
        'male': dog?.male,
        'photosUrls': photosUrl,
      });

      // afegir el gos a la llista de gossos del usuari i actualitzar numDogs a firestore
      await FirebaseFirestore.instance.collection('Usuaris').doc(firebaseUser.uid).update({
        'dogs': FieldValue.arrayUnion([dogId]),
        'numDogs': user.numDogs,
      });

    } catch (e) {
      // Si hi ha un error, mostra un missatge d'error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Hi ha hagut un error al guardar el gos. Si us plau, torna a intentar-ho.'),
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

  // Guarda la foto a Firebase Storage i retorna la url de la foto
  Future<List<String>> _savePhotosInCloud() async {
    String photoURL = "";
    List<String> photosUrls = [];

    // iterar per la llista de fotos per guardar-les a Firebase Storage les no nules
    for (int i = 0; i < images.length; i++) {
      if (images[i] != null) {
        try {
          User? firebaseUser = FirebaseAuth.instance.currentUser;

          // Guardar la foto a Firebase Storage
          String photoUrlUpload = '${firebaseUser!.uid}/gos_${user.numDogs}/foto_$i.jpeg';
          await FirebaseStorage.instance.ref(photoUrlUpload).putFile(images[i]!);

          // agafar la url de la foto pujada
          photoURL = await FirebaseStorage.instance.ref(photoUrlUpload).getDownloadURL();
          photosUrls.add(photoURL);
        } catch (e) {
          // Si hi ha un error, mostra un missatge d'error
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: const Text(
                    'Hi ha hagut un error al guardar una foto. Si us plau, torna a intentar-ho.'),
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
    }

    return photosUrls;
  }

  // es crida aquest mètode per alliberar recursos de memòria quan no s'utilitzen.
  // en aquest cas es llibera la memòria dels controladors del correu i contrasenya
  @override
  void dispose() {
    dateController.dispose();
    racaTextController.dispose();
    nomTextController2.dispose();
    descripcioTextController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text(
            'Crear perfil',
          ),
          //TITULO
          actions: [
            IconButton(
              icon: const Icon(
                Icons.check,
                size: 24,
              ),
              onPressed: () async {
                if (_validateForm())  {
                  await _saveDog();
                  Navigator.of(context).pop();

                } else {
                  // Mostrar un diàleg d'error
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text(
                            'Si us plau, omple tots els camps abans de guardar.'),
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
              },
            ),
          ],
          centerTitle: true,
          elevation: 2,
        ),
        body: SingleChildScrollView(
            child: SafeArea(
          top: true,
          child: Column(mainAxisSize: MainAxisSize.max, children: [
            Align(
              alignment: const AlignmentDirectional(0, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(25, 15, 25, 0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: TextFormField(
                          controller: nomTextController2,
                          focusNode: textFieldFocusNode2,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Nom',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xFF020202),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                          ),
                          //style:
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce un nombre';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: TextFormField(
                          controller: dateController,
                          focusNode: textFieldFocusNode1,
                          autofocus: true,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Data de naixement',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(
                                FocusNode()); // to prevent opening default keyboard
                            final DateTime? picked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (picked != null) {
                              DateFormat dateFormat = DateFormat(
                                  "dd-MM-yyyy"); // Format date to "DD-MM-YYYY"
                              String formattedDate = dateFormat.format(picked);
                              dateController.text =
                                  formattedDate; // format output
                            }
                            return;
                          },
                          onSaved: (value) =>
                              dog?.dateOfBirth = value.toString(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: TextFormField(
                          controller: racaTextController,
                          focusNode: FocusNode(),
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Raça',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                const EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                          ),
                          //style:
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, introduce un nombre';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                                child: Text(
                                  'Gènere',
                                  //style:
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: const AlignmentDirectional(1, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    5,
                                    0,
                                    0,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                      15,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: DropdownButton<bool>(
                                      value: maleDropDownValue1,
                                      onChanged: (val) => setState(
                                          () => maleDropDownValue1 = val ?? false),
                                      items: [true, false].map((e) {
                                        return DropdownMenuItem<bool>(
                                          value: e,
                                          child: Text(e ? 'Mascle' : 'Femella'),
                                        );
                                      }).toList(),
                                      hint: const Text('Selecciona'),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 24,
                                      ),
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(1, 0, 14, 0),
                              child: Text(
                                'Castrat',
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: const AlignmentDirectional(1, 0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    5,
                                    0,
                                    0,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                      15,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: DropdownButton<bool>(
                                      value: castratDropDownValue3,
                                      onChanged: (val) => setState(
                                          () => castratDropDownValue3 = val ?? false),
                                      items: [true, false].map((e) {
                                        return DropdownMenuItem<bool>(
                                          value: e,
                                          child: Text(e ? 'Sí' : 'No'),
                                        );
                                      }).toList(),
                                      hint: const Text('Selecciona'),
                                      icon: const Icon(
                                        Icons.keyboard_arrow_down_rounded,
                                        size: 24,
                                      ),
                                      elevation: 2,
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Text(
                                'Mida',
                              ),
                            ),
                          ),
                          const Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(40, 0, 0, 0),
                              child: Text(
                                '      0',
                              ),
                            ),
                          ),
                          Flexible(
                            child: Slider(
                              activeColor: const Color(0xFF6730B4),
                              //inactiveColor: FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 5,
                              value: midaSliderValue1.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  midaSliderValue1 = newValue.toInt();
                                });
                              },
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                            child: Text(
                              '5',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Text(
                                'Resistència',
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: Text(
                              ' 0',
                            ),
                          ),
                          Flexible(
                            child: Slider(
                              activeColor: const Color(0xFF6730B4),
                              //inactiveColor: FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 5,
                              value: resistenciaSliderValue2.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  resistenciaSliderValue2 = newValue.toInt();
                                });
                              },
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                            child: Text(
                              '5',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Text(
                                'Mogudesa',
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                            child: Text(
                              '  0',
                            ),
                          ),
                          Flexible(
                            child: Slider(
                              activeColor: const Color(0xFF6730B4),
                              //inactiveColor: FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 5,
                              value: mogudesaSliderValue3.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  mogudesaSliderValue3 = newValue.toInt();
                                });
                              },
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                            child: Text(
                              '5',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Text(
                                'Sociabilitat',
                              ),
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: Text(
                              ' 0',
                            ),
                          ),
                          Flexible(
                            child: Slider(
                              activeColor: const Color(0xFF6730B4),
                              //inactiveColor: FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 5,
                              value: sociabilitatSliderValue4.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  sociabilitatSliderValue4 = newValue.toInt();
                                });
                              },
                            ),
                          ),
                          const Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                            child: Text(
                              '5',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(8, 2, 8, 0),
                              child: TextFormField(
                                controller: descripcioTextController3,
                                focusNode: textFieldFocusNode3,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      'Escriu una descripció de la teva mascota',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      // color: FlutterFlowTheme.of(context).alternate,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      //color:FlutterFlowTheme.of(context).primary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Por favor, introduce un nombre';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 7, 0, 0),
                          child: Text(
                            'Fotos',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: const AlignmentDirectional(-1, 0),
                                child: GestureDetector(
                                  onTap: () => _pickImage(),
                                  child: images[0] != null
                                      ? Image.file(images[0]!,
                                          width: 105,
                                          height: 105,
                                          fit: BoxFit.cover)
                                      : Image.network(defaultPhoto,
                                          width: 105,
                                          height: 105,
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: const AlignmentDirectional(0, 0),
                                child: GestureDetector(
                                  onTap: () => _pickImage(),
                                  child: images[1] != null
                                      ? Image.file(images[1]!,
                                          width: 105,
                                          height: 105,
                                          fit: BoxFit.cover)
                                      : Image.network(defaultPhoto,
                                          width: 105,
                                          height: 105,
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: const AlignmentDirectional(1, 0),
                                child: GestureDetector(
                                  onTap: () => _pickImage(),
                                  child: images[2] != null
                                      ? Image.file(images[2]!,
                                          width: 105,
                                          height: 105,
                                          fit: BoxFit.cover)
                                      : Image.network(defaultPhoto,
                                          width: 105,
                                          height: 105,
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
            )
          ]),
        )));
  }
}
