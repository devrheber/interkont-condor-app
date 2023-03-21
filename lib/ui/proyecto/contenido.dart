import 'package:flutter/material.dart';

import '../../domain/models/models.dart';
import 'cardTitulo.dart';
import 'cuerpo.dart';

const titleColor = Color(0xff444444);

class ProjectContent extends StatelessWidget {
  const ProjectContent({
    Key? key,
    required this.projectCache,
    required this.project,
  }) : super(key: key);

  final ProjectCache projectCache;
  final Project project;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: const <Widget>[
          CardTitulo(),
          BodyCard(),
        ],
      ),
    );
  }
}
