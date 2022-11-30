import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../theme/color_theme.dart';
import '../global_drawer.dart';

class FondoHome extends StatefulWidget {
  const FondoHome({
    Key? key,
    required this.body,
    this.showMenuButton = false,
    this.bottomNavigationBar,
  }) : super(key: key);

  final Widget body;
  final Widget? bottomNavigationBar;
  final bool showMenuButton;

  @override
  State<FondoHome> createState() => _FondoHomeState();
}

class _FondoHomeState extends State<FondoHome> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _drawerKey,
        drawer: const GlobalDrawer(),
        backgroundColor: const Color(0xffF6F4FC),
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
            if (widget.showMenuButton)
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding:
                      EdgeInsets.only(right: 14.sp, left: 14.sp, top: 50.sp),
                  child: IconButton(
                    onPressed: () {
                      _drawerKey.currentState?.openDrawer();
                    },
                    icon: Icon(
                      FontAwesomeIcons.bars,
                      color: Colors.white,
                      size: 25.sp,
                    ),
                  ),
                ),
              )
          ],
        ),
        bottomNavigationBar: widget.bottomNavigationBar);
  }
}
