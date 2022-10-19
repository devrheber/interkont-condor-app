import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/report_progress/cuerpo/delay_factor/delay_factor_provider.dart';
import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'widgets/campoSeleecionar.dart';
import 'widgets/factorRegistrado.dart';

class DelayFactorScreen extends StatefulWidget {
  const DelayFactorScreen._({Key? key}) : super(key: key);

  static Widget init() {
    return ChangeNotifierProvider(
      create: (context) => DelayFactorProvider(
        projectsCacheRepository: context.read(),
      ),
      child: const DelayFactorScreen._(),
    );
  }

  @override
  DelayFactorScreenState createState() => DelayFactorScreenState();
}

class DelayFactorScreenState extends State<DelayFactorScreen> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delayFactorService = Provider.of<DelayFactorProvider>(context);

    ToastContext().init(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          gradient: ColorTheme.backgroundGradient,
        ),
        child: Column(
          children: [
            customedAppBar(
              title: '',
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 28.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(
                      'assets/img/Desglose/ReporteAvance/icn-stop.png',
                      width: 45,
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10.0.sp, bottom: 10.0.sp),
                        child: Text(
                          'Stop! Este proyecto \npresenta factores de atraso.',
                          style: AppTheme.h1Blanco,
                        )),
                    Padding(
                        padding: EdgeInsets.only(bottom: 10.0.sp),
                        child: const Text(
                          'Ingresa los factores de atraso',
                          style: AppTheme.parrafoBlancoNegrita,
                        )),
                    SelectTypeDelayFactor(
                      hintText: 'Selecciona el tipo de factor',
                      list: delayFactorService.detail.tiposFactorAtraso,
                      value: delayFactorService.delayFactorTypeSelected!,
                      onChanged: (TiposFactorAtraso? value) {
                        if (value == null) return;
                        delayFactorService.selectTypeDelayFactor(value);
                      },
                    ),
                    SelectDelayFactor(
                      hintText: 'Selecciona el factor',
                      list: delayFactorService.delayFactorsFiltered,
                      value: delayFactorService.delayFactorSelected!,
                      onChanged: (FactoresAtraso? value) {
                        if (value == null) return;
                        delayFactorService.selectDelayFactor(value);
                      },
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      // margin: EdgeInsets.only(bottom: 5.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(1, 1, 1, 0.1),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: TextField(
                        textInputAction: TextInputAction.send,
                        controller: descriptionController,
                        // onChanged: accion,
                        maxLines: 4,
                        maxLength: 500,

                        style: AppTheme.parrafoBlanco,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          cut: true,
                          paste: true,
                          selectAll: true,
                        ),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          counterStyle: AppTheme.parrafoBlanco,
                          border: InputBorder.none,
                          hintText:
                              "Ingrese una descripción del factor de atraso",
                          hintStyle: AppTheme.parrafoBlanco,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    AddGreenButton(onTap: () {
                      if (delayFactorService.delayFactorTypeSelected == null) {
                        Toast.show('Seleccione el tipo de factor',
                            gravity: Toast.bottom);
                        return;
                      }

                      if (delayFactorService.delayFactorSelected == null) {
                        Toast.show('Seleccione el factor',
                            gravity: Toast.bottom);
                        return;
                      }

                      if (descriptionController.text.trim().isEmpty) {
                        Toast.show('Ingrese una descripción',
                            gravity: Toast.bottom);
                        return;
                      }

                      delayFactorService.add(descriptionController.text.trim());
                      descriptionController.clear();
                    }),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0.sp),
                      child: Text(
                        'Factores Registrados',
                        style: AppTheme.parrafoBlancoNegrita,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              delayFactorService.delayFactorsRegistered.length,
                          itemBuilder: (BuildContext context, int index) {
                            final delayFactor = delayFactorService
                                .delayFactorsRegistered[index];
                            return FactorRegistrado(
                              posicion: index,
                              tipo: delayFactor.tipoFactor!,
                              factor: delayFactor.factor!,
                              description: delayFactor.description!,
                              onTap: () => delayFactorService.remove(index),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomBottomNavigationBar(
              colorFondo: Color(0xFF2089B6),
              primerBotonDesactivado: false,
              segundoBotonDesactivado:
                  delayFactorService.secondButtonValidation,
              txtPrimerBoton: "Cancelar",
              txtSegundoBoton: "Siguiente Paso",
              accionPrimerBoton: () {
                Navigator.pop(context);
              },
              accionSegundoBoton: () {
                if (delayFactorService.secondButtonValidation) {
                  Toast.show('Debe registrar los factores de atraso.',
                      duration: 4);
                  return;
                }

                if (delayFactorService.delayFactorsRegistered.length >= 1) {
                  Navigator.pop(context, true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
