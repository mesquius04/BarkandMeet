import 'package:flutter/material.dart';
import 'chat_individual.dart';
import '../model/user.dart';

class ChatScreen extends StatefulWidget {
  final UserProfile user;

  const ChatScreen({super.key, required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState(user: user);
}

class _ChatScreenState extends State<ChatScreen> {
  final UserProfile user;

  _ChatScreenState({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Chat',
          style: TextStyle(
            fontFamily: 'Roboto',
            color: Colors.black,
            fontSize: 22,
            letterSpacing: 0,
          ),
        ),
        actions: const [],
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            // Search bar
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Títol de match
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

            // Llista de matchs
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: user.userMatches.length, // Añade una coma aquí
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: user.userMatches[index]
                                    .profilePhotoUrl.isNotEmpty
                                ? Image.network(
                                        user.userMatches[index].profilePhotoUrl)
                                    .image
                                : null,
                            child:
                                user.userMatches[index].profilePhotoUrl.isEmpty
                                    ? const Icon(Icons.account_circle, size: 50)
                                    : null,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            user.userMatches[index].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
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
                          MaterialPageRoute(
                              builder: (context) =>
                                  ChatIndividualScreen(user: user)),
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
                                  backgroundImage:
                                      Image.asset('assets/images/chat111.png')
                                          .image,
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
                      padding:
                          const EdgeInsets.only(left: 10, top: 25, right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    Image.asset('assets/images/chat222.png')
                                        .image,
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
                      padding:
                          const EdgeInsets.only(left: 10, top: 25, right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    Image.asset('assets/images/chat333.png')
                                        .image,
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
                      padding:
                          const EdgeInsets.only(left: 10, top: 25, right: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    Image.asset('assets/images/chat555.png')
                                        .image,
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
    );
  }
}
