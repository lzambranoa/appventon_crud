import 'package:appventon/models/carModel.dart';
import 'package:appventon/models/userModel.dart';
import 'package:appventon/providers/user_provider.dart';
//import 'package:appventon/viewmodels/CRUDmodels.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormPage extends StatefulWidget {
  

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {

  final usuarioProvider = new UserProvider();
  
  final formKey = GlobalKey<FormState>();
  final db = Firestore.instance;

  Users user = new Users();
  Cars cars = new Cars();

  @override
  Widget build(BuildContext context) {

    //var userProvider = Provider.of<CRUDModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: SingleChildScrollView(
          child: Form(
          key: formKey,
          child: Column(
           children: <Widget>[
             _createName(),
             _createPhone(),
             _createEmail(),
             _createPassword(),
             SizedBox(height: 15.0,),
             _createBottom()
           ],
          ),
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
        onSaved: (value) => user.phone = int.parse(value), 
      ),
    );
  }

  Widget _createEmail() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Ejemplo@correo.com'
        ),
      ),
    );
  }

  Widget _createPassword() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password'
        ),
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
      label: Text('Save'),
      icon: Icon(Icons.save),
      onPressed: ()=> _register(context) 
    );
  }

  _register(BuildContext context) async {

    if (!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print(user.name);
    print(user.phone);

    usuarioProvider.addUser(user, cars);
  

    Navigator.pushReplacementNamed(context, 'car');
  
  }
}
