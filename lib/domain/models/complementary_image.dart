import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../helpers/helpers.dart';

List<ComplementaryImage> imagesFromJson(String str) =>
    List<ComplementaryImage>.from(
        json.decode(str).map((x) => ComplementaryImage.fromJson(x)));

String imagesToJson(List<ComplementaryImage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ComplementaryImage extends Equatable {
  const ComplementaryImage({
    required this.name,
    this.imageString,
    this.imageFile,
    required this.type,
  });

  final String name;
  final String? imageString;
  final File? imageFile;
  final String type;

  factory ComplementaryImage.fromJson(Map<String, dynamic> json) {
    return ComplementaryImage(
      name: json['name'],
      imageString: json['stringImage'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'stringImage': imageString,
      'type': type,
    };
  }

  ComplementaryImage saveCache({required String imageString}) {
    return ComplementaryImage(
      name: name,
      type: type,
      imageString: imageString,
    );
  }

  @override
  List<Object> get props => [name, type];

  Future<ComplementaryImage> fromImageString() async {
    assert(imageFile == null);

    return ComplementaryImage(
      name: name,
      type: type,
      imageFile: await base64StringToFile(
        image: imageString!,
        name: name,
        extension: type,
      ),
    );
  }
}
