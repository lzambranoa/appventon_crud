import 'package:appventon/models/userModel.dart';
import 'package:appventon/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class EditPage extends StatefulWidget {
 

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {


  final usuarioProvider = new UserProvider();
  
  final formKey = GlobalKey<FormState>();
  final db = Firestore.instance;
  DocumentSnapshot doc;
  String docId;
  final _userNameController = TextEditingController();
  final _userPhoneController = TextEditingController();
  

  Users user = new Users();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: Form(
        key: formKey,
        child: Column(
         children: <Widget>[
           _createName(),
           _createPhone(),
           SizedBox(height: 20.0,),
           _createBottom()
         ],
        ),
      ),
    );
  }

 Widget _createName() {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 30.0),
     child: TextFormField(
       initialValue: user.name,
       decoration: InputDecoration( 
         labelText: 'name'
       ),
       controller: _userNameController,
       onSaved: (value) => user.name = value,
     ),
   );
 }

  _createPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: 'phone'
        ),
        controller: _userPhoneController,
        onSaved: (value) => user.phone = int.parse(value), 
      ),
    );
  }

  _createBottom() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Edit'),
      icon: Icon(Icons.save),
      onPressed: ()=> _editer(context)
    );
  }

  _editer(BuildContext context) async {

   formKey.currentState.validate();   
   formKey.currentState.save();
   usuarioProvider.editUser();

    print(user.name);
    print(user.phone);
  }

  }
