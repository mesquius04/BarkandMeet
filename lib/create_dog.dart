import 'package:bark_and_meet/dog.dart';
import 'package:bark_and_meet/user.dart';
import 'package:bark_and_meet/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';

class DogCreateScreen extends StatefulWidget {
  final UserProfile user;

  DogCreateScreen({required this.user});

  @override
  _DogCreateState createState() => _DogCreateState(user: user);
}

class _DogCreateState extends State<DogCreateScreen> {
  final UserProfile user;
  Dog? dog;

  _DogCreateState({required this.user});

  final dateController = TextEditingController();
  final textFieldFocusNode1 = FocusNode();

  final textController2 = TextEditingController();
  final textFieldFocusNode2 = FocusNode();

  final textController3 = TextEditingController();
  final textFieldFocusNode3 = FocusNode();

  final textRacaController = TextEditingController();

  bool? dropDownValue1;
  bool? dropDownValue2;
  bool? dropDownValue3;

  int sliderValue1 = 3;
  int sliderValue2 = 3;
  int sliderValue3 = 3;
  int sliderValue4 = 3;

  @override
  void initState() {
    super.initState();
    dog = Dog(
      name: "null",
      owner: user,
      age: 0,
      adopcio: false,
      castrat: false,
      male: false,
      raca: false,
      size: 0,
      endurance: 0,
      sociability: 0,
      activityLevel: 0,
      friends: [],
      // or some other default value
      dogPhotos: [null, null, null], // or some other default value
    );
  }

  File? _imageFile1;
  File? _imageFile2;
  File? _imageFile3;
  String defaultPhoto =
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlsVMLy_CE0EXDGSnLrMPU04z9_FZVRjYR5w&s';

