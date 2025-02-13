import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:toast/toast.dart';

import '../../../../utils/utils.dart';
import 'fouth_step_provider.dart';
import 'local_widgets/imagen_caja.dart';

class FotoPrincipal extends StatelessWidget {
  const FotoPrincipal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fourthStepProvider = context.read<FourthStepProvider>();
    final mainPhoto = context.watch<FourthStepProvider>().mainPhoto;

    ToastContext().init(context);

    Future<void> obtenerImagen(ImageSource source) async {
      try {
        final picked = await ImagePicker().pickImage(source: source);

        if (picked == null) return;

        fourthStepProvider.saveMainPhoto(picked);
      } catch (exception, stackTrace) {
        await Sentry.captureException(exception, stackTrace: stackTrace);
        Toast.show('Algo salió mal, incidencia reportada.');
      }
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
