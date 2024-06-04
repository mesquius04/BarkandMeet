import 'package:flutter/material.dart';
import 'dog.dart';
import 'user.dart';
import 'mapa.dart';
import 'HomeScreen.dart';
import 'user_profile.dart';
import 'dogProfile.dart';
import 'package:bark_and_meet/fonts/bark_meet_icons.dart';

class Mainpage extends StatefulWidget {
  final UserProfile user;

  const Mainpage({super.key, required this.user});

  @override
  _MainpageState createState() => _MainpageState(user: user);
}

class _MainpageState extends State<Mainpage> {
  final UserProfile user;
  _MainpageState({required this.user});
  bool _showFilters = false;

  void _toggleFilters() {
    setState(() {
      _showFilters = !_showFilters;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (user.dogsToShow.isEmpty || user.dogsToShow.length<=1){
      print("IS EMPTY LALALA");
      print("entrem algo");
      user.getDogs();
      print("sortim algo");
      print(user.dogsToShow.length);
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _showFilters
          ? null
          : AppBar(
              iconTheme: const IconThemeData(
                color: Colors
                    .white, // Aquí se cambia el color de la flecha de regreso
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
                padding: const EdgeInsets.only(left: .0, top: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Text('${widget.myDog.name}', style: TextStyle(fontSize: 30)),
                    //Text('@${widget.myDog.owner.username}', style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.7))),
                    Text(user.dogsToShow[0].name,
                        style: const TextStyle(fontSize: 30, color: Colors.white)),
                    Text(user.dogsToShow[0].owner!.username,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.7))),
                  ],
                ),
              ),
              actions: [
                IconButton(
                  icon: const Icon(BarkMeet.points),
                  color: Colors.white,
                  onPressed: _toggleFilters,
                ),
              ],
            ),
      body: Stack(
        children: [
          // Imagen de fondo
          Positioned.fill(
            child: user.dogsToShow[0].dogPhoto != null
                ? Image.file(
                    user.dogsToShow[0].dogPhoto!,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/fondo.png',
                    // Asegúrate de tener la imagen en tu carpeta assets
                    fit: BoxFit.cover,
                  ),
          ),
          // Contenido principal
          SafeArea(
            child: Column(
              children: [
                const Spacer(),
                // Botones inferiores
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 44.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          user.dogsToShow.removeAt(0);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          // Elimina el color de fondo
                          shadowColor: Colors.transparent, // Elimina la sombra
                        ),
                        child: Container(
                          width: 74,
                          height: 74,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/Dislike.png'),
                              // Ruta de la imagen
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          user.dogsToShow.removeAt(0);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          // Elimina el color de fondo
                          shadowColor: Colors.transparent, // Elimina la sombra
                        ),
                        child: Container(
                          width: 74,
                          height: 74,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/Like.png'),
                              // Ruta de la imagen
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Botón central
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          transitionDuration: const Duration(milliseconds: 500),
                          transitionsBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              Widget child) {
                            return SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(0, 1),
                                end: Offset.zero,
                              ).animate(animation),
                              child: child,
                            );
                          },
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            return ProfileScreen(
                                currentdog: user.dogsToShow[0]); //la pagina del perro
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                      // Elimina el color de fondo
                      shadowColor: Colors.transparent, // Elimina la sombra
                    ),
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/keyboard_arrow_down.png'),
                          // Ruta de la imagen
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Menú de filtros deslizante
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 0),
              height: _showFilters
                  ? MediaQuery.of(context).size.height / 3 * 2
                  : 0.0,
              color: Colors.white,
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título y botón de cerrar
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Actualment mostrant:',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16)),
                            IconButton(
                              icon: const Icon(Icons.close, color: Colors.black),
                              onPressed: _toggleFilters,
                            ),
                          ],
                        ),
                        // Filtros de "En adopció" y "No en adopció"
                        const Row(
                          children: [
                            FilterOption(label: 'En adopció'),
                            FilterOption(label: 'No en adopció'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Título "Genère"
                        const Text('Genère',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        const SizedBox(height: 8),
                        // Filtros de "Mascle" y "Femella"
                        const Row(
                          children: [
                            FilterOption(label: 'Mascle'),
                            FilterOption(label: 'Femella'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Título "Estat Sexual"
                        const Text('Estat Sexual',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        const SizedBox(height: 8),
                        // Filtros de "Fèrtil" y "Infèrtil"
                        const Row(
                          children: [
                            FilterOption(label: 'Fèrtil'),
                            FilterOption(label: 'Infèrtil'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Título "Mida"
                        const Text('Mida',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        const SizedBox(height: 8),
                        // Filtros de "Petit", "Mitjà" y "Gran"
                        const Row(
                          children: [
                            FilterOption(label: 'Petit'),
                            FilterOption(label: 'Mitjà'),
                            FilterOption(label: 'Gran'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        // Botón de aplicar filtros
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Lógica para aplicar los filtros
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.black, // Color de fondo del botón
                            ),
                            child: const Text('Aplicar filtres',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                    ),
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
        items: const [
          BottomNavigationBarItem(
            icon: Icon(BarkMeet.step, color: Colors.black),
            label: 'Inici',
          ),
          BottomNavigationBarItem(
            icon: Icon(BarkMeet.message),
            label: 'Xat',
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
        onTap: (int index) {
          if (index == 0) {
            //Do nothing
          } else if (index == 1) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeChatScreen(user: user),
              ),
              (route) => false,
            );
          } else if (index == 2) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MapScreen(user: user),
              ),
              (route) => false,
            );
          } else {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => UserProfileScreen(user: user),
              ),
              (route) => false,
            );
          }
        },
      ),
    );
  }
}

class FilterOption extends StatefulWidget {
  final String label;

  const FilterOption({super.key, required this.label});

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
              style: const TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
