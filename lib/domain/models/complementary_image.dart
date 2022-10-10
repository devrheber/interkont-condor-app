import 'dart:io';

import 'package:flutter/foundation.dart';

class ComplementaryImage {
  const ComplementaryImage({
    @required this.name,
    this.imageString,
    this.imageFile,
    this.type = 'jpge',
    @required this.position,
  });

  final String name;
  final String imageString;
  final File imageFile;
  final String type;
  final int position;

  ComplementaryImage copyWith({
    final int position,
  }) {
    return ComplementaryImage(
      name: name,
      position: position ?? this.position,
    );
  }

  factory ComplementaryImage.fromJson(Map<String, dynamic> json) {
    return ComplementaryImage(
      name: json['name'],
      imageString: json['stringImage'],
      type: json['type'],
      position: json['position'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'string_image': imageString,
      'type': type,
      'position': position,
    };
  }
}
