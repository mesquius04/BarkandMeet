import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dog.dart';
import 'dart:math';
import 'park.dart';
import 'package:intl/intl.dart';

class UserProfile {
  File? profilePhoto;
  String profilePhotoUrl = '';
  String username;
  final String email;
  String name;
  String surname;
  int numDogs;
  bool gossera;
  bool premium;
  List<String> dogsIds;
  List<Dog> dogs;
  List<Park> parks;
  List<Dog> dogsToShow;
  String city;
  String additionalInfo;

  UserProfile({
    File? profilePhoto,
    required this.username,
    required this.email,
    required this.name,
    required this.surname,
    required this.numDogs,
    required this.gossera,
    required this.premium,
    required this.city,
    required this.profilePhotoUrl,
    dogsIds = const [],
    dogs = const [],
    parks = const [],
    dogsToShow = const [],
    required this.additionalInfo,
  })  : dogsIds = List.from(dogsIds),
        dogs = List.from(dogs),
        dogsToShow = List.from(dogsToShow),
        parks = List.from(parks);

  // Constructor que només demana el correu, nom d'usuari i tot el demés per defecte.
  UserProfile.basic({
    required this.email,
  })  : username = '',
        name = '',
        surname = '',
        numDogs = 0,
        gossera = false,
        premium = false,
        city = '',
        dogs = [],
        parks = [],
        additionalInfo = '',
        profilePhotoUrl = '',
        dogsIds = [],
        dogsToShow = [],
        profilePhoto = null;

  Future<List<Dog>> _convertDogs(Future<List<DocumentSnapshot>> dogsDocuments) async{
    List<Dog> dogs = [];

    List<DocumentSnapshot> documents = await dogsDocuments;

    for (DocumentSnapshot document in documents) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        List<dynamic> photosData = data['photosUrls'];

        // Convert the dynamic array to a List<String>
        List<String> photosUrl =
            photosData.map((item) => item.toString()).toList();

        dogs.add(Dog(
            name: data['name'],
            adopcio: data['adoption'],
            castrat: data['castrat'],
            description: data['description'],
            endurance: data['endurance'],
            activityLevel: data['activityLevel'],
            size: data['size'],
            sociability: data['sociability'],
            raca2: data['raça'],
            male: data['male'],
            dateOfBirth: data['birthday'],
            ownerId: data['ownerId'],
            city: data['city'],
            photosUrls: photosUrl,
            dogPhotos: [null, null, null]));
      }
    
