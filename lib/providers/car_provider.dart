

import 'package:appventon/models/carModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarProvider {


  final db = Firestore.instance;

  Future<void> addCar(Cars car) async {
    await db.collection("cars").add({
      'brand':  car.brand,
      'model': car.model,
      'plate': car.plate,
      'year': car.year,
    }).then((documentReference) {
      print(documentReference.documentID);
    }).catchError((e){
      print(e);
    });
  }
}