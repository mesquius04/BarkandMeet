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
  final ChatService _chatService =
      ChatService(firestoreInstance: FirebaseFirestore.instance);
  final ScrollController _scrollController = ScrollController();
  DocumentSnapshot? _lastDocument;
  bool _loadingMore = false;
  List<DocumentSnapshot> _messages = [];

  _ChatIndividual2State({required this.user});

  @override
  void initState() {
    super.initState();
    _chatService.senderUser = user;
    _fetchInitialMessages();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels == 0) {
        // At the top
      } else {
        // At the bottom
        _fetchMoreMessages();
      }
    }
  }

  Future<void> _fetchInitialMessages() async {
    QuerySnapshot snapshot = await _chatService.getMessagesWithPagination(
      user.userId,
      widget.reciver.userId,
    );
    setState(() {
      _messages = snapshot.docs;
      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      }
    });
  }

  Future<void> _fetchMoreMessages() async {
    if (_loadingMore) return;

    setState(() {
      _loadingMore = true;
    });

    QuerySnapshot snapshot = await _chatService.getMessagesWithPagination(
      user.userId,
      widget.reciver.userId,
      lastDocument: _lastDocument,
    );

    setState(() {
      _messages.addAll(snapshot.docs);
      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last;
      }
      _loadingMore = false;
    });
  }

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

  Widget _buildMessageList() {
    return ListView.builder(
      controller: _scrollController,
      reverse: true,
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: _buildMessageItem(_messages[index]),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

    var alignment = data['senderUserId'] == user.userId
        ? Alignment.centerRight
        : Alignment.centerLeft;

    var color = data['senderUserId'] == user.userId
        ? const Color.fromRGBO(28, 115, 255, 0.90)
        : const Color.fromRGBO(228, 227, 230, 0.90);

    var textColor =
        data['senderUserId'] == user.userId ? Colors.white : Colors.black;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: alignment == Alignment.centerRight
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Text(
                data['message'],
                style: TextStyle(
                    color: textColor, fontFamily: 'Roboto', fontSize: 15),
              ),
              Text(
                DateFormat('dd/MM/yyyy HH:mm')
                    .format(data['timestamp'].toDate()),
                style: TextStyle(fontSize: 10, color: textColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
              icon: const Icon(Icons.arrow_upward_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
