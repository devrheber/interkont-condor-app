import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import 'delay_factor_provider.dart';
import 'widgets/campoSeleecionar.dart';
import 'widgets/factorRegistrado.dart';

class DelayFactorScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final delayFactorService = Provider.of<DelayFactorProvider>(context);

    ToastContext().init(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: ColorTheme.backgroundGradient,
                ),
              ),
              Column(
                children: [
                  customedAppBar(
                    title: '',
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Expanded(child: _Body()),
                  CustomBottomNavigationBar(
                    colorFondo: Colors.transparent,
                    primerBotonDesactivado: false,
                    segundoBotonDesactivado:
                        delayFactorService.secondButtonValidation,
                    txtPrimerBoton: 'Retroceder',
                    txtSegundoBoton: 'Siguiente Paso',
                    accionPrimerBoton: () {
                      Navigator.pop(context);
                    },
                    accionSegundoBoton: () {
                      if (delayFactorService.secondButtonValidation) {
                        Toast.show('Debe registrar los factores de atraso.',
                            duration: 4);
                        return;
                      }

                      if (delayFactorService
                          .delayFactorsRegistered.isNotEmpty) {
                        Navigator.pop(context, true);
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({Key? key}) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delayFactorService = Provider.of<DelayFactorProvider>(context);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Container(
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
                    child: const Text(
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
                  value: delayFactorService.delayFactorTypeSelected,
                  onChanged: (TiposFactorAtraso? value) {
                    if (value == null) return;
                    delayFactorService.selectTypeDelayFactor(value);
                  },
                ),
                SelectDelayFactor(
                  hintText: 'Selecciona el factor',
                  list: delayFactorService.delayFactorsFiltered,
                  value: delayFactorService.delayFactorSelected,
                  onChanged: (FactoresAtraso? value) {
                    if (value == null) return;
                    delayFactorService.selectDelayFactor(value);
                  },
                ),
                SizedBox(height: 10.h),
                Container(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(1, 1, 1, 0.1),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: descriptionController,
                    maxLines: 4,
                    maxLength: 500,
                    style: AppTheme.parrafoBlanco,
                    toolbarOptions: const ToolbarOptions(
                      copy: true,
                      cut: true,
                      paste: true,
                      selectAll: true,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.zero,
                      counterStyle: AppTheme.parrafoBlanco,
                      border: InputBorder.none,
                      hintText: "Ingrese una descripción del factor de atraso",
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
                    Toast.show('Seleccione el factor', gravity: Toast.bottom);
                    return;
                  }

                  if (descriptionController.text.trim().isEmpty) {
                    Toast.show('Ingrese una descripción',
                        gravity: Toast.bottom);
                    return;
                  }

                  if (delayFactorService.validateUniqueFactor) {
                    Toast.show('Exite un registro del mismo tipo y factor',
                        duration: 4, gravity: Toast.bottom);
                    return;
                  }

                  delayFactorService.add(descriptionController.text.trim());
                  descriptionController.clear();
                }),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0.sp),
                  child: const Text(
                    'Factores Registrados',
                    style: AppTheme.parrafoBlancoNegrita,
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: delayFactorService.delayFactorsRegistered.length,
                  itemBuilder: (BuildContext context, int index) {
                    final delayFactor =
                        delayFactorService.delayFactorsRegistered[index];
                    return FactorRegistrado(
                      posicion: index,
                      tipo: delayFactor.tipoFactor!,
                      factor: delayFactor.factor!,
                      description: delayFactor.description!,
                      onTap: () => delayFactorService.remove(index),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
