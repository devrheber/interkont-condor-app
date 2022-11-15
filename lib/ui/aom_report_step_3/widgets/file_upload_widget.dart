
import 'dart:io';

import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class FileUploadWidget extends StatefulWidget {
  const FileUploadWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<FileUploadWidget> createState() => _FileUploadWidgetState();
}

File? _image;
File? _video;
File? _file;

//method to pick image from gallery or camera
Future<File?> pickImage(ImageSource source) async {
  final image = await ImagePicker().pickImage(source: source);
  if (image == null) return null;
  return File(image.path);
}

//method to pick video from gallery or camera
Future<File?> pickVideo(ImageSource source) async {
  final video = await ImagePicker().pickVideo(source: source);
  if (video == null) return null;
  return File(video.path);
}

Future<File?> pickFile() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result == null) return null;

  //if result is greater than 10mb show error message
  if (result.files.single.size > 10000000) {
    Toast.show("El archivo no puede ser mayor a 10MB",
        duration: 3, gravity: Toast.bottom);

    return null;
  }

  // TODO Use try catch

  return File(result.files.single.path!);
}

class _FileUploadWidgetState extends State<FileUploadWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      runAlignment: WrapAlignment.end,
      runSpacing: 50.sp,
      spacing: 50.sp,
      children: <Widget>[
        _ImageContainer(
          instruction: 'Agregar Imagen\n(Obligatoria)',
          file: _image,
          onAddPressed: () {
            seleccionarGaleriaCamara(
              context,
              onCameraTap: () async {
                _image = await pickImage(ImageSource.camera);
                setState(() {});
              },
              onGalleryTap: () async {
                _image = await pickImage(ImageSource.gallery);
                setState(() {});
              },
            );
          },
          onRemovePressed: () {
            setState(() {
              _image = null;
            });
          },
        ),
        _ImageContainer(
          instruction: 'Agregar Video\n(Opcional)\n(Max 10Mb)',
          file: _video,
          onAddPressed: () {
            seleccionarGaleriaCamara(
              context,
              onCameraTap: () async {
                _video = await pickVideo(ImageSource.camera);
                setState(() {});
              },
              onGalleryTap: () async {
                _video = await pickVideo(ImageSource.gallery);
                setState(() {});
              },
            );
          },
          onRemovePressed: () {
            setState(() {
              _video = null;
            });
          },
        ),
        _ImageContainer(
          instruction: 'Agregar Documento\n(Opcional)\n(Max 10Mb)',
          file: _file,
          onAddPressed: () async {
            _file = await pickFile();
            setState(() {});
          },
          onRemovePressed: () {
            setState(() {
              _file = null;
            });
          },
        ),
      ],
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    Key? key,
    required this.instruction,
    this.file,
    required this.onAddPressed,
    required this.onRemovePressed,
  }) : super(key: key);
  final String instruction;
  final File? file;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;

  String get fileName => file != null ? file!.path.split('/').last : '';

  String get fileExtension => file != null ? fileName.split('.').last : '';

  bool get isImage => fileExtension == 'jpg' || fileExtension == 'png';

  bool get isVideo => fileExtension == 'mp4';

  Widget get videoThumbnail {
    if (!isVideo) return Container();
    return FutureBuilder(
      future: VideoThumbnail.thumbnailFile(
        video: file!.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 200,
        quality: 75,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.file(
            File(snapshot.data.toString()),
            fit: BoxFit.cover,
            width: 130.sp,
            height: 130.sp,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget get fileTypeIcon {
    if (isImage) {
      return Center(
        child: Container(
          color: ColorTheme.darkShade,
          child: const Icon(
            FontAwesomeIcons.image,
            color: Colors.white,
          ),
        ),
      );
    }
    if (isVideo) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.sp),
          ),
          child: const Icon(
            FontAwesomeIcons.film,
            color: ColorTheme.darkShade,
          ),
        ),
      );
    }
    return Center(
      child: Column(
        children: [
          Spacer(),
          Icon(
            fileExtension == 'pdf'
                ? FontAwesomeIcons.filePdf
                : FontAwesomeIcons.file,
            color: ColorTheme.darkShade,
          ),
          AutoSizeText(
            '$fileName',
            style: TextStyle(
              fontFamily: 'montserrat',
              fontSize: 14.sp,
              color: Color(0xFF556A8D),
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(fileExtension);
    return DottedBorder(
      borderType: BorderType.RRect,
      padding: EdgeInsets.zero,
      radius: Radius.circular(15.0.sp),
      strokeWidth: 2,
      color: Color(0xff9a9a9a),
      child: Container(
        width: 130.sp,
        height: 130.sp,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0.sp),
        ),
        child: file == null
            ? GestureDetector(
                onTap: onAddPressed,
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Spacer(flex: 3),
                      Icon(
                        Icons.add_circle,
                        size: 40.0.sp,
                        color: Color(0xffdeebf6),
                      ),
                      Spacer(),
                      Text(
                        instruction,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorTheme.primaryShade,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  Visibility(
                    visible: isImage,
                    child: Image.file(
                      file!,
                      fit: BoxFit.cover,
                      width: 130.sp,
                      height: 130.sp,
                    ),
                  ),
                  Visibility(
                    visible: isVideo,
                    child: videoThumbnail,
                  ),
                  Visibility(
                    // visible: !isImage && !isVideo,
                    child: fileTypeIcon,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(500),
                        ),
                      ),
                      margin: EdgeInsets.all(8.86.sp),
                      child: Material(
                        color: Colors.red,
                        child: InkWell(
                          onTap: onRemovePressed,
                          child: Padding(
                            padding: EdgeInsets.all(5.86.sp),
                            child: Icon(
                              FontAwesomeIcons.xmark,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
