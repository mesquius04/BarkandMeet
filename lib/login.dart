import 'package:flutter/material.dart';
import 'user_data.dart';
import 'home.dart';
import 'newAccountScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';

  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (UserData.validateUser(username, password)) {
      bool isFirstLogin = UserData.isFirstLogin(username); // Verificar si es el primer inicio de sesión
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => isFirstLogin ? NewAccountScreen() : HomeScreen()),
      );
    } else {
      setState(() {
        _errorMessage = 'Incorrect username or password';
        _usernameController.clear();
        _passwordController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SizedBox(height: 48),
            Text(
              'Iniciar sessió',
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Comfortaa',
                color: Colors.black,
              ),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 24),
            if (_errorMessage.isNotEmpty)
              Text(
                _errorMessage,
                style: TextStyle(color: Colors.red),
              ),
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Nom usuari',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Contasenya',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                ),
                onPressed: _login,
                child: Text('Següent'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

