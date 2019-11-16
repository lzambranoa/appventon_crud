import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        child: Form(
          child: Column(
            children: <Widget>[
              _createEmail(),
              _createPassword(),
              SizedBox(height: 15.0,),
              _createBottom(),
              _createAccion(context)
            ],
          ),
        ),
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

  Widget _createBottom() {
     return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Ingresar'),
      icon: Icon(Icons.lock_open),
      onPressed: (){}
    );
  }

   Widget _createAccion(BuildContext context) {
     return Container(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('¿No tienes una cuenta?'),
              FlatButton(
                child: Text('Registrate', style: TextStyle(color: Colors.indigo[900]),) ,
                onPressed: (){
                  Navigator.pushReplacementNamed(context, 'form');
                },
              ),
            ],
          ),
        ],
      ),
    );
   }
}