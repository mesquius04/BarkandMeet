
import 'package:cloud_firestore/cloud_firestore.dart';



class MatchService {
  final FirebaseFirestore firestore;

  MatchService({required this.firestore});

  Future<void> likeDog(String fromDogId, String fromUserId, String toDogId, String toUserId) async {
    // Verificar si existe un like inverso
    QuerySnapshot querySnapshot = await firestore.collection('Likes')
        .where('fromDogId', isEqualTo: toDogId)
        .where('toDogId', isEqualTo: fromDogId)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Crear match
      await firestore.collection('Matches').add({
        'user1Id': fromUserId,
        'user2Id': toUserId,
        'dog1Id': fromDogId,
        'dog2Id': toDogId,
      });

      // Eliminar likes
      await firestore.collection('Likes')
          .where('fromDogId', isEqualTo: toDogId)
          .where('toDogId', isEqualTo: fromDogId)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

      await firestore.collection('Likes')
          .where('fromDogId', isEqualTo: fromDogId)
          .where('toDogId', isEqualTo: toDogId)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });

    } else {
      // Agregar like
      await firestore.collection('Likes').add({
        'fromDogId': fromDogId,
        'toDogId': toDogId,
      });
    }
  }

  Future<List<Map<String, String>>> getMatches(String userId) async {
    QuerySnapshot querySnapshot1 = await firestore.collection('Matches')
        .where('user1Id', isEqualTo: userId)
        .get();

    QuerySnapshot querySnapshot2 = await firestore.collection('Matches')
        .where('user2Id', isEqualTo: userId)
        .get();

    List<Map<String, String>> matches = [];
    for (DocumentSnapshot doc in querySnapshot1.docs) {
      matches.add({
        'userId': doc['user2Id'],
        'dogId': doc['dog2Id'],
      });
    }
    for (DocumentSnapshot doc in querySnapshot2.docs) {
      matches.add({
        'userId': doc['user1Id'],
        'dogId': doc['dog1Id'],
      });
    }

    return matches;
  }
}