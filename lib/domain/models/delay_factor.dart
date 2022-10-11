import 'dart:convert';

List<DelayFactor> delayFactorFromJson(String str) => List<DelayFactor>.from(
    json.decode(str).map((x) => DelayFactor.fromJson(x)));

String delayFactorToJson(List<DelayFactor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DelayFactor {
  DelayFactor({
    this.tipoFactorAtrasoId,
    this.tipoFactor,
    this.factorAtrasoId,
    this.factor,
    this.description,
  });

  int tipoFactorAtrasoId;
  String tipoFactor;
  int factorAtrasoId;
  String factor;
  String description;

  factory DelayFactor.fromJson(Map<String, dynamic> json) => DelayFactor(
        tipoFactorAtrasoId: json['tipoFactorAtrasoId'],
        tipoFactor: json['tipoFactor'],
        factorAtrasoId: json['factorAtrasoId'],
        factor: json['factor'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'tipoFactorAtrasoId': tipoFactorAtrasoId,
        'tipoFactor': tipoFactor,
        'factorAtrasoId': factorAtrasoId,
        'factor': factor,
        'description': description,
      };
}
