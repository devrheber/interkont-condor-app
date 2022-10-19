import 'package:appalimentacion/ui/report_progress/cuerpo/fourth_step/fouth_step_provider.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'local_widgets/imagen_caja.dart';

class FotosComplementarias extends StatelessWidget {
  const FotosComplementarias({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fourthStepService = context.read<FourthStepProvider>();
    final images = context.watch<FourthStepProvider>().complementaryImages;

    ToastContext().init(context);

    Future obtenerImagen(ImageSource source) async {
      final picked = await ImagePicker().pickImage(source: source);

      if (picked == null) return;

      fourthStepService.saveImage(picked);
    }

    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      runSpacing: 20.sp,
      spacing: 20.sp,
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
