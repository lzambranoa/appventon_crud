import 'package:appventon/bloc/provider.dart';
import 'package:appventon/models/travelModel.dart';
import 'package:appventon/providers/travel_provider.dart';
import 'package:flutter/material.dart';

class VerTravel extends StatelessWidget {
  
  final travelProvider = TravelProvider();

  @override
  Widget build(BuildContext context) {

    final bloc = Provider;
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Appventon'),
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado() {
    return FutureBuilder(
      future: travelProvider.showTravel(),
      builder: (BuildContext context, AsyncSnapshot<List<Travels>> snapshot) {
        if( snapshot.hasData ) {
          final travels = snapshot.data;

          return ListView.builder(
            itemCount: travels.length,
            itemBuilder: (context, i) => _crearItem(context, travels[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, Travels travel) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      onDismissed: (direccion){
        travelProvider.deleteTravels();
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('${travel.startPoint} - ${travel.endPoint}'),
              subtitle: Text(travel.idTravel),
            )
          ],
        ),
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.arrow_left),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=> Navigator.pushNamed(context, 'solicitar'),
    );
  }
}