import 'package:appventon/models/carModel.dart';
import 'package:appventon/providers/car_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CarPage extends StatefulWidget {
  

  @override
  _CarPageState createState() => _CarPageState();
}

class _CarPageState extends State<CarPage> {

    final formKey = GlobalKey<FormState>();
    final carProvider = new CarProvider();
    final db = Firestore.instance;
    Cars car = new Cars();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario Carro'),
      ),
      body: SingleChildScrollView(
          child: Form(
          key: formKey,
          child: Column(
           children: <Widget>[
             _createBrand(),
             _createModel(),
             _createPlate(),
             _createYear(),
             SizedBox(height: 15.0,),
             _createBottom()
           ],
          ),
        ),
      ),
    );
  }

  Widget _createBrand() {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 30.0),
     child: TextFormField(
       decoration: InputDecoration( 
         labelText: 'Marca'
       ),
       onSaved: (value) => car.brand = int.parse(value),
     ),
   );
 }
 Widget _createModel() {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 30.0),
     child: TextFormField(
       decoration: InputDecoration( 
         labelText: 'Modelo'
       ),
onSaved: (value) => car.model = int.parse(value),
     ),
   );
 }
 Widget _createPlate() {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 30.0),
     child: TextFormField(
       decoration: InputDecoration( 
         labelText: 'Placa'
       ),
      onSaved: (value) => car.plate = value,
     ),
   );
 }
 Widget _createYear() {
   return Container(
     padding: EdgeInsets.symmetric(horizontal: 30.0),
     child: TextFormField(
       decoration: InputDecoration( 
         labelText: 'Year'
       ),
       onSaved: (value) => car.year = int.parse(value),
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

  _register(BuildContext context)  async {

    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();

    print(car.brand);
    print(car.model);
    print(car.plate);
    print(car.year);

   carProvider.addCar(car);

   Navigator.pushReplacementNamed(context, 'user');
    
  }
}