import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widgets/widgets.dart';
import 'cajonTexto.dart';
import 'documentos_adicionales.dart';
import 'foto_principal.dart';
import 'fotos_complementarias.dart';
import 'fouth_step_provider.dart';
import 'required_documents.dart';

final titleColor = const Color(0xff444444);

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
          margin: const EdgeInsets.only(
            top: 230,
          ),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 31),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const TextTitle(text: 'Descripción & Documentos'),
                          const SizedBox(height: 2),
                          CajonTextoComentarios(
                              textoTitulo: 'Comentarios',
                              textoHint:
                                  'Acá puede agregar una descripción del avance..',
                              onChanged: (String value) =>
                                  fourthStepService.onChangedComment(value)),
                          const SizedBox(height: 22.8),
                          const TextSubtitle2(
                            text: 'Agregar una foto principal del avance',
                            isRequired: true,
                          ),
                          const SizedBox(height: 23.15),
                          const FotoPrincipal(),
                          const SizedBox(height: 22.8),
                          const TextSubtitle2(
                            text:
                                'Agregar fotos complementarias (Max 5)\nTambién puedes tomar una foto a tus documentos',
                          ),
                          const SizedBox(height: 23.15),
                          const FotosComplementarias(),
                          const SizedBox(height: 22.8),
                          const TextSubtitle2(
                            text: 'Agregar Documentos Obligatorios',
                          ),
                          const SizedBox(height: 22.8),
                          if (fourthStepService.gettingTypesDocument)
                            const LoadingText('Obteniendo tipos de documento...')
                          else
                            const RequiredDocuments(),
                          const SizedBox(height: 22.8),
                          const TextSubtitle2(
                            text: 'Agregar Documentos adicionales',
                          ),
                          const SizedBox(height: 22.8),
                          const DocumentosAdicionales(),
                          const SizedBox(height: 23.15),
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
