import 'package:flutter/material.dart';
import 'chat_individual.dart';
import '../model/user.dart';


class ChatScreen extends StatelessWidget {
  final UserProfile user;

  const ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Center(
              child: Text(
                'Chat',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Arial',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 35, // Adjust the height as needed
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black54),
                    filled: true,
                    fillColor: Color.fromARGB(255, 239, 239, 239),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Text(
                    'Match',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 110,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/a.png').image,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Marley',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/b.png').image,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Nina',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/c.png').image,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Joan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/d.png').image,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Toby',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/e.png').image,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Mel',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/g.png').image,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Zeus',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  const Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ChatIndividualScreen(user : user)),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, top: 15, right: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundImage: Image.asset('assets/images/chat111.png').image,
                                ),
                                const SizedBox(width: 10),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          'August',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Quicksand',
                                            fontSize: 17,
                                          ),
                                        ),                                        
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      'Not yet but i have been meaning...',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Divider(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Other chat items with similar structure...
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 25, right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: Image.asset('assets/images/chat222.png').image,
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Max',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Quicksand',
                                          fontSize: 17,
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Sounds great the dogs will love...',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 25, right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: Image.asset('assets/images/chat333.png').image,
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Luna',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Quicksand',
                                          fontSize: 17,
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Thanks! I got it from a local pet...',
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, top: 25, right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: Image.asset('assets/images/chat555.png').image,
                              ),
                              const SizedBox(width: 10),
                              const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'Daisy',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Quicksand',
                                          fontSize: 17,
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Good morning!Just wanted to let...",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0),
                            child: Divider(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      /*
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
                  Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MainPageAsync(
            user: user
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
                } else if (index==1){
                  //do nothing
                }
                else if (index==2){
                  Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MapScreen(
            user: user
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
                }
                else{
                  Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => UserProfileScreen(
                        user: user
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
      );
                }
        },
      ),*/

    );
  }
}