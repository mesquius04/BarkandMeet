import 'package:bark_and_meet/model/message.dart';
import 'package:bark_and_meet/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore firestoreInstance;
  UserProfile senderUser = UserProfile.basic(email: "");

  ChatService({required this.firestoreInstance});

  // Aquesta funció s'encarrega d'enviar un missatge a un usuari
  Future<void> sendMessage(String message, String reciverId) async {
    final Timestamp timestamp = Timestamp.now();

    // crear el missatge
    Message newMessage = Message(
      senderUserId: senderUser.userId,
      senderUsername: senderUser.username,
      receiverUserId: reciverId,
      message: message,
      timestamp: timestamp,
    );

    // construir una chat room
    List<String> users = [senderUser.userId, reciverId];
    users.sort();
    String chatRoomId = '${users[0]}_${users[1]}';

    // Es crea un nou document a la col·lecció de missatges
    await firestoreInstance
        .collection('Chat')
        .doc(chatRoomId)
        .collection('Missatges')
        .add(newMessage.toMap());
  }

  // Aquesta funció agafa els missatges de la base de dades
  Stream<QuerySnapshot> getMessages(String senderId, String reciverId) {
    List<String> users = [senderId, reciverId];
    users.sort();
    String chatRoomId = '${users[0]}_${users[1]}';

    return firestoreInstance
        .collection('Chat')
        .doc(chatRoomId)
        .collection('Missatges')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  // Mètode per obtenir els missatges amb paginació
  Future<QuerySnapshot> getMessagesWithPagination(
      String senderId, String receiverId,
      {DocumentSnapshot? lastDocument, int limit = 20}) async {
    List<String> users = [senderId, receiverId];
    users.sort();
    String chatRoomId = '${users[0]}_${users[1]}';

    CollectionReference messages = firestoreInstance
        .collection('Chat')
        .doc(chatRoomId)
        .collection('Missatges');

    Query query = messages.orderBy('timestamp', descending: true).limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.get();
  }
}
