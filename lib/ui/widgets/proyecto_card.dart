import 'package:appalimentacion/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../domain/models/models.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard(
      {Key? key,
      required this.project,
      required this.onTap,
      required this.stream})
      : super(key: key);

  final Project project;
  final VoidCallback onTap;
  final Widget stream;

  @override
  Widget build(BuildContext context) {
    // final provider = context.read<ProjectsProvider>();
    return Card(
      elevation: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 1.sp, top: 1.sp),
              padding: EdgeInsets.only(
                  top: 24.sp, bottom: 24.sp, left: 28.sp, right: 4.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Spacer(),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 50, maxHeight: 50),
                        child: ClipOval(
                            child: CachedNetworkImage(
                          imageUrl: project.imagencategoria,
                          placeholder: (_, __) => Image.asset(
                            'assets/img/Desglose/Demas/question.png',
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )),
                      ),
                      Spacer(),
                      Expanded(
                        flex: 50,
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      project.nombreCategoriaUpperCase,
                                      style: TextStyle(
                                        fontFamily: 'montserrat',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 10.sp,
                                        letterSpacing: 0.4,
                                        color: Color(
                                          project.titleColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3.5,
                              ),
                              Text(
                                project.nombreproyecto,
                                style: TextStyle(
                                  fontFamily: "montserrat",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13.sp,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5.0,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Container(
                                              width: 90.0,
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  right: BorderSide(
                                                    width: 0.3,
                                                    color: Color(0xFF000000),
                                                  ),
                                                ),
                                              ),
                                              child: AutoSizeText(
                                                project.projectValueRounded,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontFamily: "montserrat",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15.sp,
                                                  letterSpacing: 0.4,
                                                  height: 0.9,
                                                  color: Color(0xFF808080),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                      width: 0.3,
                                                      color:
                                                          Color(0xFFFF000000),
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    PercentajeFormat.percentaje(
                                                        project
                                                            .percentageByValue),
                                                    style: TextStyle(
                                                      fontFamily: "montserrat",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15.sp,
                                                      letterSpacing: 0.4,
                                                      height: 0.9,
                                                      color: Color(0xFF808080),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Center(
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.sp),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Image.asset(
                                                    'assets/img/Desglose/Home/${project.trafficLightColorValue}.png',
                                                    height: 19.sp,
                                                    width: 50.95.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  stream,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
