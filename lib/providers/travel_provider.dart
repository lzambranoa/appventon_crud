import 'package:appventon/models/travelModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class TravelProvider {

  final db = Firestore.instance;
  Travels travels = Travels();
  final List <QuerySnapshot> querySnapshot = List();
  final List<Travels> travel = List();


  Future<bool> addTravel() async {
    await db.collection('travels').add({
      'startPoint': travels.startPoint,
      'endPoint': travels.endPoint,
      'date': travels.date,
      'huor': travels.huor,
      'places': travels.places,
      'price': travels.price,
      'noPets': travels.allowPets,
      'noSmooke': travels.allowSmooking,
      'noStops': travels.allowStops
    }).then((documentReference){
      print(documentReference.documentID);
    }).catchError((e){
      print(e);
    });
    return true;
  }

  Future<List<Travels>> showTravel() async {

    await db.collection('travels').where(
      'date', isEqualTo: travels.date
    ).where(
      'huor', isEqualTo: travels.huor
    ).where(
      'starPoint', isEqualTo: travels.startPoint
    ).where(
      'endPoint', isEqualTo: travels.endPoint
    ).getDocuments()
      .then((querySnapshot) {
        print(querySnapshot.documents);
      }).catchError((e){
        print(e);
      });

      return travel;
  }
  

     Future<void> deleteTravels() async {
      db.collection("travels").document(travels.idTravel).delete();
    }

}



