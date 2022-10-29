import 'dart:async';
import 'dart:math';

import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

class DetailCardWidget extends StatefulWidget {
  const DetailCardWidget(this.numeroDeActivo, {Key? key}) : super(key: key);

  final int numeroDeActivo;

  @override
  State<DetailCardWidget> createState() => _DetailCardWidgetState();
}

class _DetailCardWidgetState extends State<DetailCardWidget> {
  var intValue = Random().nextInt(20) + 7;
  Timer? timer;
  late int count;

  int _operatividad = 0;

  int get operatividad => _operatividad;

  double? screenWidth;

  set operatividad(int value) => setState(() => _operatividad = value);

  @override
  void initState() {
    super.initState();
    count = intValue;
  }

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    if (count == 0) {
      Toast.show('No puede ingresar valor negativos', duration: 5);
      return;
    }
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);

    screenWidth = MediaQuery.of(context).size.width;
    double factor = ((screenWidth ?? 0) / 414.0);
    print('screenwidth: $screenWidth');
    print('FACTOR: $factor');
    return PurpleRoundedGradientContainer(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: (361 * factor).sp),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Wrap(
              runSpacing: (3 * factor).sp,
              children: [
                Text(
                  'Descripción:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Activo ${widget.numeroDeActivo} de Compensación reactiva, Vereda San Juan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.sp),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: (147 * factor).sp),
                  child: Text(
                    'Estado:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                // Spacer(),
                Container(
                  constraints: BoxConstraints(
                      maxWidth: (176 * factor).sp, maxHeight: (28 * factor).sp),
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
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
                          child: Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    color: Color(0xFF384C68),
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.sp),
            Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(
                      minWidth: (137 * factor).sp, maxHeight: (28 * factor).sp),
                  child: Text(
                    'Operatividad:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
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
                      Text(
                        'SI',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: (20 * factor).sp),
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
                      Text(
                        'NO',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.sp),
            Row(
              children: <Widget>[
                ConstrainedBox(
                  constraints: BoxConstraints(minWidth: (147 * factor).sp),
                  child: Text(
                    'Cantidad Actual:',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),

                //-+ counter
                Container(
                  constraints: BoxConstraints(
                      maxWidth: (120 * factor).sp, maxHeight: (32 * factor).sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.1277.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: GestureDetector(
                            child: IconButton(
                              icon: Icon(
                                Icons.remove,
                                color: Color(0xFF384C68),
                                size: 20.sp,
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
                        style: TextStyle(
                          color: Color(0xFF384C68),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: GestureDetector(
                            child: IconButton(
                              icon: Icon(
                                Icons.add,
                                color: Color(0xFF384C68),
                                size: 20.sp,
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
            SizedBox(height: 26.sp),
            const _DisposicionActualField(),
          ],
        ),
      ),
    );
  }
}

class _DisposicionActualField extends StatefulWidget {
  const _DisposicionActualField({
    Key? key,
  }) : super(key: key);

  @override
  State<_DisposicionActualField> createState() =>
      _DisposicionActualFieldState();
}

class _DisposicionActualFieldState extends State<_DisposicionActualField> {
  TextEditingController controller = TextEditingController();

  late String hintText;

  @override
  void initState() {
    super.initState();
    hintText =
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore';
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
          minHeight: 103.sp, maxHeight: 318.sp, maxWidth: 318.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.sp),
          gradient: LinearGradient(
            // stops: [-0.2898, 1.2332],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            tileMode: TileMode.mirror,
            colors: <Color>[
              Color(0xffF0E9FF),
              Color(0xffF0E9FF),
            ],
          ),
          boxShadow: [
            BoxShadow(
                offset: Offset(4.sp, 10.sp),
                blurRadius: 14,
                spreadRadius: 0,
                color: Color.fromRGBO(102, 102, 102, 0.26))
          ]),
      child: Padding(
        padding: EdgeInsets.only(
            left: 8.sp, right: 9.sp, top: 6.37.sp, bottom: 11.5.sp),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            'Actualice la disposición actual del activo (Opcional):',
            style: Theme.of(context).textTheme.headline6?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Color(0xFF836FF8),
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
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF556A8D),
                ),
          )
        ]),
      ),
    );
  }
}
