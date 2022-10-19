import 'dart:convert';

List<TipoDoc> tipoDocFromJson(String str) =>
    List<TipoDoc>.from(json.decode(str).map((x) => TipoDoc.fromJson(x)));

String tipoDocToJson(List<TipoDoc> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoDoc {
  TipoDoc({
    required this.id,
    required this.nombre,
    required this.obligatorio,
    required this.intparametipdoc,
  });

  final int id;
  final String nombre;
  final bool obligatorio;
  final int intparametipdoc;

  factory TipoDoc.fromJson(Map<String, dynamic> json) => TipoDoc(
        id: json["id"],
        nombre: json["tipo"],
        obligatorio: json["obligatorio"],
        intparametipdoc: json["intparametipdoc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": nombre,
        "obligatorio": obligatorio,
        "intparametipdoc": intparametipdoc,
      };

  TipoDoc copyWith({
    int? id,
    String? nombre,
    bool? obligatorio,
    int? intparametipdoc,
  }) {
    return TipoDoc(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      obligatorio: obligatorio ?? this.obligatorio,
      intparametipdoc: intparametipdoc ?? this.intparametipdoc,
    );
  }
}
