import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'fouth_step_provider.dart';

const titleColor = Color(0xff444444);

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
      height: 106.2,
      margin: const EdgeInsets.only(top: 35),
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 13.27),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Image.asset('assets/new/home/comments.png',
                    width: 18.85, height: 18.85),
              ),
              const SizedBox(width: 11.8),
              Expanded(
                child: Text(
                  widget.textoTitulo,
                  style: const TextStyle(
                    color: Color(0xff556A8D),
                    fontSize: 15.27,
                    fontFamily: "montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextField(
                textInputAction: TextInputAction.send,
                controller: controllerCuartoPasoTxtComentarios,
                onChanged: widget.onChanged,
                maxLines: 4,
                style: const TextStyle(
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Color(0xff556A8D),
                ),
                decoration: InputDecoration.collapsed(
                  hintText: widget.textoHint,
                  hintStyle: TextStyle(
                    fontFamily: 'montserrat',
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: const Color(0xff556A8D).withOpacity(0.8),
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
