import 'dart:io';
import 'package:bark_and_meet/model/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dog.dart';
import 'dart:math';
import '../altres/park.dart';
import 'package:intl/intl.dart';

class UserProfile {
  File? profilePhoto;
  String profilePhotoUrl = '';
  String username;
  String userId = '';
  final String email;
  String name;
  String surname;
  int numDogs;
  bool gossera;
  bool premium;
  List<bool> filters;
  List<String> dogsIds;

  List<UserProfile> userMatches = [];
  List<UserProfile> userChats = [];

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
    filters = const [true, true, true, true, true, true, true, true, true],
    dogsToShow = const [],
    required this.additionalInfo,
  })  : dogsIds = List.from(dogsIds),
        dogs = List.from(dogs),
        filters = List.from(filters),
        dogsToShow = List.from(dogsToShow),
        parks = List.from(parks);

  // Constructor que només demana el correu, nom d'usuari i tot el demés per defecte.
  UserProfile.basic({
    required this.email,
  })  : username = '',
        name = '',
        surname = '',
        numDogs = 0,
        filters = [true, true, true, true, true, true, true, true, true],
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

  /// Aquesta funció comproba si l'usuari amb el uid passat per paràmetre ja existeix a la BDD.
  /// Retorna un DocumentSnapshot amb la informació de l'usuari si existeix, o un DocumentSnapshot
  /// buit si no existeix.
  /// Si hi ha algun error, es llença una excepció.
  ///
  /// @param uid String amb el uid de l'usuari a comprobar.
  static Future<DocumentSnapshot> usuariExisteix(String uid,
      {required FirebaseFirestore firestoreInstance}) async {
    try {
      // Es comprova si l'usuari amb el uid passat per paràmetre ja existeix a la BDD.
      final userCollection = firestoreInstance.collection('Usuaris');
      final userQuery = await userCollection.doc(uid).get();

      return userQuery;
    } catch (e) {
      // Si hi ha hagut algun error, es fa una excepció.
      throw Exception("Error al buscar l'usuari: $e");
    }
  }

  /// Aquesta funció retorna un objecte UserProfile amb les dades de l'usuari passat per paràmetre.
  ///
  /// @param userQuery DocumentSnapshot amb les dades de l'usuari.
  static UserProfile userFromDocumentSnapshot(DocumentSnapshot userQuery) {
    Map<String, dynamic> data = userQuery.data() as Map<String, dynamic>;

    // Agafar el array de gossos de la data
    List<dynamic> dogsData = data['dogs'] ?? [];

    // Convertir l'array dinàmic a una List<String>
    List<String> dogs = dogsData.map((item) => item.toString()).toList();

    // Crear un objecte UserProfile amb les dades de l'usuari
    UserProfile userProfile = UserProfile(
        username: data['username'],
        email: data['email'],
        name: data['name'],
        surname: data['surname'],
        numDogs: data['numDogs'],
        gossera: data['gossera'],
        premium: data['premium'],
        city: data['city'],
        profilePhotoUrl: data['photoURL'] ?? '',
        additionalInfo: data['additionalInfo'],
        dogsIds: dogs);

    userProfile.userId = userQuery.id;

    return userProfile;
  }

  Future<void> getUserMatches() async {
    List<Map<String, dynamic>> userMatchesData =
    await MatchService(firestore: FirebaseFirestore.instance)
        .getUserMatchesIds(userId);


    for (Map<String, dynamic> matchData in userMatchesData) {
      String matchUserId = matchData['userId'];
      bool chatStarted = matchData['chatComençat'];

      DocumentSnapshot userQuery = await UserProfile.usuariExisteix(matchUserId,
          firestoreInstance: FirebaseFirestore.instance);
      UserProfile userMatch = UserProfile.userFromDocumentSnapshot(userQuery);

      if (chatStarted) {
        userChats.add(userMatch);
      } else {
        userMatches.add(userMatch);
      }
    }
  }

  /// Aquesta funció agafa els gossos d'un usuari a partir de la id i els retorna en una llista.
  static Future<List<Dog>> getUserDogs(UserProfile userProfile,
      {required FirebaseFirestore firestoreInstance}) async {
    List<Dog> dogs = [];

    // això no hauria d'anar aquí però no sé on posar-ho

    try{
      userProfile.getUserMatches();
    } catch (e) {
      print("Error al agafar els matches de l'usuari: $e");
    }


    try {
      for (String dogId in userProfile.dogsIds) {
        Dog dog = await Dog.getDog(dogId, firestoreInstance: firestoreInstance);
        dogs.add(dog);
      }

      return dogs;
    } catch (e) {
      print("Error al agafar els gossos de l'usuari: $e");
      return [];
    }
  }

  Future<List<Dog>> _convertDogs(
      Future<List<DocumentSnapshot>> dogsDocuments) async {
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
          ownerUsername: data['ownerUsername'],
          dogId: document.id,
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
      switch(randomNumber){
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
    int N=8; //triem quants escollim. Com menys més es nota el filtre.
    Random random = Random();
    int rnd = random.nextInt(2);
    if (rnd>0){
      a=true;
    }
    QuerySnapshot querySnapshot;
    if (this.filters[0]){
      if (this.filters[1]){
        if (this.filters[6] && this.filters[8]){
          querySnapshot=await gossosCollection.orderBy(randomField, descending: a).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }else if (this.filters[8]){
          querySnapshot=await gossosCollection.orderBy('size', descending: true).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }else{
          querySnapshot=await gossosCollection.orderBy('size', descending: false).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }
        
      }else{
        if (this.filters[6] && this.filters[8]){
          
          querySnapshot=await gossosCollection.where('adoption',isEqualTo: true).orderBy(randomField, descending: a).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }else if (this.filters[8]){
          querySnapshot=await gossosCollection.where('adoption',isEqualTo: true).orderBy('size', descending: true).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }else{
          querySnapshot=await gossosCollection.where('adoption',isEqualTo: true).orderBy('size', descending: false).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }
      }
    }else{
      if (this.filters[1]){
        if (this.filters[6] && this.filters[8]){
          querySnapshot=await gossosCollection.where('adoption',isEqualTo: false).orderBy(randomField, descending: a).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }else if (this.filters[8]){
          querySnapshot=await gossosCollection.where('adoption',isEqualTo: false).orderBy('size', descending: true).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }else{
          querySnapshot=await gossosCollection.where('adoption',isEqualTo: false).orderBy('size', descending: false).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }
      }else{
        if (this.filters[6] && this.filters[8]){
          
          querySnapshot=await gossosCollection.orderBy(randomField, descending: a).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }else if (this.filters[8]){
          querySnapshot=await gossosCollection.orderBy('size', descending: true).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }else{
          querySnapshot=await gossosCollection.orderBy('size', descending: false).limit(N).get();
          // Devolver la lista de documentos
          return querySnapshot.docs;
        }
      }
    }
  }

  Future<void> getDogs() async {
    // Falta Extreure els gossos de la BDD
    print("Entrem a l'agorisme");
    //Algorisme martí (secret)
    Stopwatch stopwatch = Stopwatch();
    stopwatch.start();
    Future<List<DocumentSnapshot>> Dogsdoc = getFirstDogs();
    List<Dog> dogsBdd = await _convertDogs(Dogsdoc);
    // Iniciar el cronómetro
    List<int> scores = [];
    List<Dog> sortedDogs = [];
    bool noDogs;
    if (dogs.isEmpty) {
      noDogs = true;
    } else {
      noDogs = false;
    }
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
        for (int j = 0; j < dogs.length; j++) {
          int localScore = 0;

          //MIDES
          switch ((dogs[j].size - dogsBdd[i].size).abs()) {
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

          birthDate = dateFormat.parse(dogs[j].dateOfBirth);
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
          if (city != dogsBdd[i].city) {
            localScore -= 200;
          }

          //GENERE
          if (dogs[j].male && dogsBdd[i].male) {
            localScore -= 30;
          } else if (dogs[j].male || dogsBdd[i].male) {
            localScore += 0;
          } else {
            localScore -= 40;
          }

          //CASTRAT
          if (dogsBdd[i].castrat && dogsBdd[i].male) {
            localScore += 20;
          } else if (dogsBdd[i].castrat) {
            localScore += 40;
          } else if (!dogsBdd[i].castrat && dogs[j].castrat) {
            localScore += 0;
          } else {
            localScore -= 80;
          }

          //CARACTER
          int charPoints = 0;
          //SOCIABILITAT (1/3)
          switch ((dogs[j].sociability - dogsBdd[i].sociability).abs()) {
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
          switch ((dogs[j].endurance - dogsBdd[i].endurance).abs()) {
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
          switch ((dogs[j].activityLevel - dogsBdd[i].activityLevel).abs()) {
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

          //Check not the same
          if (dogs[j].activityLevel == dogsBdd[i].activityLevel &&
              dogsBdd[i].sociability == dogs[j].sociability &&
              dogsBdd[i].name == dogs[j].name &&
              dogsBdd[i].size == dogs[j].size &&
              dogsBdd[i].endurance == dogs[j].endurance &&
              dogsBdd[i].dateOfBirth == dogs[j].dateOfBirth) {
            localScore = -435;
          }
          //FINISHED
          scoreOurDogs.add(localScore);
        }

        int max = scoreOurDogs[0];
        for (int j = 0; j < scoreOurDogs.length; j++) {
          if (scoreOurDogs[j] > max) {
            max = scoreOurDogs[j];
          }
          if (scoreOurDogs[j] == -435) {
            max = -500;
            break;
          }
        }
        scores.add(max);
      }
    }
    List<int> indexs = List<int>.generate(scores.length, (index) => index);
    indexs.sort((a, b) => scores[b].compareTo(scores[a]));
    sortedDogs = indexs.map((index) => dogsBdd[index]).toList();
    List<int> sortedIndex = indexs.map((index) => scores[index]).toList();
    while (sortedDogs.length >= 8) {
      if (sortedIndex[sortedIndex.length - 1] <= 20) {
        sortedIndex.removeLast();
        sortedDogs.removeLast();
      } else {
        break;
      }
    }

    stopwatch.stop();

    // Imprimir el tiempo transcurrido en milisegundos
    print(
        'Algorisme finalitzat. Temps transcorregut: ${stopwatch.elapsedMilliseconds} ms');

    dogsToShow = sortedDogs;
  }
}
