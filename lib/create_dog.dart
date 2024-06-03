// ignore_for_file: sort_child_properties_last

import 'package:bark_and_meet/dog.dart';
import 'package:bark_and_meet/user.dart';
import 'package:bark_and_meet/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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



  final _textController1Validator =  GlobalKey<FormState>();
  final textFieldFocusNode1 = FocusNode();

  final textController2 = TextEditingController();
  final textFieldFocusNode2 = FocusNode();

  final textController3 = TextEditingController();
  final textFieldFocusNode3 = FocusNode();

    
    var dropDownValue1;var dropDownValue2;var dropDownValue3;
    int sliderValue1 = 5;
    int sliderValue2 = 5;
    int sliderValue3 = 5;
    int sliderValue4 = 5;
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
      raca: "null", 
      size: 0, 
      endurance: 0, 
      sociability: 0, 
      activityLevel: 0,
    );
  }

 
  
  File? _dogPhoto;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _dogPhoto = File(pickedFile.path);
        dog?.dogPhoto=File(pickedFile.path);
      });
    }
  }



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton( //TICK
          icon: Icon(Icons.arrow_back,size: 24,),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>  UserProfileScreen(user: user),
              ),
            );
          },
        ),
        title: Text('Crear perfil',), //TITULO
        actions: [
          IconButton(
            icon: Icon(Icons.check,size: 24,),
            onPressed: () {
              print('CHECKEANDO LA INFO ES CORRECTA');
            },
          ),
          ],
        centerTitle: true,
        elevation: 2,
      ),


      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
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
                            borderRadius: BorderRadius.circular(8), // Move it here
                          ),
                        ),
                        validator: (value) {  
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid date of birth';
                        } else {
                          try {
                            DateTime.parse(value);
                          } catch (e) {
                            return 'Invalid date format. Please use YYYY-MM-DD';
                          }
                        }
                        return null;
                        },
                        onSaved: (value) => dog?.dateOfBirth = DateTime.parse(value!), // or int.parse(value!),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                        child: TextFormField(
                          controller:  textController2,
                          focusNode:  textFieldFocusNode2,
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
                                color:  Color.fromARGB(255, 255, 0, 0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding:
                                EdgeInsetsDirectional.fromSTEB(15, 0, 0, 0),
                          ),
                          //style:
                          //validator:  textController2Validator.asValidator(context),
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
                                  'Genere',
                                  //style: 
                                ),
                              ),
                            ),
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0,
                                    ),
                                    child: DropdownButton<String>(
                                      value: dropDownValue1,
                                      onChanged: (val) => setState(() => dropDownValue1 = val),
                                      items: ['No', 'Sí'].map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
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
                            Text(
                              'Raça',
                               
                            ),
                            Flexible(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 5, 0, 0,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0,
                                    ),
                                    child: DropdownButton<String>(
                                      value: dropDownValue2,
                                      onChanged: (val) => setState(() => dropDownValue2 = val),
                                      items: ['No', 'Sí'].map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
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
                                    0, 5, 0, 0,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                      15, 0, 0, 0,
                                    ),
                                    child: DropdownButton<String>(
                                      value: dropDownValue3,
                                      onChanged: (val) => setState(() => dropDownValue3 = val),
                                      items: ['No', 'Sí'].map((e) {
                                        return DropdownMenuItem<String>(
                                          value: e,
                                          child: Text(e),
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
                                '         0',
                                 
                              ),
                            ),
                          ),
                          Flexible(
                            child: Slider(
                              activeColor: Color(0xFF6730B4),
                              //inactiveColor: FlutterFlowTheme.of(context).alternate,
                              min: 0,
                              max: 10,
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
                              '10',
                               
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
                                'Resistencia',
                                 
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
                              max: 10,
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
                              '10',
                               
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
                              max: 10,
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
                              '10',
                               
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
                              max: 10,
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
                              '10',
                               
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
                                controller:  textController3,
                                focusNode:  textFieldFocusNode3,
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
                                      color:  Color.fromARGB(255, 255, 0, 0),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:  Color.fromARGB(255, 255, 0, 0),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          15, 0, 0, 0),
                                ),
                                 
                               // validator: textController3.asValidator(context),
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlsVMLy_CE0EXDGSnLrMPU04z9_FZVRjYR5w&s',
                                    width: 105,
                                    height: 105,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlsVMLy_CE0EXDGSnLrMPU04z9_FZVRjYR5w&s',
                                    width: 105,
                                    height: 105,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: AlignmentDirectional(1, 0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlsVMLy_CE0EXDGSnLrMPU04z9_FZVRjYR5w&s',
                                    width: 105,
                                    height: 105,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),),]),
              ),);

  }
}
