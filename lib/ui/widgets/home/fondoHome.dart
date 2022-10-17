import 'package:appalimentacion/theme/color_theme.dart';
import 'package:appalimentacion/ui/widgets/global_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FondoHome extends StatefulWidget {
  final Widget body;
  final Widget bottomNavigationBar;
  final bool primeraPagina;

  FondoHome({
    Key key,
    this.body,
    this.bottomNavigationBar,
    this.primeraPagina,
  }) : super(key: key);

  @override
  State<FondoHome> createState() => _FondoHomeState();
}

class _FondoHomeState extends State<FondoHome> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        drawer: GlobalDrawer(),
        backgroundColor: Color(0xffF6F4FC),
        body: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 214.sp,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.sp),
                    bottomRight: Radius.circular(15.sp)),
                gradient: ColorTheme.backgroundGradient,
              ),
            ),
            widget.body,
            widget.primeraPagina != null
                ? Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                        padding: EdgeInsets.only(
                            right: 14.sp, left: 14.sp, top: 50.h),
                        child: IconButton(
                          onPressed: () {
                            _drawerKey.currentState.openDrawer();
                          },
                          icon: Icon(
                            FontAwesomeIcons.bars,
                            color: Colors.white,
                            size: 25.sp,
                          ),
                        )))
                : Text('')
          ],
        ),
        bottomNavigationBar: widget.bottomNavigationBar != null
            ? widget.bottomNavigationBar
            : null);
  }
}
