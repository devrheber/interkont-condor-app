import 'dart:convert';

List<TipoDoc> tipoDocFromJson(String str) =>
    List<TipoDoc>.from(json.decode(str).map((x) => TipoDoc.fromJson(x)));

String tipoDocToJson(List<TipoDoc> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TipoDoc {
  TipoDoc({
    this.id,
    this.tipo,
    this.obligatorio,
    this.intparametipdoc,
  });

  final int id;
  final String tipo;
  final bool obligatorio;
  final int intparametipdoc;

  factory TipoDoc.fromJson(Map<String, dynamic> json) => TipoDoc(
        id: json["id"],
        tipo: json["tipo"],
        obligatorio: json["obligatorio"],
        intparametipdoc: json["intparametipdoc"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "obligatorio": obligatorio,
        "intparametipdoc": intparametipdoc,
      };
}
