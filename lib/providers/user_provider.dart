import 'package:appventon/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appventon/models/carModel.dart';


class UserProvider {


  final db = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String docId;
  Users user;



  Future<void> addUser(Users user) async {
      await db.collection("users").add({
        'idUser': user.idUser,
        'name': user.name,
        'phone': user.phone,
        'cars': user.cars,  
      }).then((documentReference) {
        print(documentReference.documentID);
      }).catchError((e) {
        print(e);
      });
    }

    Future<void> updateCarData(Cars cars) async {
      CollectionReference refCars = db.collection("cars");

      await auth.currentUser().then((FirebaseUser user){
        refCars.add({
          'brand':  cars.brand,
          'model': cars.model,
          'plate': cars.plate,
          'year': cars.year,
          'userDriver': db.document("${"users"}/${user.uid}"),
        }).then((DocumentReference documentReference){
          documentReference.get().then((DocumentSnapshot snapshot){
            //Id Cars REFRENCIA ARRAYS
            DocumentReference refUsers = db.collection("users").document(user.uid);
            refUsers.updateData({
              'cars' : FieldValue.arrayUnion([db.document("${"cars"}/${snapshot.documentID}")])
            });
          });
        });
      });
    }
  
   Future <void> editUser() async {
          await db.collection("users").document(docId).updateData({
         'name': user.name,
         'phone': user.phone,
       }).then((documentReference){
         print("Los datos fueron actualizados");
       }).catchError((e){
         print(e);
       });
    }
  
    Future<void> deleteUser(DocumentSnapshot doc) async {
      db.collection("users").document(doc.documentID).delete();
    }

   getUsers() async {
     return await Firestore.instance.collection('users').getDocuments();
   }




  
    
  }
  
