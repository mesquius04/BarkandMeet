import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:bark_and_meet/dog.dart';

void main() {
  group('Dog', () {
    test('getDog returns a Dog object when dog exists in database', () async {
      // Arrange
      final instance = FakeFirebaseFirestore();
      await instance.collection('Gossos').doc('dog1').set({
        'name': 'Fido',
        'adoption': true,
        'castrat': true,
        'description': 'A friendly dog',
        'endurance': 3,
        'activityLevel': 3,
        'size': 2,
        'sociability': 4,
        'raça': 'Labrador',
        'male': true,
        'birthday': '01-01-2020',
        'ownerId': 'owner1',
        'city': 'Barcelona',
        'photosUrls': ['url1', 'url2', 'url3'],
      });
      Dog.dogCollection = instance.collection('Gossos');

      // Act
      final dog = await Dog.getDog('dog1');

      // Assert
      expect(dog.name, 'Fido');
      expect(dog.adopcio, true);
      expect(dog.castrat, true);
      expect(dog.description, 'A friendly dog');
      expect(dog.endurance, 3);
      expect(dog.activityLevel, 3);
      expect(dog.size, 2);
      expect(dog.sociability, 4);
      expect(dog.raca2, 'Labrador');
      expect(dog.male, true);
      expect(dog.dateOfBirth, '01-01-2020');
      expect(dog.ownerId, 'owner1');
      expect(dog.city, 'Barcelona');
      expect(dog.photosUrls, ['url1', 'url2', 'url3']);
    });

    test('getDog throws an exception when dog does not exist in database', () async {
      // Arrange
      final instance = FakeFirebaseFirestore();
      Dog.dogCollection = instance.collection('Gossos');

      // Act & Assert
      expect(() async => await Dog.getDog('dog1'), throwsA(isInstanceOf<Exception>()));
    });
  });
}