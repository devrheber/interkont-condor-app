import 'package:appalimentacion/theme/color_theme.dart';
import 'package:flutter/material.dart';

class YesNoPurple extends StatefulWidget {
  const YesNoPurple({
    Key? key,
    required this.onChanged,
    this.initialValue = 1,
  }) : super(key: key);

  final Function(int) onChanged;
  final int initialValue;

  @override
  State<YesNoPurple> createState() => _YesNoPurpleState();
}

class _YesNoPurpleState extends State<YesNoPurple> {
  late int _valueSelected;

  int get valueSelected => _valueSelected;

  set valueSelected(int? value) => setState(() {
        if (value == null) return;
        _valueSelected = value;
        widget.onChanged(_valueSelected);
      });

  @override
  void initState() {
    super.initState();
    _valueSelected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio(
          activeColor: ColorTheme.primaryTint,
          fillColor: MaterialStateProperty.all(ColorTheme.primaryTint),
          value: 1,
          groupValue: valueSelected,
          onChanged: (int? value) {
            valueSelected = value;
          },
        ),
        InkWell(
          onTap: () => valueSelected = 1,
          child: const Text(
            'SI',
            style: TextStyle(
              color: ColorTheme.darkShade,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Radio(
          activeColor: ColorTheme.primaryTint,
          fillColor: MaterialStateProperty.all(ColorTheme.primaryTint),
          value: 0,
          groupValue: valueSelected,
          onChanged: (int? value) {
            valueSelected = value;
          },
        ),
        InkWell(
          onTap: () => valueSelected = 0,
          child: const Text(
            'NO',
            style: TextStyle(
              color: ColorTheme.darkShade,
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
