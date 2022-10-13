import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ComplementaryImage extends Equatable {
  const ComplementaryImage({
    @required this.name,
    this.imageString,
    this.imageFile,
    this.type,
  });

  final String name;
  final String imageString;
  final File imageFile;
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
      'string_image': imageString,
      'type': type,
    };
  }

  ComplementaryImage saveCache({@required String imageString}) {
    assert(name != null, type != null);
    return ComplementaryImage(
      name: name,
      type: type,
      imageString: imageString,
    );
  }

  @override
  List<Object> get props => [name, type];
}
