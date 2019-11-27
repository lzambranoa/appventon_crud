import 'package:appventon/models/travelModel.dart';
import 'package:appventon/providers/travel_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppventonPage extends StatefulWidget {
  

  @override
  _AppventonPageState createState() => _AppventonPageState();
}

class _AppventonPageState extends State<AppventonPage> {

  final formkey = GlobalKey<FormState>();
  final travelProvider = new TravelProvider();
  final db = Firestore.instance;
  Travels travel = new Travels();

  String _fecha = '';
  String _hora = '';

  TextEditingController _controladorFecha = new TextEditingController();
  TextEditingController _controladorHora = new TextEditingController();

  int _conteo = 0;

  // bool _noPets = false;
  // bool _noSmooke = false;
  // bool _noStop = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.arrow_back),
        title: Text('Crear Appventon'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
              key: formkey,
              child: Column(
              children: <Widget>[
                _selectCar(),
                _createOrigin(),
                _createDestiny(),
                _createFecha(context),
                _createHora(context),
                SizedBox(height: 10),
                _createDisponibilidad(),
                _crearCosto(),
                _crearChecboxes(),
                _crearBoton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectCar() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Selecciona el vehiculo'
      ),
      onSaved: (value) => travel.driver = value,
    );
  }

  _createOrigin() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: '¿Desde dónde vas?'
      ),
      onSaved: (value) => travel.startPoint = int.parse(value),
    );
  }

  _createDestiny() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: '¿Hasta dónde vas?'
      ),
      onSaved: (value) => travel.endPoint = int.parse(value)
    );
  }

  _createFecha(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _controladorFecha,
      decoration: InputDecoration(labelText: '¿En qué fecha vas?'),
      onSaved: (value) => travel.date = value,
      onTap: (){
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }
  _selectDate(BuildContext context) async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2019),
      lastDate: new DateTime(2050),
      //locale: Locale('es', 'ES')
    );

    if (picked != null ) {
      setState(() {
        _fecha = '${picked.day} / ${picked.month} / ${picked.year}';
        _controladorFecha.text = _fecha;
      });
    }
  }

  _createHora(BuildContext context) {
    return TextFormField(
      enableInteractiveSelection: false,
      controller: _controladorHora,
      decoration: InputDecoration(labelText: '¿A qué hora viajas?'),
      onSaved: (value) => travel.huor = value,
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectTime(context);
      },
    );
  }
  _selectTime(BuildContext context) async {
    TimeOfDay seleccionarHora = await showTimePicker(
      context: context,
      initialTime: new TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      }
    );
    if (seleccionarHora != null) {
      setState(() {
        _hora ='${seleccionarHora.hour} : ${seleccionarHora.minute}';
        _controladorHora.text = _hora;
      });
    }
  }

  _createDisponibilidad() {
    return Container(
      child: Row(
          children: <Widget>[
            _crearBotones(),
          ],
        ),
    );
  }

  _crearBotones() {
    return Column(
      children: <Widget>[
        Text('Cupos disponibles'),
        SizedBox(height: 10,),
        Row(
          children: <Widget>[
            FloatingActionButton(child: Icon(Icons.remove,), onPressed: _sustraer),
            SizedBox(width: 5,),
            Text('${travel.places}', style: TextStyle(fontSize: 25)),
            SizedBox(width: 5,),
            FloatingActionButton(child: Icon(Icons.add,), onPressed:_agregar),
          ],
        )
      ],
    );
  }

  _crearCosto() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Valor por cupo'),
      onSaved: (value) => travel.price = int.parse(value),
    );
  }

  void _agregar(){
    setState (() => travel.places++);
}

 void _sustraer(){
    setState (() => travel.places--);
}


  _crearChecboxes() {
    return Column(
      children: <Widget>[
        CheckboxListTile(
          title: Text('No animales'),
          value: travel.allowPets,
          onChanged:  (value)=>setState((){
            travel.allowPets = value;
          }),
        ),
        CheckboxListTile(
          title: Text('No Fumar'),
          value: travel.allowSmooking,
          onChanged: (value)=>setState((){
            travel.allowSmooking = value;
          }),
        ),
        CheckboxListTile( 
          title: Text('No paradas'),
          value: travel.allowStops,
          onChanged: (value)=>setState((){
            travel.allowStops = value;
          }),
        ),
      ],
    );
  }

  _crearBoton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Crear Appventon'),
      ),
      elevation: 0.0,
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: ()=> _register(context),
    );
  }
  _register(BuildContext context) {
    if(!formkey.currentState.validate()) return;

    formkey.currentState.save();

    print(travel.startPoint);
    print(travel.endPoint);
    print(travel.date);
    print(travel.huor);
    print(travel.price);
    travelProvider.addTravel(travel);
  }
}