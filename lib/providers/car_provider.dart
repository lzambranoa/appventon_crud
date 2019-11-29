

import 'package:appventon/models/carModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appventon/models/userModel.dart';


class CarProvider {


  final db = Firestore.instance;

  Future<void> addCar(Cars car, Users user) async {
    CollectionReference refCars =  await db.collection("cars").add({
      'brand':  car.brand,
      'model': car.model,
      'plate': car.plate,
      'year': car.year,
      'userDriver': db.document("$Users/${user.idUser}"),//reference
    }).then((DocumentReference documentReference) {
      documentReference.get().then((DocumentSnapshot snapshot){
        //Id Car referencia al array
        DocumentReference refUsers = db.collection("cars").document(user.idUser);
        refUsers.setData({
          'cars' : FieldValue.arrayUnion([db.document("$Cars/${snapshot.documentID}")])
        });
      });
    }).catchError((e){
      print(e);
    });
  }
}