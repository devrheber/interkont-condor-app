import 'dart:async';

import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/helpers/helpers.dart';
import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class DetailCardWidget extends StatefulWidget {
  const DetailCardWidget(
    this.item, {
    Key? key,
    required this.estados,
    required this.onChanged,
  }) : super(key: key);

  final GestionAom item;
  final List<EstadoDeActivo> estados;
  final Function(ActivoUpdateRequest) onChanged;

  @override
  State<DetailCardWidget> createState() => _DetailCardWidgetState();
}

class _DetailCardWidgetState extends State<DetailCardWidget> {
  Timer? timer;
  int _count = 0;

  late ActivoUpdateRequest _activo;

  ActivoUpdateRequest get activo => _activo;

  set activo(ActivoUpdateRequest value) {
    _activo = value;
    widget.onChanged(_activo);
  }

  EstadoDeActivo? _estado;

  EstadoDeActivo? get estado => _estado;

  set estado(EstadoDeActivo? value) {
    Future.delayed(const Duration(milliseconds: 200))
        .then((_) => setState(() => _estado = value));
  }

  int get count => _count;

  set count(int value) {
    setState(() => _count = value);
  }

  int _operatividad = 0;

  int get operatividad => _operatividad;

  double? screenWidth;

  set operatividad(int value) => setState(() {
        _operatividad = value;
        activo = activo.copyWith(operatividad: _operatividad == 1);
      });

  @override
  void initState() {
    super.initState();
    _count = widget.item.cantidad;
    _operatividad = widget.item.operatividad ? 1 : 0;
    estado = _getEstadoSeleccionado(widget.item.estadoAomId);

    activo = ActivoUpdateRequest(
      id: widget.item.id,
      cantidad: widget.item.cantidad,
      cantidadPropuesta: _count,
      estadoAomId: widget.item.estadoAomId,
      observacion: widget.item.observacion ?? '',
      operatividad: widget.item.operatividad,
    );
  }

  void increment() {
    setState(() => count++);
    activo = activo.copyWith(cantidadPropuesta: count);
  }

  void decrement() {
    if (count == 0) {
      Toast.show('No puede ingresar valor negativos', duration: 5);
      return;
    }
    setState(() => count--);
    activo = activo.copyWith(cantidadPropuesta: count);
  }

  EstadoDeActivo? _getEstadoSeleccionado(int estadoId) {
    final index = widget.estados.indexWhere((estado) => estado.id == estadoId);

    if (index < 0) return null;

    return widget.estados[index];
  }

  final dynamic debouncer =
      Debouncer<dynamic>(duration: const Duration(milliseconds: 200));

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    screenWidth = MediaQuery.of(context).size.width;
    double factor = ((screenWidth ?? 0) / 414.0);

