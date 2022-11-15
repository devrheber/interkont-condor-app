// To parse this JSON data, do
//
//     final contratista = contratistaFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

List<Contratista> contratistaFromJson(String str) => List<Contratista>.from(
    json.decode(str).map((x) => Contratista.fromJson(x)));

String contratistaToJson(List<Contratista> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Contratista extends Equatable {
  const Contratista({
    required this.id,
    required this.contratista,
  });

  final int id;
  final String contratista;

  factory Contratista.fromJson(Map<String, dynamic> json) => Contratista(
        id: json["id"],
        contratista: json["contratista"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contratista": contratista,
      };

  static const empty = Contratista(id: 0, contratista: '--');

  @override
  List<Object?> get props => [id, contratista];
}
