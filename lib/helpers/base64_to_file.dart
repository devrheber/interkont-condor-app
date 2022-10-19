import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<File?> base64StringToFile(
    {String? image, String? name, String? extension}) async {
  if (extension == null) extension = 'jpg';
  if (image == null) return null;
  if (image.isEmpty) return null;
  var bytes = base64.decode(image);
  //create temp directory 
  var tempDir = await getTemporaryDirectory();
  //create a file in the temp directory
  var tempFile = File('${tempDir.path}/$name.$extension');
  //write the bytes to the file
  await tempFile.writeAsBytes(bytes);
  return tempFile;
}
