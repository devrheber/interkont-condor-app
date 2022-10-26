import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../../utils/utils.dart';
import 'fouth_step_provider.dart';
import 'local_widgets/imagen_caja.dart';

class FotoPrincipal extends StatelessWidget {
  const FotoPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fourthStepProvider = context.read<FourthStepProvider>();
    final mainPhoto = context.watch<FourthStepProvider>().mainPhoto;

    Future<void> obtenerImagen(ImageSource source) async {
      final picked = await ImagePicker().pickImage(source: source);

      if (picked == null) return;

      fourthStepProvider.saveMainPhoto(picked);
    }

    return Container(
      child: Wrap(
        children: <Widget>[
          ImagenCaja(
            file: mainPhoto?.imageFile,
            onTap: () {
              seleccionarGaleriaCamara(
                context,
                onCameraTap: () => obtenerImagen(ImageSource.camera),
                onGalleryTap: () => obtenerImagen(ImageSource.gallery),
              );
            },
            onRemoveImageTap: () => fourthStepProvider.removeMainPhoto(),
          ),
        ],
      ),
    );
  }
}
