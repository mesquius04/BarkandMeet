import 'package:flutter/material.dart';
import 'main.dart';
import 'package:bark_and_meet/fonts/bark_meet_icons.dart';


class Mainpage extends StatefulWidget {
  


  @override
  _MainpageState createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  bool _showFilters = false;

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
  }

  @override
  Widget build(BuildContext context) {
return Scaffold(
  
      extendBodyBehindAppBar: true,
      
      appBar: _showFilters
          ? null: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, // Aquí se cambia el color de la flecha de regreso
        ),
          toolbarHeight: 150,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.black.withOpacity(0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        title: Padding(
            padding: const EdgeInsets.only(left: .0,top:25.0),
            
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text('${widget.myDog.name}', style: TextStyle(fontSize: 30)),
              //Text('@${widget.myDog.owner.username}', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
              Text('August', style: TextStyle(fontSize: 30,color: Colors.white)),
              Text('@Juanillo23', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(BarkMeet.points),
            color: Colors.white,
            onPressed: _toggleFilters,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: Image.asset(
              'assets/fondo.png', // Asegúrate de tener la imagen en tu carpeta assets
              fit: BoxFit.cover,
            ),
          ),
          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                Spacer(),
                // Botones inferiores
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent, // Elimina el color de fondo
                          shadowColor: Colors.transparent, // Elimina la sombra
                        ),
                        child: Container(
                          width: 74,
                          height: 74,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/Dislike.png'), // Ruta de la imagen
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent, // Elimina el color de fondo
                          shadowColor: Colors.transparent, // Elimina la sombra
                        ),
                        child: Container(
                          width: 74,
                          height: 74,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/Like.png'), // Ruta de la imagen
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // Botón central
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: Duration(milliseconds: 500),
                          transitionsBuilder: (BuildContext context, Animation<double> animation,
                              Animation<double> secondaryAnimation, Widget child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 1),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                          pageBuilder: (BuildContext context, Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                              return ProfileScreen(); //la pagina del perro
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent, // Elimina el color de fondo
                      shadowColor: Colors.transparent, // Elimina la sombra
                    ),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/keyboard_arrow_down.png'), // Ruta de la imagen
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
          // Menú de filtros deslizante
                Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: _showFilters ? MediaQuery.of(context).size.height / 3*2 : 0.0,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título y botón de cerrar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Actualment mostrant:', style: TextStyle(color: Colors.black, fontSize: 16)),
                          IconButton(
                            icon: Icon(Icons.close, color: Colors.black),
                            onPressed: _toggleFilters,
                          ),
                        ],
                      ),
                      // Filtros de "En adopció" y "No en adopció"
                      Row(
                        children: [
                          FilterOption(label: 'En adopció'),
                          FilterOption(label: 'No en adopció'),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Título "Genère"
                      Text('Genère', style: TextStyle(color: Colors.black, fontSize: 16)),
                      SizedBox(height: 8),
                      // Filtros de "Mascle" y "Femella"
                      Row(
                        children: [
                          FilterOption(label: 'Mascle'),
                          FilterOption(label: 'Femella'),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Título "Estat Sexual"
                      Text('Estat Sexual', style: TextStyle(color: Colors.black, fontSize: 16)),
                      SizedBox(height: 8),
                      // Filtros de "Fèrtil" y "Infèrtil"
                      Row(
                        children: [
                          FilterOption(label: 'Fèrtil'),
                          FilterOption(label: 'Infèrtil'),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Título "Mida"
                      Text('Mida', style: TextStyle(color: Colors.black, fontSize: 16)),
                      SizedBox(height: 8),
                      // Filtros de "Petit", "Mitjà" y "Gran"
                      Row(
                        children: [
                          FilterOption(label: 'Petit'),
                          FilterOption(label: 'Mitjà'),
                          FilterOption(label: 'Gran'),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Botón de aplicar filtros
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Lógica para aplicar los filtros
                          },
                          child: Text('Aplicar filtres',style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black, // Color de fondo del botón
                            
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.black,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(BarkMeet.step, color: Colors.black),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(BarkMeet.message),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(BarkMeet.map),
                  label: 'Mapa',
                ),
                BottomNavigationBarItem(
                  icon: Icon(BarkMeet.person),
                  label: 'Perfil',
                ),
              ],
              type: BottomNavigationBarType.fixed,
            ),
          );
        }
      }



class FilterOption extends StatefulWidget {
  final String label;

  FilterOption({required this.label});

  @override
  _FilterOptionState createState() => _FilterOptionState();
}

class _FilterOptionState extends State<FilterOption> {
  bool _isSelected = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            _isSelected = !_isSelected;
          });
        },
        child: Row(
          children: [
            Checkbox(
              value: _isSelected,
              onChanged: (bool? value) {
                setState(() {
                  _isSelected = value ?? false;
                });
              },
              activeColor: Colors.black,
            ),
            Text(
              widget.label,
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}


class ProfileScreen extends StatelessWidget {

  ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("August"),
      ),
      body: Center(
        child: Text('Perfil de August'),
      ),
    );
  }
}