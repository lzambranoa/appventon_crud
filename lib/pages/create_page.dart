import 'package:appventon/bloc/login_bloc.dart';
import 'package:appventon/bloc/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Page'),
      ),
      body: Container(
        child: Form(
          child: Column(
            children: <Widget>[
              _loginForm(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loginForm(BuildContext context) {

    final bloc = Provider.of(context);

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          
              _createEmail(bloc),
              _createPassword(bloc),
              SizedBox(height: 15.0,),
              _createBottom(bloc),
              //_createAccion(context)
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'Ejemplo@correo.com',
          counterText: snapshot.data,
          errorText: snapshot.error,
        ),
        onChanged: bloc.changeEmail,
      ),
    );
    },
    ); 
    
    
  }

  Widget _createPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
      padding: EdgeInsets.symmetric(horizontal: 30.0),
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          labelText: 'Password',
          counterText: snapshot.data,
          errorText: snapshot.error,
        ),
        onChanged: bloc.changePassword,
      ),
    );
      },
    );  
  }

  Widget _createBottom(LoginBloc bloc) {
     return StreamBuilder(
       stream: bloc.formValidStream,
       builder: (BuildContext context, AsyncSnapshot snapshot){
         return   RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Crear Usuario'),
      icon: Icon(Icons.lock_open),
      onPressed: () {
        _nuevoUsuario(bloc);
        Navigator.pushReplacementNamed(context, 'form'); 
      }
    );
       },
     );  
  }

  //  Widget _createAccion(BuildContext context) {
  //    return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 50.0),
  //     child: Column(
  //       children: <Widget>[
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //           children: <Widget>[
  //             Text('¿No tienes una cuenta?'),
  //             FlatButton(
  //               child: Text('Registrate', style: TextStyle(color: Colors.indigo[900]),) ,
  //               onPressed: (){
  //                 Navigator.pushReplacementNamed(context, 'form');
  //               },
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  //  }

   
Future<FirebaseUser> _nuevoUsuario(LoginBloc bloc) async {
  try {
    AuthResult result = await auth.createUserWithEmailAndPassword(email: bloc.email, password: bloc.password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);
    return user;
    
  } catch (e) {
    print(e);
    return null;
    
  }
  
}


}