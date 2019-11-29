import 'package:appventon/models/travelModel.dart';
import 'package:appventon/providers/travel_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SolicitarPage extends StatefulWidget {
  

  @override
  _SolicitarPageState createState() => _SolicitarPageState();
}

class _SolicitarPageState extends State<SolicitarPage> {

  final db = Firestore.instance;
  
  String _fecha = '';
  String _hora = '';

  TextEditingController _controladorFecha = new TextEditingController();
  TextEditingController _controladorHora = new TextEditingController();

  final formKey = GlobalKey<FormState>();
  final travelProvider = new TravelProvider();

  Travels travel = new Travels();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pedir Appventon'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _cityOrigin(),
                _cityDestiny(),
                _createFecha(context),
                _createHora(context),
                SizedBox(height: 20,),
                _createBoton()
              ],
            ),
          ),
        ),
      )
    );
  }

  _cityOrigin() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: '¿En dónde estas?'
       ),
       onSaved: (value) => travel.startPoint,
    );
  }

  _cityDestiny() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: '¿A dónde quieres ir?',
         ),
         onSaved: (value) => travel.endPoint,
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

  _createBoton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Buscar Appventon'),
      ),
      elevation: 0.0,
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: ()=> _search(context)
    );
  }

  _search(BuildContext context) {
  
  if(!formKey.currentState.validate()) return;

  travelProvider.showTravel(travel);

  print(travel.huor);
  print(travel.date);

  Navigator.pushReplacementNamed(context, 'ver');

  }

}