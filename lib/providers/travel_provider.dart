import 'package:appventon/models/travelModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TravelProvider {

  final db = Firestore.instance;


  Future<bool> addTravel(Travels travels) async {
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

  Future showTravel(Travels travels) async {
    await db.collection('travels').where(
      'date', isEqualTo: travels.date 
    ).where(
      'huor', isEqualTo: travels.huor
    ).where(
      'starPoint', isEqualTo: travels.startPoint
    ).where(
      'endPoint', isEqualTo: travels.endPoint
    ).getDocuments()
    .then((querySnapshot){
      print(querySnapshot.documents);
    }).catchError((e){
      print(e);

    });
    
  }

     Future<void> deleteTravels(Travels travels) async {
      db.collection("travels").document(travels.idTravel).delete();
    }

}



