import 'package:appventon/providers/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:appventon/models/userModel.dart';


class UserPage extends StatefulWidget {

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  QuerySnapshot usuarios;
  final usuarioProvider = new UserProvider();
  Users users = new Users();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User'),
      ),
      body: _crearListado(),
    );
  }

  @override 
  void initState() {
    usuarioProvider.getUsers().then((results){
      setState(() {
        usuarios = results;
      });
    });
  }

  

 Widget _crearListado() {
  if (usuarios != null) {
    return ListView.builder(
      itemCount: usuarios.documents.length,
      padding: EdgeInsets.all(5.0),
      itemBuilder: (context, i) {
        return Container(
          child: Card(
             child: Column(
               children: <Widget>[
                 new ListTile(
                  title: Text(usuarios.documents[i].data['name']),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: (){
                    Navigator.pushNamed(context, 'edit');
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: ()=> _delete(context) 
                ),

              ],
            )
               ],
             ),
          ),
        );
      }
    );
  } else {
    return Text('Loading....');
  }
  
}

_delete(BuildContext context)async {

  await usuarioProvider.deleteUser(users);

}
}