  void _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        if (_imageFile1 == null) {
          _imageFile1 = File(image.path);
        } else if (_imageFile2 == null) {
          _imageFile2 = File(image.path);
        } else if (_imageFile3 == null) {
          _imageFile3 = File(image.path);
        }
      });
    }
  }

  bool _validateForm() {
    if (dateController.text.isEmpty) return false;

    if (textRacaController.text.isEmpty) return false;

    if (textController2.text.isEmpty) return false;
    print("\n1\n");
    if (dropDownValue1 == null) return false;
    print("\n2\n");
    if (dropDownValue2 == null) return false;
    print("\n3\n");
    if (dropDownValue3 == null) return false;
    print("\n4\n");
    if (sliderValue1 == 0) return false;
    print("\n5\n");
    if (sliderValue2 == 0) return false;
    print("\n6\n");
    if (sliderValue3 == 0) return false;
    print("\n7\n");
    if (sliderValue4 == 0) return false;
    print("\n8\n");
    if (textController3.text.isEmpty) return false;
    print("\n9\n");
    if (_imageFile1 == null || _imageFile2 == null || _imageFile3 == null)
      return false;
    print("\n10\n");

    return true;
  }

  void _saveDog() {
    dog?.name = textController2.text;
    dog?.male = dropDownValue1!;
    dog?.raca = dropDownValue2!;
    dog?.castrat = dropDownValue3!;
    dog?.size = sliderValue1;
    dog?.endurance = sliderValue2;
    dog?.sociability = sliderValue3;
    dog?.activityLevel = sliderValue4;
    dog?.description = textController3.text;
    dog?.dogPhoto = _imageFile1;
    print("\n9\n");
    dog?.dogPhotos.add(_imageFile1!);
    dog?.dogPhotos.add(_imageFile2!);
    dog?.dogPhotos.add(_imageFile3!);

    user.dogs.add(dog!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            'Crear perfil',
          ),
          //TITULO
          actions: [
            IconButton(
              icon: Icon(
                Icons.check,
                size: 24,
              ),
              onPressed: () {
                if (_validateForm()) {
                  _saveDog();
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(user: user),
                    ),
                  );
                } else {
                  print('Form is not valid');
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
              alignment: AlignmentDirectional(0, 0),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(25, 15, 25, 0),
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: TextFormField(
                          controller: textController2,
                          focusNode: textFieldFocusNode2,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Nom',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF020202),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
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
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: TextFormField(
                          controller: dateController,
                          focusNode: textFieldFocusNode1,
                          autofocus: true,
                          textCapitalization: TextCapitalization.none,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Data de naixement',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(
                                new FocusNode()); // to prevent opening default keyboard
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
                              dog?.dateOfBirth = DateTime.parse(value!),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: TextFormField(
                          controller: textRacaController,
                          focusNode: textFieldFocusNode2,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            labelText: 'Raça',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 255, 0, 0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
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
                        padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
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
                                alignment: AlignmentDirectional(1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    5,
                                    0,
                                    0,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      15,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: DropdownButton<bool>(
                                      value: dropDownValue1,
                                      onChanged: (val) => setState(
                                          () => dropDownValue1 = val ?? false),
                                      items: [true, false].map((e) {
                                        return DropdownMenuItem<bool>(
                                          value: e,
                                          child: Text(e ? 'Mascle' : 'Femella'),
                                        );
                                      }).toList(),
                                      hint: Text('Selecciona'),
                                      icon: Icon(
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
                        padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(1, 0, 14, 0),
                              child: Text(
                                'Castrat',
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0,
                                    5,
                                    0,
                                    0,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      15,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: DropdownButton<bool>(
                                      value: dropDownValue3,
                                      onChanged: (val) => setState(
                                          () => dropDownValue3 = val ?? false),
                                      items: [true, false].map((e) {
                                        return DropdownMenuItem<bool>(
                                          value: e,
                                          child: Text(e ? 'Sí' : 'No'),
                                        );
                                      }).toList(),
                                      hint: Text('Selecciona'),
                                      icon: Icon(
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
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Text(
                                'Mida',
                              ),
                            ),
                          ),
                          Align(
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
                              activeColor: Color(0xFF6730B4),
                              //inactiveColor: FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 5,
                              value: sliderValue1.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  sliderValue1 = newValue.toInt();
                                });
                              },
                            ),
                          ),
                          Padding(
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
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Text(
                                'Resistència',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: Text(
                              ' 0',
                            ),
                          ),
                          Flexible(
                            child: Slider(
                              activeColor: Color(0xFF6730B4),
                              //inactiveColor: FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 5,
                              value: sliderValue2.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  sliderValue2 = newValue.toInt();
                                });
                              },
                            ),
                          ),
                          Padding(
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
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Text(
                                'Mogudesa',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(18, 0, 0, 0),
                            child: Text(
                              '  0',
                            ),
                          ),
                          Flexible(
                            child: Slider(
                              activeColor: Color(0xFF6730B4),
                              //inactiveColor: FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 5,
                              value: sliderValue3.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  sliderValue3 = newValue.toInt();
                                });
                              },
                            ),
                          ),
                          Padding(
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
                          Align(
                            alignment: AlignmentDirectional(-1, 0),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                              child: Text(
                                'Sociabilitat',
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                            child: Text(
                              ' 0',
                            ),
                          ),
                          Flexible(
                            child: Slider(
                              activeColor: Color(0xFF6730B4),
                              //inactiveColor: FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 5,
                              value: sliderValue4.toDouble(),
                              onChanged: (newValue) {
                                setState(() {
                                  sliderValue4 = newValue.toInt();
                                });
                              },
                            ),
                          ),
                          Padding(
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
                                  EdgeInsetsDirectional.fromSTEB(8, 2, 8, 0),
                              child: TextFormField(
                                controller: textController3,
                                focusNode: textFieldFocusNode3,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText:
                                      'Escriu una descripció de la teva mascota',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      // color: FlutterFlowTheme.of(context).alternate,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      //color:FlutterFlowTheme.of(context).primary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 0, 0),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
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
                      Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(15, 7, 0, 0),
                          child: Text(
                            'Fotos',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: GestureDetector(
                                  onTap: () => _pickImage(),
                                  child: _imageFile1 != null
                                      ? Image.file(_imageFile1!,
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
                                alignment: AlignmentDirectional(0, 0),
                                child: GestureDetector(
                                  onTap: () => _pickImage(),
                                  child: _imageFile2 != null
                                      ? Image.file(_imageFile2!,
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
                                alignment: AlignmentDirectional(1, 0),
                                child: GestureDetector(
                                  onTap: () => _pickImage(),
                                  child: _imageFile3 != null
                                      ? Image.file(_imageFile3!,
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
