import 'package:bark_and_meet/model/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chat_individual.dart';
import '../model/user.dart';
import 'chat_individual_2.dart';

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
                child: (user.userMatches.isNotEmpty)
                    ? ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            user.userMatches.length, // Añade una coma aquí
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              MatchService(
                                      firestore: FirebaseFirestore.instance)
                                  .updateChatStarted(user.userId,
                                      user.userMatches[index].userId);

                              UserProfile reciver = user.userMatches[index];

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatIndividual2(
                                          user: user,
                                          reciver: user.userMatches[index],
                                        )),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 40,
                                    backgroundImage: user.userMatches[index]
                                            .profilePhotoUrl.isNotEmpty
                                        ? Image.network(user.userMatches[index]
                                                .profilePhotoUrl)
                                            .image
                                        : null,
                                    child: user.userMatches[index]
                                            .profilePhotoUrl.isEmpty
                                        ? const Icon(Icons.account_circle,
                                            size: 50)
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
                            ),
                          );
                        },
                      )
                    : const Center(
                        child: Text('No hi ha cap match'),
                      ),
              ),
            ),

            const SizedBox(height: 20),

            // Títol de chats
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

            // Llista de chats
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
                child: (user.userChats.isNotEmpty)
                    ? ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: user.userChats.length, // Añade una coma aquí
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChatIndividual2(
                                          user: user,
                                          reciver: user.userChats[index],
                                        )),
                              );
                            },
                            child: _ChatCell(user.userChats[index]),
                          );
                        },
                      )
                    : const Center(
                        child: Text('No hi ha cap chat'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fer la view d'un chat
  Widget _ChatCell(UserProfile reciver) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(reciver.profilePhotoUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      reciver.name,
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
                  "@${reciver.username}",
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
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
    );
  }
}
