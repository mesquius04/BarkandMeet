import 'package:flutter/material.dart';
import '../model/user.dart';

class ChatIndividualScreen extends StatelessWidget {
  final UserProfile user;

  const ChatIndividualScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color set to white
      body: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black54, // Back arrow icon color set to black with transparency
                    ),
                    onPressed: () {
                      Navigator.pop(context); // Go back to the previous screen
                    },
                  ),
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: Image.asset('assets/images/chat111.png').image,
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'August',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Quicksand',
                              color: Colors.black, // Text color set to black
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '@TateMcRae',
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Quicksand',
                              color: Colors.black54, // Text color set to black with transparency
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Online',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.green, // Online status color set to green
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  '1 FEB 12:00',
                  style: TextStyle(
                    color: Colors.black54, // Text color set to black with transparency
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: Image.asset('assets/images/chat111.png').image,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300, // Color of received message balloons
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Good morning! How\'s your week going?',
                          style: TextStyle(
                            color: Colors.black, // Text color set to black
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade400, // Color of sent message balloons
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Hey! It\'s been busy but good. How about you?',
                      style: TextStyle(
                        color: Colors.black, // Text color set to black
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: Image.asset('assets/images/chat111.png').image,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.grey.shade300, // Color of received message balloons
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Same here. Hey, have you tried that new dog-friendly cafe that opened up?',
                          style: TextStyle(
                            color: Colors.black, // Text color set to black
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  '08:12',
                  style: TextStyle(
                    color: Colors.black54, // Text color set to black with transparency
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade400, // Color of sent message balloons
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Not yet, but I have been meaning to! Let\'s plan a doggy date there this weekend!',
                      style: TextStyle(
                        color: Colors.black, // Text color set to black
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 300.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade400, // Color of sent message balloons
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      '?',
                      style: TextStyle(
                        color: Colors.black, // Text color set to black
                      ),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.grey.shade300, // Color of container set to light grey
                        ),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Type a message...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black54, // Icon color set to black with transparency
                      ),
                      onPressed: () {
                        // Implement message sending functionality here
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}