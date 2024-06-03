import 'package:flutter/material.dart';
import 'ChatScreen.dart';
import 'package:bark_and_meet/fonts/bark_meet_icons.dart';
import 'Mainpage.dart';
import 'mapa.dart';
import 'user_profile.dart';
import 'user.dart';


class HomeChatScreen extends StatelessWidget {
  final UserProfile user;

  const HomeChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Center(
              child: const Text(
                'Chat',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Arial',
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                height: 35, // Adjust the height as needed
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black54),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 239, 239, 239),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    'Match',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
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
                        SizedBox(height: 10),
                        Text(
                          'Marley',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/b.png').image,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Nina',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/c.png').image,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Joan',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/d.png').image,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Toby',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/e.png').image,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Mel',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 25),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: Image.asset('assets/images/g.png').image,
                        ),
                        SizedBox(height: 10),
                        Text(
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
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
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
                          MaterialPageRoute(builder: (context) => ChatScreen(user : user)),
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
                                SizedBox(width: 10),
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
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
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
                              SizedBox(width: 10),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
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
                              SizedBox(width: 10),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
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
                              SizedBox(width: 10),
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
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mainpage(
                        user: user
                      ),
                    ),
                  );
                } else if (index==1){
                  //do nothing
                }
                else if (index==2){
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(
                        user: user
                      ),
                    ),
                  );
                }
                else{
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserProfileScreen(
                        user: user
                      ),
                    ),
                  );
                }
        },
      ),

    );
  }
}
