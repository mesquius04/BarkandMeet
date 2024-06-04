// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'dog.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  Dog currentdog;
  ProfileScreen({super.key, required this.currentdog});
   CarouselController _carouselController = CarouselController();

   @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      child: Scaffold(
        backgroundColor: Color(0xFFF1F4F8),
        appBar: AppBar(
          
          automaticallyImplyLeading: false,
          leading: IconButton(
  style: ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.transparent, width: 1),
      ),
    ),
  ),
  icon: Icon(
    Icons.arrow_back,
    color: Colors.black,
    size: 24,
  ),
            onPressed: () {
  Navigator.pop(context);
},
          ),
          title: Text(
            'Perfil gos',
            style:  TextStyle(
                  fontFamily: 'Urbanist',
                  color: Colors.black,
                  fontSize: 22,
                  letterSpacing: 0,
                ),
          ),
          actions: const [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
  padding: EdgeInsetsDirectional.fromSTEB(0, 26, 0, 0),
  child: SizedBox(
    width: double.infinity,
    height: 180,
    child: CarouselSlider(
      items: currentdog.dogPhotos.map((photo) {
  if (photo != null) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.file(
        photo,
        width: 300,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  } else {
    return Container(); // or some other default widget
  }
}).toList(),
      carouselController: _carouselController ??= CarouselController(),
      options: CarouselOptions(
        initialPage: 1,
        viewportFraction: 0.5,
        disableCenter: true,
        enlargeCenterPage: true,
        enlargeFactor: 0.25,
        enableInfiniteScroll: true,
        scrollDirection: Axis.horizontal,
        autoPlay: false,
        onPageChanged: (index, _) => _carouselController = index as CarouselController,
      ),
    ),
  ),
),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 4),
                child: Text(
                  'Nombre perro',
                  style:  TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 20,
                        letterSpacing: 0,
                      ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: Text(
                        '@user',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                      child: Text(
                        'Ubication',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(45, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.pets,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'Raça',
                                      style:  TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.male_sharp,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          5, 0, 0, 0),
                                      child: Text(
                                        'Generé',
                                        style:  TextStyle(
                                              fontFamily: 'Plus Jakarta Sans',
                                              letterSpacing: 0,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(1, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 45, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      Icons.cake_sharp,
                                      color: Colors.black,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      print('IconButton pressed ...');
                                    },
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        5, 0, 0, 0),
                                    child: Text(
                                      'Aniversari',
                                      style:  TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.child_care,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        print('IconButton pressed ...');
                                      },
                                    ),
                                    Text(
                                      'Castedad',
                                      style:  TextStyle(
                                            fontFamily: 'Plus Jakarta Sans',
                                            letterSpacing: 0,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(35, 15, 35, 0),
                child: Text(
                  'The best of all 3 worlds, Row & Flow offers high intensity rowing and strength intervals followed by athletic based yoga sure to enhance flexible and clear the mind. Yoga mats are provided but bringing your own yoga mat is highly encouraged.',
                  maxLines: 4,
                  style:  TextStyle(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 16,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Text(
                  'Mida',
                  style:  TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 17,
                        letterSpacing: 0,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(40, 0, 15, 0),
                      child: Text(
                        '0',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: LinearPercentIndicator(
                          percent: 0.6,
                          width: MediaQuery.sizeOf(context).width * 0.67,
                          lineHeight: 15,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: Color(0xFF827AE1),
                          backgroundColor: Color(0xFFE0E3E7),
                          barRadius: Radius.circular(24),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 40, 0),
                      child: Text(
                        '5',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Text(
                  'Resistencia',
                  style:  TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 17,
                        letterSpacing: 0,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(40, 0, 15, 0),
                      child: Text(
                        '0',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: LinearPercentIndicator(
                          percent: 0.6,
                          width: MediaQuery.sizeOf(context).width * 0.67,
                          lineHeight: 15,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: Color(0xFF827AE1),
                          backgroundColor: Color(0xFFE0E3E7),
                          barRadius: Radius.circular(24),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 40, 0),
                      child: Text(
                        '5',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Text(
                  'Mogudesa',
                  style:  TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 17,
                        letterSpacing: 0,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(40, 0, 15, 0),
                      child: Text(
                        '0',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: LinearPercentIndicator(
                          percent: 0.6,
                          width: MediaQuery.sizeOf(context).width * 0.67,
                          lineHeight: 15,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: Color(0xFF827AE1),
                          backgroundColor: Color(0xFFE0E3E7),
                          barRadius: Radius.circular(24),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 40, 0),
                      child: Text(
                        '5',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                child: Text(
                  'Sociabilitat',
                  style:  TextStyle(
                        fontFamily: 'Plus Jakarta Sans',
                        fontSize: 17,
                        letterSpacing: 0,
                      ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(40, 0, 15, 0),
                      child: Text(
                        '0',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: LinearPercentIndicator(
                          percent: 0.6,
                          width: MediaQuery.sizeOf(context).width * 0.67,
                          lineHeight: 15,
                          animation: true,
                          animateFromLastPercent: true,
                          progressColor: Color(0xFF827AE1),
                          backgroundColor: Color(0xFFE0E3E7),
                          barRadius: Radius.circular(24),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(15, 0, 40, 0),
                      child: Text(
                        '5',
                        style:  TextStyle(
                              fontFamily: 'Plus Jakarta Sans',
                              letterSpacing: 0,
                            ),
                      ),
                    ),
                    
                  ],
                ),
              ),
              Padding(
    padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      children: const [
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              '',
              style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    letterSpacing: 0,
                  ),
            ),
          ),
        ),
      ],
    ),
  ),

            ],
          ),
        ),
      ),
    );
  }
}