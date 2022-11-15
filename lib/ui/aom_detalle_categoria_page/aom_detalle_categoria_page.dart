import 'dart:async';
import 'dart:io';

import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/globales/customed_app_bar.dart';
import 'package:appalimentacion/routes/app_routes.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/aom_detalle_categoria_page/cubit/aom_detail_categories_cubit.dart';
import 'package:appalimentacion/ui/report_progress/cabecera/header_steps.dart';
import 'package:appalimentacion/ui/widgets/fade_in_widget.dart';
import 'package:appalimentacion/ui/widgets/home/custom_bottom_navigation_bar.dart';
import 'package:appalimentacion/ui/widgets/home/fondoHome.dart';
import 'package:appalimentacion/ui/widgets/shimmer_detalle_activo_widget.dart';
import 'package:appalimentacion/ui/widgets/step_indicator.dart';
import 'package:appalimentacion/utils/seleccionar_foto_documentos.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:toast/toast.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import 'widgets/detail_card_widget.dart';
import 'widgets/question_one_widget.dart';
import 'widgets/yes_no_purple_widget.dart';

class AomDetalleCategoriaPage extends StatefulWidget {
  const AomDetalleCategoriaPage({
    Key? key,
  }) : super(key: key);

  @override
  State<AomDetalleCategoriaPage> createState() =>
      _AomDetalleCategoriaPageState();
}

class _AomDetalleCategoriaPageState extends State<AomDetalleCategoriaPage> {
  int paso = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get pushnamed arguments
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    String nombre = arguments['nombre'];
    paso = arguments['paso'];
    // int paso = arguments['paso'];
    // String nombre = 'Nombre';
    // int paso = 1;

    TextStyle textStyleStepSelected = TextStyle(
      fontFamily: "montserrat",
      fontSize: 10.sp,
      color: Color(0xff556A8D),
      fontWeight: FontWeight.w700,
    );

    TextStyle textStyleStep = TextStyle(
      fontFamily: "montserrat",
      fontSize: 10.sp,
      color: Color(0xff556A8D),
      fontWeight: FontWeight.w400,
    );

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
              return;
            }
            setState(() => paso++);
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
                  completedColor: Color(0xFF1A8DBE),
                  pendingColor: Color(0xFF745FF2),
                  style: paso == 1 ? textStyleStepSelected : textStyleStep,
                ),
                StepIndicator(
                  text: 'Actualización\nCualitativo',
                  number: '2',
                  isCompleted: paso >= 2,
                  completedColor: Color(0xFF1A8DBE),
                  pendingColor: Color(0xFF745FF2),
                  style: paso == 2 ? textStyleStepSelected : textStyleStep,
                ),
                StepIndicator(
                  text: 'Imágen o\n Video',
                  number: '3',
                  isCompleted: paso >= 3,
                  completedColor: Color(0xFF1A8DBE),
                  pendingColor: Color(0xFF745FF2),
                  style: paso == 3 ? textStyleStepSelected : textStyleStep,
                ),
              ],
            ),
          ),
          Visibility(
            visible: paso == 1,
            child: ContenidoPaso1AOM.init(
              //! Replace
              projectCode: 2979,
            ),
          ),
          Visibility(
            visible: paso == 2,
            child: const ContenidoPaso2AOM(),
          ),
          Visibility(
            visible: paso == 3,
            child: const ContenidoPaso3AOM(),
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
    int monthsInitialValue = 241;

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
                fontSize: 15.sp,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          Center(
            child: Text(
              '$monthsInitialValue Meses (20,08 Años)',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          SizedBox(height: 20.sp),
          QuestionOne(monthsInitialValue: monthsInitialValue),
          Text(
            'Evidencias Externas:',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: ColorTheme.primary,
            ),
          ),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '2. ¿El activo a disminuido su valor de mercado significativamente más de lo esperado por el paso del tiempo o de su uso normal?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(
            onChanged: (int? value) {},
          ),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '3. ¿Durante el periodo se evidencian cambios adversos de tipo legal o económico que afecte el valor de mercado del activo o la forma en que este es utilizado por Minergia?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(
            onChanged: (int? value) {},
          ),
          Text(
            'Deterioro de Valor:',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: ColorTheme.primary,
            ),
          ),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '4. ¿El activo tiene evidencias de daño físico que den como resultado una disminución de su capacidad productiva o de su valor de mercado?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(
            onChanged: (int? value) {},
          ),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '5. ¿Han tenido lugar, o se espera que tengan lugar en un futuro inmediato, cambio en la forma en que se usa el activo lo cual conlleve a una disminución del potencial de servicio del activo?\n(Ej. Se deje de utilizar)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(
            onChanged: (int? value) {},
          ),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '6. ¿Se decide detener la construcción del activo antes de su finalización o de su puesta en condiciones de funcionamiento?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(
            onChanged: (int? value) {},
          ),
          SizedBox(height: 20.sp),
          Center(
            child: Text(
              '7. ¿Se dispone de evidencia procedente de informes internos que indican que la capacidad del activo para suministrar bienes o servicios, ha disminuido o va a ser inferior a la esperada?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
                color: ColorTheme.darkShade,
              ),
            ),
          ),
          YesNoPurple(
            onChanged: (int? value) {},
          ),
          SizedBox(height: 20.sp),
        ],
      ),
    );
  }
}

class ContenidoPaso1AOM extends StatelessWidget {
  const ContenidoPaso1AOM._({
    Key? key,
  }) : super(key: key);

  static Widget init({Key? key, required int projectCode}) {
    return BlocProvider(
      lazy: false,
      create: (context) => AomDetailCategoriesCubit(
        aomProjectsRepository: context.read(),
        aomProjectsApi: context.read(),
      )..loadData(projectCode),
      child: ContenidoPaso1AOM._(key: key),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AomDetailCategoriesCubit, AomDetailCategoriesState>(
      buildWhen: ((previous, current) => previous.status != current.status),
      builder: (context, state) {
        if (state.status == AomDetailCategoriesStatus.loading) {
          return Builder(builder: (context) {
            return Container(
              margin: EdgeInsets.only(top: 265.h, left: 28.sp, right: 28.sp),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (_, int index) {
                  return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.sp),
                      padding: EdgeInsets.only(
                        left: 15.sp,
                        right: 15.sp,
                        top: 20.45.sp,
                        bottom: 20.45.sp,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.13.sp),
                          color: ColorTheme.primary.withOpacity(0.05)),
                      child: ShimmerDetallerActivoWidget());
                },
                separatorBuilder: (_, int index) => SizedBox(height: 10.sp),
              ),
            );
          });
        }

        return FadeIn(
          duration: const Duration(milliseconds: 1500),
          child: Container(
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
                for (final item in state.gestionAom) DetailCardWidget(item),
              ],
            ),
          ),
        );
      },
    );
  }
}
