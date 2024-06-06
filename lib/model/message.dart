import 'package:cloud_firestore/cloud_firestore.dart';

class Message {

  // attributs
  final String senderUserId;
  final String senderUsername;

  final String receiverUserId;

  final String message;
  final Timestamp timestamp;

  // constructor
  Message({
    required this.senderUserId,
    required this.senderUsername,
    required this.receiverUserId,
    required this.message,
    required this.timestamp,
  });

  // Funció per convertir a un Map
  Map<String, dynamic> toMap() {
    return {
      'senderUserId': senderUserId,
      'senderUsername': senderUsername,
      'receiverUserId': receiverUserId,
      'message': message,
      'timestamp': timestamp,
    };
  }

}