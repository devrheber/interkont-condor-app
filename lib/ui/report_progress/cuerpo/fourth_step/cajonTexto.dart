import 'package:appalimentacion/ui/report_progress/cuerpo/fourth_step/fouth_step_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

final titleColor = Color(0xff444444);

class CajonTextoComentarios extends StatefulWidget {
  const CajonTextoComentarios({
    Key? key,
    required this.textoHint,
    required this.textoTitulo,
    required this.onChanged,
  }) : super(key: key);

  final String textoTitulo;
  final String textoHint;
  final Function(String) onChanged;

  @override
  State<CajonTextoComentarios> createState() => _CajonTextoComentariosState();
}

class _CajonTextoComentariosState extends State<CajonTextoComentarios> {
  TextEditingController controllerCuartoPasoTxtComentarios =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    controllerCuartoPasoTxtComentarios.text =
        context.read<FourthStepProvider>().cache.comment ?? '';
  }

  @override
  void dispose() {
    controllerCuartoPasoTxtComentarios.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 106.2.h,
      margin: EdgeInsets.only(top: 35.sp),
      padding: EdgeInsets.only(left: 15.0.sp, right: 15.sp, top: 13.27.sp),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Image.asset('assets/new/home/comments.png',
                    width: 18.85.w, height: 18.85.w),
              ),
              SizedBox(width: 11.8.sp),
              Expanded(
                child: Text(
                  '${widget.textoTitulo}',
                  style: TextStyle(
                    color: Color(0xff556A8D),
                    fontSize: 15.27.sp,
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10.0),
              child: TextField(
                textInputAction: TextInputAction.send,
                controller: controllerCuartoPasoTxtComentarios,
                onChanged: widget.onChanged,
                maxLines: 4,
                style: TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  color: Color(0xff556A8D),
                ),
                decoration: InputDecoration.collapsed(
                  hintText: "${widget.textoHint}",
                  hintStyle: TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 14.sp,
                    color: Color(0xff556A8D).withOpacity(0.8),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
