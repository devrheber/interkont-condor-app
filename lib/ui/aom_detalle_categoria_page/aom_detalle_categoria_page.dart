import 'dart:io';

import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/report_progress/cabecera/header_steps.dart';
import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:appalimentacion/ui/widgets/step_indicator.dart';
import 'package:appalimentacion/utils/seleccionar_foto_documentos.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AomDetalleCategoriaPage extends StatelessWidget {
  const AomDetalleCategoriaPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //get pushnamed arguments
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String nombre = arguments['nombre'];
    int paso = arguments['paso'];
    return FondoHome(
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 15.sp),
        child: CustomBottomNavigationBar(
          colorFondo: AppTheme.bottomPrincipal,
          primerBotonDesactivado: false,
          segundoBotonDesactivado: false,
          txtPrimerBoton: 'Atrás',
          txtSegundoBoton:
              paso >= 3 ? 'Finalizar Actualización' : 'Siguiente Paso',
          accionPrimerBoton: () {
            Navigator.pop(context);
          },
          accionSegundoBoton: () {
            if (paso == 3) {
              Navigator.pushNamed(
                context, 
                AppRoutes.aomLastStep,
              );
            }
          },
        ),
      ),
      body: Stack(
        children: [
          customedAppBar(
            title: nombre,
            onPressed: () => Navigator.pop(context),
          ),
          Container(
            width: double.infinity,
            height: 90.h,
            margin: EdgeInsets.only(top: 164.h, right: 28.sp, left: 28.sp),
            padding: EdgeInsets.symmetric(horizontal: 5.sp),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: titleColor.withOpacity(.1),
                  blurRadius: 20,
                  spreadRadius: 10,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                StepIndicator(
                  text: 'Detalle de\nlos Activos',
                  number: '1',
                  isCompleted: paso >= 1,
                ),
                StepIndicator(
                  text: 'Actualización\ncualitativo',
                  number: '2',
                  isCompleted: paso >= 2,
                ),
                StepIndicator(
                  text: 'Imágen o\n video',
                  number: '3',
                  isCompleted: paso >= 3,
                ),
              ],
            ),
          ),
          Visibility(
            visible: paso == 1,
            child: ContenidoPaso1AOM(),
          ),
          Visibility(
            visible: paso == 2,
            child: ContenidoPaso2AOM(),
          ),
          Visibility(
            visible: paso == 3,
            child: ContenidoPaso3AOM(),
          ),
        ],
      ),
    );
  }
}

class ContenidoPaso3AOM extends StatelessWidget {
  const ContenidoPaso3AOM({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 265.h, left: 28.sp, right: 28.sp),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Text(
            'Subir una Imagen o Video',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: ColorTheme.primary,
            ),
          ),
          SizedBox(height: 30.sp),
          Center(
            child: FileUpload(),
          ),
        ],
      ),
    );
  }
}

class FileUpload extends StatefulWidget {
  const FileUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<FileUpload> createState() => _FileUploadState();
}

File? _image;
File? _video;
File? _file;

//method to pick image from gallery or camera
Future<File?> pickImage(ImageSource source) async {
  final image = await ImagePicker().pickImage(source: source);
  if (image == null) return null;
  return File(image.path);
}

//method to pick video from gallery or camera
Future<File?> pickVideo(ImageSource source) async {
  final video = await ImagePicker().pickVideo(source: source);
  if (video == null) return null;
  return File(video.path);
}

Future<File?> pickFile() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result == null) return null;

  //if result is greater than 10mb show error message
  if (result.files.single.size > 10000000) {
    Toast.show("El archivo no puede ser mayor a 10MB",
        duration: 3, gravity: Toast.bottom);

    return null;
  }

  // TODO Use try catch

  return File(result.files.single.path!);
}

class _FileUploadState extends State<FileUpload> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      runAlignment: WrapAlignment.end,
      runSpacing: 50.sp,
      spacing: 50.sp,
      children: <Widget>[
        _ImageContainer(
          instruction: 'Agregar Imagen\n(Obligatoria)',
          file: _image,
          onAddPressed: () {
            seleccionarGaleriaCamara(
              context,
              onCameraTap: () async {
                _image = await pickImage(ImageSource.camera);
                setState(() {});
              },
              onGalleryTap: () async {
                _image = await pickImage(ImageSource.gallery);
                setState(() {});
              },
            );
          },
          onRemovePressed: () {
            setState(() {
              _image = null;
            });
          },
        ),
        _ImageContainer(
          instruction: 'Agregar Video\n(Opcional)\n(Max 10Mb)',
          file: _video,
          onAddPressed: () {
            seleccionarGaleriaCamara(
              context,
              onCameraTap: () async {
                _video = await pickVideo(ImageSource.camera);
                setState(() {});
              },
              onGalleryTap: () async {
                _video = await pickVideo(ImageSource.gallery);
                setState(() {});
              },
            );
          },
          onRemovePressed: () {
            setState(() {
              _video = null;
            });
          },
        ),
        _ImageContainer(
          instruction: 'Agregar Documento\n(Opcional)\n(Max 10Mb)',
          file: _file,
          onAddPressed: () async {
            _file = await pickFile();
            setState(() {});
          },
          onRemovePressed: () {
            setState(() {
              _file = null;
            });
          },
        ),
      ],
    );
  }
}

