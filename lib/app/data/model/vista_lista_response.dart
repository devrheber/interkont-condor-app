import 'dart:convert';

import 'project.dart';

List<Project> vistaListaResponseFromJson(String str) => List<Project>.from(json.decode(str).map((x) => Project.fromJson(x)));

String vistaListaResponseToJson(List<Project> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


