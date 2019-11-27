import 'package:appventon/models/travelModel.dart';
import 'package:appventon/providers/travel_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VerTravel extends StatefulWidget {
  

  @override
  _VerTravelState createState() => _VerTravelState();
}

class _VerTravelState extends State<VerTravel> {

  QuerySnapshot travels;
  final travelProvider = new TravelProvider();
  Travels travel = new Travels();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ver Appventon'),
      ),
      body: _crearListado(),
    );
  }
   @override 
  void initState() {
    travelProvider.showTravel(travel).then((results){
      setState(() {
        travels = results;
      });
    });
  }

  _crearListado() {
    if(travels != null){
      return ListView.builder(
        itemCount: travels.documents.length,
        padding: EdgeInsets.all(5.0),
        itemBuilder: (context, i) {
          return Container(
            child: Card(
              child: Column(
                children: <Widget>[
                  new ListTile(
                    title: Text(travels.documents[i].data['huor']),
                    subtitle: Text(travels.documents[i].data['date']),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}