
import 'package:cloud_firestore/cloud_firestore.dart';



class MatchService {
  final FirebaseFirestore firestore;

  MatchService({required this.firestore});

  /// La funció fa un like a un gos i comprova si aquest gos ja ha fet like al gos que fa el like.
  /// Si és així, es crea un match i s'eliminen els likes.
  ///
  /// @return Future<bool> retorna true si s'ha fet match, false si no.
  Future<bool> likeDog(String fromUserId, String toUserId, String toDogId) async {
    // Verificar si hi ha un like invers
    try {
      QuerySnapshot querySnapshot = await firestore.collection('Likes')
          .where('fromUserId', isEqualTo: toUserId)
          .where('toUserId', isEqualTo: fromUserId)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Crear match
        await firestore.collection('Matches').add({
          'user1Id': fromUserId,
          'user2Id': toUserId,
          'dog1Id': toDogId,
          'dog2Id': querySnapshot.docs[0]['toDogId'],
        });

        // Eliminar likes
        await firestore.collection('Likes')
            .where('fromUserId', isEqualTo: toUserId)
            .where('toUserId', isEqualTo: fromUserId)
            .get()
            .then((snapshot) {
          for (DocumentSnapshot doc in snapshot.docs) {
            doc.reference.delete();
          }
        });

        return true;

      } else {
        // Comprobar si ja s'havia fet like a aquest mateix gos
        QuerySnapshot queryLikeSnapshot = await firestore.collection('Likes')
            .where('fromUserId', isEqualTo: fromUserId)
            .where('toUserId', isEqualTo: toUserId)
            .get();

        // fer like
        if (queryLikeSnapshot.docs.isEmpty) {
          await firestore.collection('Likes').add({
            'fromUserId': fromUserId,
            'toUserId': toUserId,
            'toDogId': toDogId,
          });
        }

        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }

  }

  Future<List<String>> getUserMatchesIds(String userId) async {

    try {
      QuerySnapshot querySnapshot1 = await firestore.collection('Matches')
          .where('user1Id', isEqualTo: userId)
          .get();

      QuerySnapshot querySnapshot2 = await firestore.collection('Matches')
          .where('user2Id', isEqualTo: userId)
          .get();

      List<String> matches = [];
      for (DocumentSnapshot doc in querySnapshot1.docs) {
        matches.add(doc['user2Id']);
      }
      for (DocumentSnapshot doc in querySnapshot2.docs) {
        matches.add(doc['user1Id']);
      }

      return matches;
    } catch (e) {
      print(e);
      return [];
    }
  }
}