import 'package:appventon/bloc/login_bloc.dart';
import 'package:appventon/bloc/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _loginForm(context)
        ],
      )
    );
  }

  Widget _loginForm(BuildContext context) {

    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: <Widget>[

          SafeArea(
            child: Container(
              height: 40.0,
            ),
          ),

          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 5.0),
                  spreadRadius: 3.0,
                )
              ]
            ),
            child: Column(
              children: <Widget>[
                _createEmail(bloc),
              _createPassword(bloc),
              SizedBox(height: 20.0,),
              _createBottom(bloc),
              
              ],
            ),
          ),
          
            _createAccion(context)  
        ],
      ),
    );
  }

  Widget _createEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream ,
      builder: (BuildContext context, AsyncSnapshot snapshot){
        return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
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
      padding: EdgeInsets.symmetric(horizontal: 20.0),
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
         return   RaisedButton(
           child: Container(
             padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
             child: Text('Ingresar'),
           ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0)
      ),
      elevation: 0.0,
      color: Colors.deepPurple,
      textColor: Colors.white,
      onPressed: () { 
        _login(bloc, context);
        Navigator.pushReplacementNamed(context, 'user'); 
      }
    );
       },
     );  
  }

   Widget _createAccion(BuildContext context) {
     return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('¿No tienes una cuenta?'),
              FlatButton(
                child: Text('Registrate', style: TextStyle(color: Colors.indigo[900]),) ,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, 'nuevo');
                },
              ),
            ],
          ),
        ],
      ),
    );
   }

   
Future<FirebaseUser> _login(LoginBloc bloc, BuildContext context) async {
  //  try {
    AuthResult result = await auth.signInWithEmailAndPassword(email: bloc.email, password: bloc.password);
    final FirebaseUser user = result.user;

    assert(user != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await auth.currentUser();
    assert(user.uid == currentUser.uid);
    return user;
  // } catch (e) {
  //   print(e);
  //   return null;
  // }
}


}