    return dogs;
  }
  
  Future<List<DocumentSnapshot>> getFirstDogs() async {
    // Obtener la referencia a la colección "Gossos"
    CollectionReference gossosCollection =
        FirebaseFirestore.instance.collection('Gossos');

    // Obtener los primeros 10 documentos ordenados por algún campo (por ejemplo, 'name')
    String randomiser(){
      Random random = Random();
      int randomNumber = random.nextInt(6);
      switch(random){
        case 1: return 'name';
        case 2: return 'birthday';
        case 3: return 'raça';
        case 4: return 'activityLevel';
        case 5: return 'sociability';
        default: return 'endurance';
      }
    }
    String randomField=randomiser();
    bool a=false;
    Random random = Random();
    int randomNumber = random.nextInt(2);
    if (randomNumber>1){
      a=true;
    }
    QuerySnapshot querySnapshot =
        await gossosCollection.orderBy(randomField, descending: a).limit(30).get();
    querySnapshot.docs.shuffle();
    // Devolver la lista de documentos
    return querySnapshot.docs.sublist(0, 20);
  }
  
  Future<void> getDogs() async{
    // Falta Extreure els gossos de la BDD
    print("PROVA DE PRINT");
    //Algorisme martí (secret)
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    print("PROVA DE PRINT");
    Future<List<DocumentSnapshot>> Dogsdoc=  getFirstDogs();
    print("PROVA DE PRINT");
    List<Dog> dogsBdd = await _convertDogs(Dogsdoc);
    print("PROVA DE PRINT");
    print(dogsBdd.length);
    print("PROVA DE NOM");
    print(dogsBdd[0].name);
    print("PROVA DE MIDA");
    print(dogsBdd[0].size);

    // Iniciar el cronómetro
   
    
    List<int> scores = [];
    List<Dog> sortedDogs = [];
    bool noDogs;
    if (this.dogs.isEmpty) {
      noDogs = true;
    } else {
      noDogs = false;
    }
    print("User has dogs:");
    print(this.dogs.length);
    for (int i = 0; i < dogsBdd.length; i++) {
      //init all subscores
      if (noDogs) {
        if (dogsBdd[i].adopcio) {
          scores.add(150);
        } else {
          scores.add(0);
        }
      } else {
        List<int> scoreOurDogs = [];
        for (int j = 0; j < this.dogs.length; j++) {
          int localScore = 0;

          //MIDES
          switch ((this.dogs[j].size - dogsBdd[i].size).abs()) {
            case 0:
              localScore += 100;
              break;
            case 1:
              localScore += 90;
              break;
            case 2:
              localScore += 60;
              break;
            case 3:
              localScore += 40;
              break;
            case 4:
              localScore += 10;
              break;
            default:
              localScore += 0;
              break;
          }

          //EDATS
          int age1, age2;
          DateFormat dateFormat = DateFormat('dd-MM-yyyy');
          int currentYear = DateTime.now().year;

          DateTime birthDate = dateFormat.parse(dogsBdd[i].dateOfBirth);
          age1 = currentYear - birthDate.year;

          birthDate = dateFormat.parse(this.dogs[j].dateOfBirth);
          age2 = currentYear - birthDate.year;

          if (age1 <= 1) {
            age1 = 0;
          } else if (age1 <= 3) {
            age1 = 1;
          } else if (age1 <= 7) {
            age1 = 2;
          } else if (age1 <= 9) {
            age1 = 3;
          } else {
            age1 = 4;
          }

          if (age2 <= 1) {
            age2 = 0;
          } else if (age2 <= 3) {
            age2 = 1;
          } else if (age2 <= 7) {
            age2 = 2;
          } else if (age2 <= 9) {
            age2 = 3;
          } else {
            age2 = 4;
          }

          switch ((age1 - age2).abs()) {
            case 0:
              localScore += 70;
              break;
            case 1:
              localScore += 50;
              break;
            case 2:
              localScore += 25;
              break;
            case 3:
              localScore += 10;
              break;
            default:
              localScore += 0;
              break;
          }

          //CIUTAT
          if (this.city != dogsBdd[i].city) {
            localScore -= 200;
          }

          //GENERE
          if (this.dogs[j].male && dogsBdd[i].male) {
            localScore -= 30;
          } else if (this.dogs[j].male || dogsBdd[i].male) {
            localScore += 0;
          } else {
            localScore -= 40;
          }

          //CASTRAT
          if (dogsBdd[i].castrat && dogsBdd[i].male) {
            localScore += 20;
          } else if (dogsBdd[i].castrat) {
            localScore += 40;
          } else if (!dogsBdd[i].castrat && this.dogs[j].castrat) {
            localScore += 0;
          } else {
            localScore -= 80;
          }

          //CARACTER
          int charPoints = 0;
          //SOCIABILITAT (1/3)
          switch ((this.dogs[j].sociability - dogsBdd[i].sociability).abs()) {
            case 0:
              charPoints += 100;
              break;
            case 1:
              charPoints += 84;
              break;
            case 2:
              charPoints += 68;
              break;
            case 3:
              charPoints += 56;
              break;
            case 4:
              charPoints += 20;
              break;
            default:
              charPoints += 0;
              break;
          }
          localScore += (charPoints * 0.50).toInt();
          charPoints = 0;

          //RESISTENCIA (2/3)
          switch ((this.dogs[j].endurance - dogsBdd[i].endurance).abs()) {
            case 0:
              charPoints += 100;
              break;
            case 1:
              charPoints += 90;
              break;
            case 2:
              charPoints += 70;
              break;
            case 3:
              charPoints += 35;
              break;
            case 4:
              charPoints += 5;
              break;
            default:
              charPoints += 0;
              break;
          }
          localScore += (charPoints * 0.70).toInt();
          charPoints = 0;

          //ACTIVITAT (3/3)
          switch (
              (this.dogs[j].activityLevel - dogsBdd[i].activityLevel).abs()) {
            case 0:
              charPoints += 100;
              break;
            case 1:
              charPoints += 90;
              break;
            case 2:
              charPoints += 70;
              break;
            case 3:
              charPoints += 30;
              break;
            case 4:
              charPoints += 5;
              break;
            default:
              charPoints += 0;
              break;
          }
          localScore += (charPoints * 0.80).toInt();

          //FINISHED
          print("LOCAL SCORE");
          print (localScore);
          scoreOurDogs.add(localScore);
        }
        print(scoreOurDogs.length);
        int max = scoreOurDogs[0];
        print("first");
        print(max);
        for (int j = 0; j < scoreOurDogs.length; j++) {
          if (scoreOurDogs[j] > max) {
            max = scoreOurDogs[j];
          }
        }
        print("MAX");
        print(max);
        scores.add(max);
        print(scores);
      }
      
    }
    print("PROVA DE PRINT SCORES");
    print(scores);
    List<int> indexs = List<int>.generate(scores.length, (index) => index);
    indexs.sort((a, b) => scores[b].compareTo(scores[a]));
    sortedDogs = indexs.map((index) => dogsBdd[index]).toList();
    List<int> sortedIndex = indexs.map((index) => scores[index]).toList();
    while (sortedDogs.length >= 5) {
      if (sortedIndex[sortedIndex.length - 1] <= 100) {
        sortedIndex.removeLast();
        sortedDogs.removeLast();
      } else {
        break;
      }
    }
    print("PROVA DE PRINT");
    stopwatch.stop();

    // Imprimir el tiempo transcurrido en milisegundos
    print(
        'Algorisme Acabat, temps transcorregut: ${stopwatch.elapsedMilliseconds} milisegundos');
    print(sortedIndex);
    this.dogsToShow = sortedDogs;
    /*
    //RETURN PROVISIONAL
    UserProfile olivia = UserProfile(
        username: 'oliviarodrigo',
        email: 'mailprova',
        name: 'Olivia',
        surname: 'Rodrigo',
        profilePhotoUrl: "",
        numDogs: 2,
        gossera: false,
        premium: false,
        city: 'Barcelona',
        additionalInfo: 'Fan de don Xavier Cañadas');
    sortedDogs.add(Dog(
        activityLevel: 5,
        adopcio: false,
        owner: olivia,
        male: false,
        castrat: false,
        raca2: "a",
        dateOfBirth: "12/12/2012",
        name: 'Sanche',
        size: 3,
        endurance: 4,
        sociability: 5,
        friends: []));*/
    this.dogsToShow=sortedDogs;
  }
}
