import 'package:appventon/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appventon/models/carModel.dart';

class UserProvider {


  final db = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> addUser(Users user, Cars cars) async {
      await db.collection("users").add({

        'name': user.name,
        'phone': user.phone,
        'cars': db.document("$Cars/${cars.idCar}"),// Reference
      }).then((documentReference) {
        print(documentReference.documentID);
       // clearForm();
      }).catchError((e) {
        print(e);
      });
    }
  
    void editUser(Users user) async {
       DocumentReference ref = db.collection("users").document(user.idUser);
       return await ref.setData({
         'idUser': user.idUser,
         'name': user.name,
         'phone': user.phone,
       });
    }
  
    Future<void> deleteUser(Users users) async {
      db.collection("users").document(users.idUser).delete();
    }

   getUsers() async {
     return await Firestore.instance.collection('users').getDocuments();
   }

  //  Future<FirebaseUser> signUp( String email, String password) async {
  //    try {
  //      FirebaseUser user = await auth.createUserWithEmailAndPassword('email': email, 'password': password);
  //      assert(user != null);
  //      assert(await user.getIdToken() != null);
  //      return user;
  //    } catch (e) {
  //      print(e);
  //    }
  //  }

  //  handleError(PlatformException error) {
  //    print(error);
  //    switch(error.code) {
  //      case 'ERROR_EMAIL_ALREADY_IN_USE':
  //      setState((){
  //        errorMessage = 'Email id already exist!!';
  //      });
  //    }
  //  }
    
  }
  
  mixin UserModel {
}