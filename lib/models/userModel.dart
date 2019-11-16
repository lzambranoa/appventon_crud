import 'dart:convert';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
    String idUser;
    String name;
    int phone;
    int countryCode;
    int diverRanking;
    int passangerRanking;
    bool state;
    String photoUrl;
    List<dynamic> cars;

    Users({
        this.idUser,
        this.name,
        this.phone,
        this.countryCode,
        this.diverRanking,
        this.passangerRanking,
        this.state,
        this.photoUrl,
        this.cars,
    });

    factory Users.fromJson(Map<String, dynamic> json) => Users(
        idUser: json["IdUser"],
        name: json["name"],
        phone: json["phone"],
        countryCode: json["countryCode"],
        diverRanking: json["diverRanking"],
        passangerRanking: json["passangerRanking"],
        state: json["state"],
        photoUrl: json["photoUrl"],
        cars: List<dynamic>.from(json["cars"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "IdUser": idUser,
        "name": name,
        "phone": phone,
        "countryCode": countryCode,
        "diverRanking": diverRanking,
        "passangerRanking": passangerRanking,
        "state": state,
        "photoUrl": photoUrl,
        "cars": List<dynamic>.from(cars.map((x) => x)),
    };
}
