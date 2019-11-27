// To parse this JSON data, do
//
//     final travels = travelsFromJson(jsonString);

import 'dart:convert';

Travels travelsFromJson(String str) => Travels.fromJson(json.decode(str));

String travelsToJson(Travels data) => json.encode(data.toJson());

class Travels {
    int idTravel;
    int startPoint;
    int endPoint;
    int places;
    String date;
    String huor;
    int price;
    int state;
    String driver;
    List<dynamic> passengers;
    bool allowPets;
    bool allowSmooking;
    bool allowStops;

    Travels({
        this.idTravel,
        this.startPoint,
        this.endPoint,
        this.places = 0,
        this.date,
        this.huor,
        this.price,
        this.state,
        this.driver,
        this.passengers,
        this.allowPets = true,
        this.allowSmooking = true,
        this.allowStops = true,
    });

    factory Travels.fromJson(Map<String, dynamic> json) => Travels(
        idTravel: json["idTravel"],
        startPoint: json["starPoint"],
        endPoint: json["endPoint"],
        places: json["places"],
        date: json["date"],
        huor: json["huor"],
        price: json["price"],
        state: json["state"],
        driver: json["driver"],
        passengers: List<dynamic>.from(json["passengers"].map((x) => x)),
        allowPets: json["allowPets"],
        allowSmooking: json["allowSmooking"],
        allowStops: json["allowStops"],
    );

    Map<String, dynamic> toJson() => {
        "idTravel": idTravel,
        "starPoint": startPoint,
        "endPoint": endPoint,
        "places": places,
        "date": date,
        "huor": huor,
        "price": price,
        "state": state,
        "driver": driver,
        "passengers": List<dynamic>.from(passengers.map((x) => x)),
        "allowPets": allowPets,
        "allowSmooking": allowSmooking,
        "allowStops": allowStops,
    };
}
