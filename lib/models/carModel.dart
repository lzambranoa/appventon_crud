
import 'dart:convert';

import 'package:appventon/models/userModel.dart';

// Cars carsFromJson(String str) => Cars.fromJson(json.decode(str));

// String carsToJson(Cars data) => json.encode(data.toJson());

class Cars {
    String idCar;
    int brand;
    int carState;
    int model;
    String plate;
    bool verified;
    int year;
    List<dynamic> photoUrl;
    Users userDriver;

    Cars({
        this.idCar,
        this.brand,
        this.carState,
        this.model,
        this.plate,
        this.verified,
        this.year,
        this.photoUrl,
        this.userDriver,
    });

    // factory Cars.fromJson(Map<String, dynamic> json) => Cars(
    //     idUser: json["IdUser"],
    //     brand: json["brand"],
    //     carState: json["carState"],
    //     model: json["model"],
    //     plate: json["plate"],
    //     verified: json["verified"],
    //     year: json["year"],
    //     photoUrl: List<dynamic>.from(json["photoUrl"].map((x) => x)),
    // );

    // Map<String, dynamic> toJson() => {
    //     "IdUser": idUser,
    //     "brand": brand,
    //     "carState": carState,
    //     "model": model,
    //     "plate": plate,
    //     "verified": verified,
    //     "year": year,
    //     "photoUrl": List<dynamic>.from(photoUrl.map((x) => x)),
    // };
}