class _ImageContainer extends StatelessWidget {
  const _ImageContainer({
    Key? key,
    required this.instruction,
    this.file,
    required this.onAddPressed,
    required this.onRemovePressed,
  }) : super(key: key);
  final String instruction;
  final File? file;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;

  String get fileName => file != null ? file!.path.split('/').last : '';

  String get fileExtension => file != null ? fileName.split('.').last : '';

  bool get isImage => fileExtension == 'jpg' || fileExtension == 'png';

  bool get isVideo => fileExtension == 'mp4';

  Widget get videoThumbnail {
    if (!isVideo) return Container();
    return FutureBuilder(
      future: VideoThumbnail.thumbnailFile(
        video: file!.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 200,
        quality: 75,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Image.file(
            File(snapshot.data.toString()),
            fit: BoxFit.cover,
            width: 130.sp,
            height: 130.sp,
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget get fileTypeIcon {
    if (isImage) {
      return Center(
        child: Container(
          color: ColorTheme.darkShade,
          child: const Icon(
            FontAwesomeIcons.image,
            color: Colors.white,
          ),
        ),
      );
    }
    if (isVideo) {
      return Center(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(3.sp),
          ),
          child: const Icon(
            FontAwesomeIcons.film,
            color: ColorTheme.darkShade,
          ),
        ),
      );
    }
    return Center(
      child: Column(
        children: [
          Spacer(),
          Icon(
            fileExtension == 'pdf'
                ? FontAwesomeIcons.filePdf
                : FontAwesomeIcons.file,
            color: ColorTheme.darkShade,
          ),
          AutoSizeText(
            '$fileName',
            style: TextStyle(
              fontFamily: 'montserrat',
              fontSize: 14.sp,
              color: Color(0xFF556A8D),
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(fileExtension);
    return DottedBorder(
      borderType: BorderType.RRect,
      padding: EdgeInsets.zero,
      radius: Radius.circular(15.0.sp),
      strokeWidth: 2,
      color: Color(0xff9a9a9a),
      child: Container(
        width: 130.sp,
        height: 130.sp,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0.sp),
        ),
        child: file == null
            ? GestureDetector(
                onTap: onAddPressed,
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Spacer(flex: 3),
                      Icon(
                        Icons.add_circle,
                        size: 40.0.sp,
                        color: Color(0xffdeebf6),
                      ),
                      Spacer(),
                      Text(
                        instruction,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: ColorTheme.primaryShade,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      Spacer(flex: 3),
                    ],
                  ),
                ),
              )
            : Stack(
                children: [
                  Visibility(
                    visible: isImage,
                    child: Image.file(
                      file!,
                      fit: BoxFit.cover,
                      width: 130.sp,
                      height: 130.sp,
                    ),
                  ),
                  Visibility(
                    visible: isVideo,
                    child: videoThumbnail,
                  ),
                  Visibility(
                    // visible: !isImage && !isVideo,
                    child: fileTypeIcon,
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
                        child: InkWell(
                          onTap: onRemovePressed,
                          child: Padding(
                            padding: EdgeInsets.all(5.86.sp),
                            child: Icon(
                              FontAwesomeIcons.xmark,
                              color: Colors.white,
                              size: 18.sp,
                            ),
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

class ContenidoPaso2AOM extends StatelessWidget {
  const ContenidoPaso2AOM({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 265.h, left: 28.sp, right: 28.sp),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Center(
            child: Text(
              'Vida remantente actual del activo:',
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          Center(
            child: Text(
              '241 Meses (20,08 Años)',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '1. ¿Está de acuerdo con el valor de vida remanente del activo?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(),
          Visibility(
            //TODO: SI LA PREGUNTA 1 ESTÁ SELECCIONADA EN NO MOSTRAR LO SIGUIENTE, CASO CONTRARIO OCULTARLO
            visible: true,
            child: Column(
              children: <Widget>[
                //ROUNDED CONTAINER WITH SHADOW
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(
                    top: 20.sp,
                    left: 10.sp,
                    right: 10.sp,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                        color: titleColor.withOpacity(.1),
                        blurRadius: 20,
                        spreadRadius: 1,
                        offset: Offset(2, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Explique por qué considera diferente el valor de vida remanente:',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorTheme.primary,
                        ),
                      ),
                      SizedBox(height: 10.sp),
                      //texfield max char 250
                      TextField(
                        maxLines: 3,
                        maxLength: 250,
                        decoration: InputDecoration(
                          hintText: 'Escriba aquí...',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: ColorTheme.darkShade,
                          ),
                          //no border
                          border: InputBorder.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: 20.sp,
                    left: 10.sp,
                    right: 10.sp,
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
                  child: Column(
                    children: [
                      Text(
                        '¿Cuál es la vida útil que usted considera para el activo (En meses)?',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: ColorTheme.darkShade,
                        ),
                      ),
                      //numeric textfield

                      Center(
                        child: Container(
                          width: 130.sp,
                          margin: EdgeInsets.symmetric(
                            vertical: 15.sp,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 10.sp),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: titleColor.withOpacity(.1),
                                blurRadius: 20,
                                spreadRadius: 1,
                                offset: Offset(2, 10),
                              ),
                            ],
                          ),
                          child: TextField(
                            //make texfield text center
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.numberWithOptions(
                                decimal: false, signed: false),
                            //only numbers
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: ColorTheme.darkShade,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Escriba aquí...',
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: ColorTheme.darkShade,
                              ),
                              //no border
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text(
            'Evidencias Externas:',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: ColorTheme.primary,
            ),
          ),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '2. ¿El activo a disminuido su valor de mercado significativamente más de lo esperado por el paso del tiempo o de su uso normal?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '3. ¿Durante el periodo se evidencian cambios adversos de tipo legal o económico que afecte el valor de mercado del activo o la forma en que este es utilizado por Minergia?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(),
          Text(
            'Deterioro de Valor:',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: ColorTheme.primary,
            ),
          ),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '4. ¿El activo tiene evidencias de daño físico que den como resultado una disminución de su capacidad productiva o de su valor de mercado?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '5. ¿Han tenido lugar, o se espera que tengan lugar en un futuro inmediato, cambio en la forma en que se usa el activo lo cual conlleve a una disminución del potencial de servicio del activo?\n(Ej. Se deje de utilizar)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '6. ¿Se decide detener la construcción del activo antes de su finalización o de su puesta en condiciones de funcionamiento?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '7. ¿Se dispone de evidencia procedente de informes internos que indican que la capacidad del activo para suministrar bienes o servicios, ha disminuido o va a ser inferior a la esperada?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(),
          SizedBox(height: 20.sp),
        ],
      ),
    );
  }
}

class YesNoPurple extends StatelessWidget {
  const YesNoPurple({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          activeColor: ColorTheme.primaryTint,
          fillColor: MaterialStateProperty.all(ColorTheme.primaryTint),
          value: 1,
          groupValue: 0,
          onChanged: (value) {},
        ),
        Text(
          'Si',
          style: TextStyle(
            color: ColorTheme.darkShade,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 10),
        Radio(
          activeColor: ColorTheme.primaryTint,
          fillColor: MaterialStateProperty.all(ColorTheme.primaryTint),
          value: 0,
          groupValue: 0,
          onChanged: (value) {},
        ),
        Text(
          'No',
          style: TextStyle(
            color: ColorTheme.darkShade,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class ContenidoPaso1AOM extends StatelessWidget {
  const ContenidoPaso1AOM({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 265.h, left: 28.sp, right: 28.sp),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          AutoSizeText(
            'Registre los cambios a reportar de cada activo de la lista',
            style: TextStyle(
              fontFamily: "montserrat",
              fontSize: 15.sp,
              color: titleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.sp),
          for (var i = 1; i <= 3; i++)
            PurpleRoundedGradientContainer(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(
                    'Descripción:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Activo $i de Compensación reactiva, Vereda San Juan',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(height: 10.sp),
                  Row(
                    children: [
                      Text(
                        'Estado:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'EN OPERACIÓN',
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              color: ColorTheme.dark,
                            ),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              color: ColorTheme.dark,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            underline: Container(
                              height: 2,
                            ),
                            onChanged: (String? newValue) {},
                            items: <String>[
                              'EN OPERACIÓN',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Operatividad:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Radio(
                              activeColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.all(Colors.white),
                              value: 0,
                              groupValue: 0,
                              onChanged: (value) {},
                            ),
                            Text(
                              'Si',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Radio(
                              activeColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.all(Colors.white),
                              value: 1,
                              groupValue: 0,
                              onChanged: (value) {},
                            ),
                            Text(
                              'No',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Cantidad Actual:',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      //-+ counter
                      Container(
                        width: 130.sp,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                            Text(
                              '17',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.sp),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class PurpleRoundedGradientContainer extends StatelessWidget {
  const PurpleRoundedGradientContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Color(0xff666666).withOpacity(0.26),
              blurRadius: 14.sp,
              spreadRadius: 0.4.sp,
              offset: Offset(4.sp, 10.sp)),
        ],
        borderRadius: BorderRadius.circular(16.13.sp),
        gradient: ColorTheme.cardGradient,
      ),
      padding: EdgeInsets.only(
        left: 15.sp,
        right: 15.sp,
        top: 20.45.sp,
        bottom: 20.45.sp,
      ),
      margin: EdgeInsets.symmetric(vertical: 10.sp),
      child: child,
    );
  }
}
