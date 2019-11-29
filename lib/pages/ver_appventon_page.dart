import 'package:appventon/models/travelModel.dart';
import 'package:appventon/providers/travel_provider.dart';
import 'package:flutter/material.dart';

class VerTravel extends StatelessWidget {
  
  final travelProvider = new TravelProvider();
  Travels travels = new Travels();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Appventon'),
      ),
      body: Text('en construccion'),
    );
  }

  // _crearListado() {
  //   return FutureBuilder(
  //     future: travelProvider.showTravel(travels),
  //     builder: (BuildContext context, AsyncSnapshot<List<Travels>> snapshot) {
  //       if (snapshot.hasData) {
  //         final travel = snapshot.data;

  //         return ListView.builder(
  //           itemCount: travel.length,
  //           itemBuilder: (context, i) => _crearItem(context, travel[i]),
  //         );
  //       } else {
  //         return Center(child: CircularProgressIndicator(),);
  //       }
  //     }
  //   );
  // }

  Widget _crearItem(BuildContext context, Travels travels) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.blue,
      ),
      onDismissed: (direccion){
        travelProvider.deleteTravels(travels);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('${travels.huor} - ${travels.date}'),
              subtitle: Text(travels.idTravel),
            )
          ],
        ),
      ),
    );
  }
}