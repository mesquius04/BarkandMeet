import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:bark_and_meet/model/match.dart';

void main() {
  final instance = FakeFirebaseFirestore();

  group('MatchService', () {
    final matchService = MatchService(firestore: instance);

    test('likeDog creates a match when there is a reverse like', () async {
      await instance.collection('Likes').add({
        'fromUserId': 'user2',
        'toUserId': 'user1',
      });

      await matchService.likeDog('user1', 'user2');

      final matchSnapshot = await instance.collection('Matches').get();
      expect(matchSnapshot.docs, isNotEmpty);
    });

    test('likeDog adds a like when there is no reverse like', () async {
      await matchService.likeDog('user1', 'user3');

      final likeSnapshot = await instance.collection('Likes').get();
      expect(likeSnapshot.docs, isNotEmpty);
    });

    test('getMatches returns correct matches for a user', () async {
      await instance.collection('Matches').add({
        'user1Id': 'user3',
        'user2Id': 'user4',
      });

      final matches = await matchService.getUserMatchesIds('user3');
      expect(matches, isNotEmpty);
      expect(matches[0], 'user4');
    });

    test('getMatches returns empty list when there are no matches for a user', () async {
      final matches = await matchService.getUserMatchesIds('user5');
      expect(matches, isEmpty);
    });
  });
}