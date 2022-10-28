// To parse this JSON data, do
//
//     final contratista = contratistaFromJson(jsonString);

import 'dart:convert';

List<Contratista> contratistaFromJson(String str) => List<Contratista>.from(json.decode(str).map((x) => Contratista.fromJson(x)));

String contratistaToJson(List<Contratista> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contratista {
    Contratista({
        required this.id,
        required this.contratista,
    });

    int id;
    String contratista;

    factory Contratista.fromJson(Map<String, dynamic> json) => Contratista(
        id: json["id"],
        contratista: json["contratista"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "contratista": contratista,
    };
}
