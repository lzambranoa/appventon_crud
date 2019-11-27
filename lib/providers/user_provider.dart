import 'package:appventon/models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProvider {


  final db = Firestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future<void> addUser(Users user) async {
      await db.collection("users").add({
        'name': user.name,
        'phone': user.phone
      }).then((documentReference) {
        print(documentReference.documentID);
       // clearForm();
      }).catchError((e) {
        print(e);
      });
    }
  
    Future<void> editUser(Users user) async {
      await db.collection("users").document(user.idUser).updateData({
        'name': user.name,
        'phone': user.phone
      }).then((documentReference) {
      //  clearForm();
      }).catchError((e){
        
        print(e);
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