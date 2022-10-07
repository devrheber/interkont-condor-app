import 'dart:io';

import 'package:appalimentacion/theme/color_theme.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart';

class ImagenCaja extends StatelessWidget {
  const ImagenCaja({
    Key key,
    this.file,
    this.onTap,
    this.onRemoveImageTap,
    this.isMaxLimit = false,
    this.isDocumento = false,
  }) : super(key: key);

  final File file;
  final void Function() onTap;
  final void Function() onRemoveImageTap;
  final bool isMaxLimit;
  final bool isDocumento;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      padding: EdgeInsets.zero,
      radius: Radius.circular(15.0.sp),
      strokeWidth: 2,
      color: Color(0xff9a9a9a),
      child: Container(
        width: 102.11.sp,
        height: 102.63.sp,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0.sp),
        ),
        child: file == null
            ? _NoImage(onTap: onTap, isMaxLimit: isMaxLimit)
            : Stack(
                children: [
                  isDocumento
                      ? _DocumentFile(file: file)
                      : Image.file(
                          file,
                          width: 102.11.sp,
                          height: 102.63.sp,
                          fit: BoxFit.cover,
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
                        child: IconButton(
                          // iconSize: 5.sp,
                          onPressed: onRemoveImageTap,
                          icon: Icon(
                            FontAwesomeIcons.times,
                            color: Colors.white,
                            size: 24.sp,
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

class _DocumentFile extends StatelessWidget {
  const _DocumentFile({
    Key key,
    @required this.file,
  }) : super(key: key);

  final File file;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: EdgeInsets.all(5.sp),
      child: Column(
        children: [
          Spacer(),
          AutoSizeText(
            basename(file.path),
            maxLines: 1,
            style: TextStyle(
                color: ColorTheme.primaryShade,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500),
          ),
          Text(
            //size in MB
            (file.lengthSync() / 1000000).toStringAsFixed(2) + ' MB',
            style: TextStyle(
                color: ColorTheme.primaryShade,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500),
          ),
          Spacer(flex: 3),
        ],
      ),
    );
  }
}

class _NoImage extends StatelessWidget {
  const _NoImage({
    Key key,
    @required this.onTap,
    @required this.isMaxLimit,
  }) : super(key: key);

  final void Function() onTap;
  final bool isMaxLimit;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Spacer(),
            Opacity(
              opacity: isMaxLimit ? 1 : 0,
              child: Text(
                'Max. 20MB',
                style: TextStyle(
                    color: ColorTheme.primaryShade,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Icon(
              Icons.add_circle,
              size: 40.0.sp,
              color: Color(0xffdeebf6),
            ),
            Spacer(),
            Text(
              'Agregar',
              style: TextStyle(
                  color: ColorTheme.primaryShade,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Spacer(),
            Spacer(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
