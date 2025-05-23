import 'package:bark_and_meet/vista_inici.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'model/match.dart';
import 'model/user.dart';
import 'perfil_gos/perfil_gos.dart';
import 'package:bark_and_meet/fitxersAuxiliars/fonts/bark_meet_icons.dart';

class MainPage extends StatefulWidget {
  final UserProfile user;

  const MainPage({super.key, required this.user});

  @override
  _MainPageState createState() => _MainPageState(user: user);
}

class _MainPageState extends State<MainPage> {
  final UserProfile user;

  final MatchService _matchService = MatchService(firestore: FirebaseFirestore.instance);

  void _handleLike(String fromUserId, String toUserId, String toDogId) async {
    bool match = await _matchService.likeDog(fromUserId, toUserId, toDogId);

    if (match) {
      // Mostrar pop up informant que s'ha fet match
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Match!'),
            content: const Text('Has fet match amb aquest gos!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Tancar'),
              ),
            ],
          );
        },
      );
    }
    setState(() {
      user.dogsToShow.removeAt(0);
    });
  }

  _MainPageState({required this.user});

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
                    Text(
                        (user.dogsToShow.isNotEmpty)
                            ? user.dogsToShow[0].name
                            : "No hi ha gossos",
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white)),

                    Text((user.dogsToShow.isNotEmpty)
                        ? "@${user.dogsToShow[0].ownerUsername}"
                        : "Unknown user",
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
            child: user.dogsToShow[0].photosUrls[0].isEmpty
                ? Image.asset(
                    'assets/fondo.png',
                    // Asegúrate de tener la imagen en tu carpeta assets
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    user.dogsToShow[0].photosUrls[0],
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

                          setState(() {
                            user.dogsToShow.removeAt(0);
                          });

                          if (user.dogsToShow.isEmpty) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VistaInici(user: user, index: 0),
                              ),
                            );
                          }
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
                          _handleLike(user.userId, user.dogsToShow[0].ownerId, user.dogsToShow[0].dogId);


                          if (user.dogsToShow.length <= 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VistaInici(user: user, index: 0,),
                              ),
                            );
                          }
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
                          transitionDuration: const Duration(milliseconds: 300),
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
                            return DogProfileScreen(
                                currentdog:
                                    user.dogsToShow[0]); //la pagina del perro
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
                              icon:
                                  const Icon(Icons.close, color: Colors.black),
                              onPressed: _toggleFilters,
                            ),
                          ],
                        ),
                        // Filtros de "En adopció" y "No en adopció"
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    user.filters[0] = !user.filters[0];
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: user.filters[0],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          user.filters[0] = value ?? false;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Text(
                                      'En adopció',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    user.filters[1] = !user.filters[1];
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: user.filters[1],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          user.filters[1] = value ?? false;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Text(
                                      'No en adopció',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 16),
                        // Título "Genère"
                        const Text('Genère',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        const SizedBox(height: 8),
                        // Filtros de "Mascle" y "Femella"
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    user.filters[2] = !user.filters[2];
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: user.filters[2],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          user.filters[2] = value ?? false;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Text(
                                      'Male',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    user.filters[3] = !user.filters[3];
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: user.filters[3],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          user.filters[3] = value ?? false;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Text(
                                      'Female',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 16),
                        // Título "Estat Sexual"
                        const Text('Estat Sexual',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        const SizedBox(height: 8),
                        // Filtros de "Fèrtil" y "Infèrtil"
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    user.filters[4] = !user.filters[4];
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: user.filters[4],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          user.filters[4] = value ?? false;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Text(
                                      'Castrat',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    user.filters[5] = !user.filters[5];
                                  });
                                },
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: user.filters[5],
                                      onChanged: (bool? value) {
                                        setState(() {
                                          user.filters[5] = value ?? false;
                                        });
                                      },
                                      activeColor: Colors.black,
                                    ),
                                    Text(
                                      'No castrat',
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                        const SizedBox(height: 16),
                        // Título "Mida"
                        const Text('Mida',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16)),
                        const SizedBox(height: 8),
                        // Filtros de "Petit", "Mitjà" y "Gran"
                       Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  user.filters[6] = !user.filters[6];
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: user.filters[6],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        user.filters[6] = value ?? false;
                                      });
                                    },
                                    activeColor: Colors.black,
                                  ),
                                  Text(
                                    'Petit',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  user.filters[7] = !user.filters[7];
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: user.filters[7],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        user.filters[7] = value ?? false;
                                      });
                                    },
                                    activeColor: Colors.black,
                                  ),
                                  Text(
                                    'Mitja',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  user.filters[8] = !user.filters[8];
                                });
                              },
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: user.filters[8],
                                    onChanged: (bool? value) {
                                      setState(() {
                                        user.filters[8] = value ?? false;
                                      });
                                    },
                                    activeColor: Colors.black,
                                  ),
                                  Text(
                                    'Gran',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                        const SizedBox(height: 16),
                        // Botón de aplicar filtros
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Lógica para aplicar los filtros
                              user.filters;
                              while (user.dogsToShow.isNotEmpty) {
                                user.dogsToShow.removeLast();
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VistaInici(user: user, index: 0),
                                ),
                              );
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
    );
  }
}
/*
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
    return
  }
}*/
