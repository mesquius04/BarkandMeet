import 'dart:io';
import 'dog.dart';
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
    required this.additionalInfo,
  }) : dogsIds = List.from(dogsIds),
        dogs = List.from(dogs),
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
        profilePhoto = null;

  List<Dog> getDogs() {
    // Falta Extreure els gossos de la BDD

    //Algorisme martí (secret)
    Stopwatch stopwatch = Stopwatch();

    // Iniciar el cronómetro
    stopwatch.start();
    List<Dog> dogsBdd = [];
    List<int> scores = [];
    List<Dog> sortedDogs = [];
    bool noDogs;
    if (this.dogs.isEmpty){noDogs=true;}
    else{noDogs=false;}

    for (int i = 0; i < dogsBdd.length; i++) {
      //init all subscores
      if (noDogs){
        if (dogsBdd[i].adopcio){
          scores[i] = 100;
        }else{
          scores[i] = 0;
        }
      }
      else{
        List<int> scoreOurDogs = [];
        for (int j=0;j<this.dogs.length;j++){

          int localScore =0;

          //MIDES
          switch((this.dogs[j].size - dogsBdd[i].size).abs()){
            case 0:
              localScore+=100;
              break;
            case 1:
              localScore+=90;
              break;
            case 2:
              localScore+=60;
              break;
            case 3:
              localScore+=40;
              break;
            case 4:
              localScore+=10;
              break;
            default:
              localScore+=0;
              break;
          }

          //EDATS
          int age1,age2;
          DateFormat dateFormat = DateFormat('dd-MM-yyyy');
          int currentYear = DateTime.now().year;

          DateTime birthDate = dateFormat.parse(dogsBdd[i].dateOfBirth);
          age1 = currentYear - birthDate.year;

          birthDate = dateFormat.parse(this.dogs[j].dateOfBirth);
          age2 = currentYear - birthDate.year;

          if (age1<=1){
            age1=0;
          }else if (age1<=3){
            age1=1;
          }else if (age1<=7){
            age1=2;
          }else if (age1<=9){
            age1=3;
          }else{
            age1=4;
          }

          if (age2<=1){
            age2=0;
          }else if (age2<=3){
            age2=1;
          }else if (age2<=7){
            age2=2;
          }else if (age2<=9){
            age2=3;
          }else{
            age2=4;
          }

          switch((age1-age2).abs()){
            case 0:
              localScore+=70;
              break;
            case 1:
              localScore+=50;
              break;
            case 2:
              localScore+=25;
              break;
            case 3:
              localScore+=10;
              break;
            default:
              localScore+=0;
              break;
          }

          //CIUTAT
          if (this.city != dogsBdd[i].city){
            localScore-=200;
          }

          //GENERE
          if (this.dogs[j].male && dogsBdd[i].male){
            localScore-=30;
          }else if (this.dogs[j].male || dogsBdd[i].male){
            localScore+=0;
          }else{
            localScore-=40;
          }

          //CASTRAT
          if (dogsBdd[i].castrat && dogsBdd[i].male){
            localScore+=20;
          }else if (dogsBdd[i].castrat){
            localScore+=40;
          }else if (!dogsBdd[i].castrat && this.dogs[j].castrat){
            localScore+=0;
          }else{
            localScore-=80;
          }

          //CARACTER
          int charPoints=0;
          //SOCIABILITAT (1/3)
          switch((this.dogs[j].sociability - dogsBdd[i].sociability).abs()){
            case 0:
              charPoints+=100;
              break;
            case 1:
              charPoints+=84;
              break;
            case 2:
              charPoints+=68;
              break;
            case 3:
              charPoints+=56;
              break;
            case 4:
              charPoints+=20;
              break;
            default:
              charPoints+=0;
              break;
          }
          localScore += (charPoints * 0.50).toInt();
          charPoints=0;

          //RESISTENCIA (2/3)
          switch((this.dogs[j].endurance - dogsBdd[i].endurance).abs()){
            case 0:
              charPoints+=100;
              break;
            case 1:
              charPoints+=90;
              break;
            case 2:
              charPoints+=70;
              break;
            case 3:
              charPoints+=35;
              break;
            case 4:
              charPoints+=5;
              break;
            default:
              charPoints+=0;
              break;
          }
          localScore += (charPoints * 0.70).toInt();
          charPoints=0;

          //ACTIVITAT (3/3)
          switch((this.dogs[j].activityLevel - dogsBdd[i].activityLevel).abs()){
            case 0:
              charPoints+=100;
              break;
            case 1:
              charPoints+=90;
              break;
            case 2:
              charPoints+=70;
              break;
            case 3:
              charPoints+=30;
              break;
            case 4:
              charPoints+=5;
              break;
            default:
              charPoints+=0;
              break;
          }
          localScore += (charPoints * 0.80).toInt();

          //FINISHED
          scoreOurDogs.add(localScore);
        }
        int max=scoreOurDogs[0];
        for (int j=1;j<scoreOurDogs.length;j++){
          if (scoreOurDogs[j]>max){
            max=scoreOurDogs[j];
          }
        }
        scores.add(max);
      } 
      List<int> indexs = List<int>.generate(scores.length, (index) => index);
      indexs.sort((a, b) => scores[b].compareTo(scores[a]));
      sortedDogs = indexs.map((index) => dogsBdd[index]).toList();
      List<int> sortedIndex = indexs.map((index) => scores[index]).toList();
      while(sortedDogs.length>=5){
        if (sortedIndex[sortedIndex.length-1]<=100){
          sortedIndex.removeLast();
          sortedDogs.removeLast();
        }
        else{
          break;
        }
      }
      stopwatch.stop();

      // Imprimir el tiempo transcurrido en milisegundos
      print('Algorisme Acabat, temps transcorregut: ${stopwatch.elapsedMilliseconds} milisegundos');
      print(sortedIndex);
      return sortedDogs;
    }

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
        sociability: 5, friends: []));

    return sortedDogs;
  }
}
