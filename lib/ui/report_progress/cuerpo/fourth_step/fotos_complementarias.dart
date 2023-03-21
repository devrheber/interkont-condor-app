import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:toast/toast.dart';

import '../../../../utils/utils.dart';
import 'fouth_step_provider.dart';
import 'local_widgets/imagen_caja.dart';

class FotosComplementarias extends StatelessWidget {
  const FotosComplementarias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fourthStepService = context.read<FourthStepProvider>();
    final images = context.watch<FourthStepProvider>().complementaryImages;

    ToastContext().init(context);

    Future obtenerImagen(ImageSource source) async {
      try {
        final picked = await ImagePicker().pickImage(source: source);

        if (picked == null) return;

        fourthStepService.saveImage(picked);
      } catch (exception, stackTrace) {
        await Sentry.captureException(exception, stackTrace: stackTrace);
        Toast.show('Algo salió mal, incidencia reportada.');
      }
    }

    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      runSpacing: 20,
      spacing: 20,
      children: <Widget>[
        //lista las imagenes que se encuentran grabadas
        for (int i = 0; i < images.length; i++)
          ImagenCaja(
            file: images[i].imageFile,
            onRemoveImageTap: () {
              fourthStepService.removeImage(images[i]);
            },
          ),
        ImagenCaja(
          onTap: () {
            if (images.length >= 5) {
              Toast.show('No puede agregar mas de 5 fotos', duration: 6);
              return;
            }

            seleccionarGaleriaCamara(
              context,
              onCameraTap: () => obtenerImagen(ImageSource.camera),
              onGalleryTap: () => obtenerImagen(ImageSource.gallery),
            );
          },
        ),
      ],
    );
  }
}
