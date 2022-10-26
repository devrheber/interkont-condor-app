import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../widgets/widgets.dart';
import 'cajonTexto.dart';
import 'documentos_adicionales.dart';
import 'foto_principal.dart';
import 'fotos_complementarias.dart';
import 'fouth_step_provider.dart';
import 'required_documents.dart';

final titleColor = Color(0xff444444);

class FourthStep extends StatelessWidget {
  const FourthStep._();

  static Widget init() {
    return ChangeNotifierProvider(
      lazy: true,
      create: (context) => FourthStepProvider(
        projectsCacheRepository: context.read(),
        projectRepository: context.read(),
        nonPersistentCacheRepository: context.read(),
      ),
      child: const FourthStep._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final fourthStepService = Provider.of<FourthStepProvider>(context);

    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            top: 230.h,
          ),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 31.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const TextTitle(text: 'Descripción & Documentos'),
                          SizedBox(height: 2.sp),
                          CajonTextoComentarios(
                              textoTitulo: 'Comentarios',
                              textoHint:
                                  'Acá puede agregar una descripción del avance..',
                              onChanged: (String value) =>
                                  fourthStepService.onChangedComment(value)),
                          SizedBox(height: 22.8.sp),
                          const TextSubtitle2(
                            text: 'Agregar una foto principal del avance',
                            isRequired: true,
                          ),
                          SizedBox(height: 23.15.sp),
                          const FotoPrincipal(),
                          SizedBox(height: 22.8.sp),
                          const TextSubtitle2(
                            text:
                                'Agregar fotos complementarias (Max 5)\nTambién puedes tomar una foto a tus documentos',
                          ),
                          SizedBox(height: 23.15.sp),
                          const FotosComplementarias(),
                          SizedBox(height: 22.8.sp),
                          const TextSubtitle2(
                            text: 'Agregar Documentos Obligatorios',
                          ),
                          SizedBox(height: 22.8.sp),
                          if (fourthStepService.gettingTypesDocument)
                            LoadingText('Obteniendo tipos de documento...')
                          else
                            const RequiredDocuments(),
                          SizedBox(height: 22.8.sp),
                          const TextSubtitle2(
                            text: 'Agregar Documentos adicionales',
                          ),
                          SizedBox(height: 22.8.sp),
                          const DocumentosAdicionales(),
                          SizedBox(height: 23.15.sp),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