    return PurpleRoundedGradientContainer(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: (361 * factor)),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Descripción:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  widget.item.descripcionDetalle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: (147 * factor)),
                  child: const Text(
                    'Estado:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: (176 * factor), maxHeight: (28 * factor)),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropDownEstado(
                    list: widget.estados,
                    value: estado,
                    onChanged: (EstadoDeActivo? newValue) {
                      if (newValue == null) return;
                      estado = newValue;
                      activo = activo.copyWith(estadoAomId: newValue.id);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: (137 * factor), maxHeight: (28 * factor)),
                  child: const Text(
                    'Operatividad:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        activeColor: Colors.white,
                        fillColor: MaterialStateProperty.all(Colors.white),
                        value: 1,
                        groupValue: operatividad,
                        onChanged: (int? value) {
                          operatividad = value ?? 00;
                        },
                      ),
                      const Text(
                        'SI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: (20 * factor)),
                      // TODO CustomRadio
                      Radio(
                        activeColor: Colors.white,
                        fillColor: MaterialStateProperty.all(Colors.white),
                        value: 0,
                        groupValue: operatividad,
                        onChanged: (int? value) {
                          operatividad = value ?? 1;
                        },
                      ),
                      const Text(
                        'NO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: (147 * factor)),
                  child: const Text(
                    'Cantidad Actual:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                //-+ counter
                Container(
                  constraints: BoxConstraints(
                      maxWidth: (120 * factor), maxHeight: (32 * factor)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.1277),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: GestureDetector(
                            child: IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Color(0xFF384C68),
                                size: 20,
                              ),
                              onPressed: () => decrement(),
                            ),
                            onLongPressStart: (details) {
                              if (count == 0) return;
                              timer = Timer.periodic(
                                  const Duration(milliseconds: 100), (timer) {
                                decrement();
                              });
                            },
                            onLongPressEnd: (details) {
                              timer?.cancel();
                            },
                          ),
                        ),
                      ),
                      Text(
                        '$count',
                        style: const TextStyle(
                          color: Color(0xFF384C68),
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: GestureDetector(
                            child: IconButton(
                              icon: const Icon(
                                Icons.add,
                                color: Color(0xFF384C68),
                                size: 20,
                              ),
                              onPressed: () => increment(),
                            ),
                            onLongPressStart: (details) {
                              if (count == 0) return;
                              timer = Timer.periodic(
                                  const Duration(milliseconds: 100), (timer) {
                                increment();
                              });
                            },
                            onLongPressEnd: (details) {
                              timer?.cancel();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            _DisposicionActualField(
              widget.item.observacion ?? '',
              onChanged: (String? observacion) {
                debouncer.value = observacion;
                debouncer.onValue = (dynamic value) async {
                  activo = activo.copyWith(observacion: observacion);
                };

                final Timer timer =
                    Timer.periodic(const Duration(milliseconds: 200), (_) {
                  debouncer.value = observacion;
                });

                Future<void>.delayed(const Duration(milliseconds: 201))
                    .then((_) => timer.cancel());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DropDownEstado extends StatelessWidget {
  const DropDownEstado({
    Key? key,
    required this.list,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  final List<EstadoDeActivo> list;
  final EstadoDeActivo? value;
  final Function(EstadoDeActivo? value) onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<EstadoDeActivo>(
        isExpanded: true,
        value: value,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: ColorTheme.dark,
        ),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(
          color: ColorTheme.dark,
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        underline: Container(
          height: 2,
        ),
        onChanged: (EstadoDeActivo? newValue) {
          onChanged(newValue);
        },
        items:
            list.map<DropdownMenuItem<EstadoDeActivo>>((EstadoDeActivo item) {
          return DropdownMenuItem<EstadoDeActivo>(
            value: item,
            child: Text(
              item.strNombreEstado,
              style: Theme.of(context).textTheme.headline6?.copyWith(
                  color: const Color(0xFF384C68),
                  fontSize: 12,
                  fontWeight: FontWeight.w500),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _DisposicionActualField extends StatefulWidget {
  const _DisposicionActualField(
    this.value, {
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final String value;
  final Function(String?) onChanged;

  @override
  State<_DisposicionActualField> createState() =>
      _DisposicionActualFieldState();
}

class _DisposicionActualFieldState extends State<_DisposicionActualField> {
  late TextEditingController controller;

  late String hintText;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
    hintText = '';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
          minHeight: 103, maxHeight: 318, maxWidth: 318),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            // stops: [-0.2898, 1.2332],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.mirror,
            colors: <Color>[
              Color(0xffF0E9FF),
              Color(0xffF0E9FF),
            ],
          ),
          boxShadow: const [
            BoxShadow(
                offset: Offset(4, 10),
                blurRadius: 14,
                spreadRadius: 0,
                color: Color.fromRGBO(102, 102, 102, 0.26))
          ]),
      child: Padding(
        padding: const EdgeInsets.only(
            left: 8, right: 9, top: 6.37, bottom: 11.5),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Actualice la disposición actual del activo (Opcional):',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: const Color(0xFF836FF8),
                ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 10,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
            ),
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF556A8D),
                ),
            onChanged: widget.onChanged,
          )
        ]),
      ),
    );
  }
}
