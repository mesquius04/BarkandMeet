// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../model/dog.dart';
import 'package:flutter/material.dart';

class DogProfileScreen extends StatelessWidget {
  final Dog currentdog;

  DogProfileScreen({super.key, required this.currentdog});

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
            overflow: TextOverflow.ellipsis,
            'Perfil gos',
            style: TextStyle(
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
                      items: currentdog.photosUrls?.isEmpty ?? true
                          ? []
                          : List.generate(currentdog.photosUrls!.length,
                              (index) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  currentdog.photosUrls![index],
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }),
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        initialPage: 1,
                        // Start from the first photo
                        viewportFraction: 0.5,
                        disableCenter: true,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.25,
                        enableInfiniteScroll: false,
                        // Disable infinite scroll
                        scrollDirection: Axis.horizontal,
                        autoPlay: false,
                        onPageChanged: (index, _) =>
                            _carouselController = index as CarouselController,
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 4),
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  currentdog.name,
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 20,
                    letterSpacing: 0,
                  ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        "@${currentdog.ownerUsername}",
                        style: TextStyle(
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
                        overflow: TextOverflow.ellipsis,
                        "Barcelona, Glories",
                        style: TextStyle(
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
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 0, 0),
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
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      currentdog.raca2,
                                      style: TextStyle(
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
                                        overflow: TextOverflow.ellipsis,
                                        currentdog.male ? 'Masculí' : 'Femení',
                                        style: TextStyle(
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
                                      overflow: TextOverflow.ellipsis,
                                      currentdog.dateOfBirth,
                                      style: TextStyle(
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
                                      overflow: TextOverflow.ellipsis,
                                      currentdog.castrat
                                          ? "Está castrat"
                                          : "No está castrat",
                                      style: TextStyle(
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
                  overflow: TextOverflow.ellipsis,
                  currentdog.description,
                  maxLines: 4,
                  style: TextStyle(
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
                  overflow: TextOverflow.ellipsis,
                  'Mida',
                  style: TextStyle(
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
                        overflow: TextOverflow.ellipsis,
                        '0',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: LinearPercentIndicator(
                          percent: currentdog.size / 5,
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
                        overflow: TextOverflow.ellipsis,
                        '5',
                        style: TextStyle(
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
                  overflow: TextOverflow.ellipsis,
                  'Resistencia',
                  style: TextStyle(
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
                        overflow: TextOverflow.ellipsis,
                        '0',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: LinearPercentIndicator(
                          percent: currentdog.endurance / 5,
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
                        overflow: TextOverflow.ellipsis,
                        '5',
                        style: TextStyle(
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
                  overflow: TextOverflow.ellipsis,
                  'Mogudesa',
                  style: TextStyle(
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
                        overflow: TextOverflow.ellipsis,
                        '0',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: LinearPercentIndicator(
                          percent: currentdog.activityLevel / 5,
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
                        overflow: TextOverflow.ellipsis,
                        '5',
                        style: TextStyle(
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
                  overflow: TextOverflow.ellipsis,
                  'Sociabilitat',
                  style: TextStyle(
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
                        overflow: TextOverflow.ellipsis,
                        '0',
                        style: TextStyle(
                          fontFamily: 'Plus Jakarta Sans',
                          letterSpacing: 0,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                        child: LinearPercentIndicator(
                          percent: currentdog.sociability / 5,
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
                        overflow: TextOverflow.ellipsis,
                        '5',
                        style: TextStyle(
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
                          overflow: TextOverflow.ellipsis,
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
