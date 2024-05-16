import 'package:flutter/material.dart';
import 'login.dart';
import 'register.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/Fondo1.png',
            fit: BoxFit.cover,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        side: BorderSide(color: Colors.black),
                        minimumSize: Size(150, 50), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), 
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), 
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: Text('Log In'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: Size(150, 50), 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0), 
                        ),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), 
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text('Register'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
