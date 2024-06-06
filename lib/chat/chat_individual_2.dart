import 'package:bark_and_meet/model/chat_service.dart';
import 'package:bark_and_meet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatIndividual2 extends StatefulWidget {
  final UserProfile user;
  final UserProfile reciver;

  const ChatIndividual2({Key? key, required this.user, required this.reciver});

  @override
  State<ChatIndividual2> createState() => _ChatIndividual2State(user: user);
}

class _ChatIndividual2State extends State<ChatIndividual2> {
  final TextEditingController _messageController = TextEditingController();
  final UserProfile user;

  _ChatIndividual2State({required this.user});

  final ChatService _chatService =
      ChatService(firestoreInstance: FirebaseFirestore.instance);

  @override
  void initState() {
    super.initState();
    _chatService.senderUser = user;
  }

  // enviar missatge
  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          _messageController.text, widget.reciver.userId);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.reciver.profilePhotoUrl),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.reciver.name,
                    style: Theme.of(context).textTheme.headlineSmall),
                Text("@${widget.reciver.username}",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(user.userId, widget.reciver.userId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Error al carregar els missatges'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map((document) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    // Add padding here
                    child: _buildMessageItem(document),
                  ))
              .toList(),
        );
      },
    );
  }

  // Message item
  Widget _buildMessageItem(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    // alinear els meus missatges a la dreta i els del receptor a l'esquerra
    var alignment = data['senderUserId'] == user.userId
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.8, // Limit the width to 80% of screen width
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.shade400, // Color of sent message balloons
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: alignment == Alignment.centerRight
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(data['message']),
              Text(
                DateFormat('dd/MM/yyyy HH:mm').format(
                    data['timestamp'].toDate()), // Timestamp of the message
                style: const TextStyle(fontSize: 10),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Message input
  Widget _buildMessageInput() {
    return Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _messageController,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  ),
                  contentPadding: EdgeInsets.fromLTRB(15, 5, 5, 0),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 5)),
            CircleAvatar(
              backgroundColor: Colors.blue,
              radius: 20,
              child: IconButton(
                onPressed: sendMessage,
                icon:
                    const Icon(Icons.arrow_upward_rounded, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
