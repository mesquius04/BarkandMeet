
import 'package:flutter/material.dart';

import '../model/user.dart';
class MapScreen extends StatefulWidget {
  final UserProfile user;
  MapScreen({super.key, required this.user});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Text(
            'Mapa',
            style: TextStyle(
                  fontFamily: 'Comfortaa',
                  fontSize: 22,
                  letterSpacing: 0,
                ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: AlignmentDirectional(1, 0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://cdn.discordapp.com/attachments/656490313405300736/1247960785137827900/image.png?ex=6661ed8d&is=66609c0d&hm=48f2841d011bf0063995a6709f6ad0e43396952793e43bb66f23896d55bc9cad&',
                          width: double.infinity,
                          height: 450,
                          fit: BoxFit.fitHeight,
                          alignment: Alignment(0, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
  mainAxisSize: MainAxisSize.max,
  children: [
    Padding(
      padding: EdgeInsets.all(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.network(
          'https://cdn.discordapp.com/attachments/656490313405300736/1247965938985472060/image.png?ex=6661f259&is=6660a0d9&hm=82dcd022d7a9b513a1842ac9c47d8ac0e37f2cc1d0232f883520a110e68dcec2&',
          width: 125,
          height: 125,
          fit: BoxFit.contain,
        ),
      ),
    ),
    Padding(
      padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
            child: Text(
              'Parc del Clot',
              style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 18,
                    letterSpacing: 0,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
            child: Text(
              '800 m',
              style: TextStyle(
                    fontFamily: 'Readex Pro',
                    fontSize: 15,
                    letterSpacing: 0,
                  ),
            ),
          ),
          Text(
            'C/ dels Escultors Claperós',
            textAlign: TextAlign.start,
            maxLines: 2,
            style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 15,
                  letterSpacing: 0,
                ),
          ),
          Text(
            '55, 63, Sant Mart',
            style: TextStyle(
                  fontFamily: 'Readex Pro',
                  fontSize: 15,
                  letterSpacing: 0,
                ),
          ),
        ],
      ),
    ),
  ],
),


          ],
        ),
      ),
    );
  }
}