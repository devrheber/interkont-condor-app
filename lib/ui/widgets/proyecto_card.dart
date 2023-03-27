import 'package:appalimentacion/globales/colores.dart';
import 'package:appalimentacion/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/models/models.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    Key? key,
    required this.project,
    required this.onTap,
    required this.detailSyncronized,
    required this.stream,
  }) : super(key: key);

  final Project project;
  final VoidCallback onTap;
  final bool detailSyncronized;
  final Widget stream;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 1, top: 1),
              padding: const EdgeInsets.only(
                  top: 24, bottom: 24, left: 28, right: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Spacer(),
                      ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: 50, maxHeight: 50),
                        child: ClipOval(
                            child: CachedNetworkImage(
                          imageUrl: project.imagencategoria,
                          placeholder: (_, __) => Image.asset(
                            'assets/img/Desglose/Demas/question.png',
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 50,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10.0),
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
                                        fontSize: 10,
                                        letterSpacing: 0.4,
                                        color: Color(
                                          project.titleColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 3.5,
                              ),
                              Text(
                                project.nombreproyecto,
                                style: const TextStyle(
                                  fontFamily: "montserrat",
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: Color(0xFF000000),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 5,
                                    child: Column(
                                      children: <Widget>[
                                        const SizedBox(
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
                                                style: const TextStyle(
                                                  fontFamily: "montserrat",
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 15,
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
                                                      color: Color(0xFF000000),
                                                    ),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    PercentajeFormat.percentaje(
                                                        project
                                                            .percentageByValue),
                                                    style: const TextStyle(
                                                      fontFamily: "montserrat",
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
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
                                                      BorderRadius.circular(5),
                                                  clipBehavior: Clip.antiAlias,
                                                  child: Image.asset(
                                                    'assets/img/Desglose/Home/${project.trafficLightColorValue}.png',
                                                    height: 19,
                                                    width: 50.95,
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
                  if (detailSyncronized)
                    const Text('Detalle de proyecto aún no sincronizado',
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          letterSpacing: 0.4,
                          color: AppTheme.treceavo,
                        )),
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
