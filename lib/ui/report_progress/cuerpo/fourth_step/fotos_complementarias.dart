import 'package:appalimentacion/ui/report_progress/cuerpo/fourth_step/fouth_step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'local_widgets/imagen_caja.dart';
import 'local_widgets/seleccionar_foto_documentos.dart';

class FotosComplementarias extends StatelessWidget {
  const FotosComplementarias({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fourthStepService = Provider.of<FourthStepProvider>(context);

    Future obtenerImagen(ImageSource source) async {
      final picked = await ImagePicker().pickImage(source: source);

      if (picked == null) return;

      context.read<FourthStepProvider>().saveImage(picked);
    }

    return Wrap(
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      runSpacing: 20.sp,
      spacing: 20.sp,
      children: <Widget>[
        //lista las imagenes que se encuentran grabadas
        for (int i = 0; i < fourthStepService.listaImagenes.length; i++)
          ImagenCaja(
            file: fourthStepService.listaImagenes[i].imageFile,
            onRemoveImageTap: () {
              fourthStepService.removeImage(
                fourthStepService.listaImagenes[i].position,
              );
            },
          ),
        ImagenCaja(
          onTap: () {
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
