import 'package:appalimentacion/app/data/provider/user_preferences.dart';
import 'package:appalimentacion/domain/models/models.dart';
import 'package:flutter/material.dart';

class ProjectCacheProvider extends ChangeNotifier {
  ProjectCacheProvider({@required this.prefs});
  final UserPreferences prefs;

  Map<String, ProjectCache> projectsCache;

  // TODO
  // Future<void> saveInLocalStorage() async {
  //   print('saving local projects');
  //   prefs.projects = vistaListaResponseToJson(localProjects);
  // }

  Future<void> cambiarPasoProyecto(int projectCode, int numeroPaso) async {
    if (projectsCache.containsKey('$projectCode')) {
      projectsCache['$projectCode'] = projectsCache['$projectCode'].copyWith(
        stepNumber: numeroPaso,
      );
    } else {
      projectsCache['$projectCode'] = ProjectCache(stepNumber: numeroPaso);
    }

    // TODO
    // saveInLocalStorage();
  }

  ProjectCache getProjectCache(int projectCode) {
    if (projectsCache.containsKey('$projectCode')) {
      return projectsCache['$projectCode'];
    } else {
      projectsCache['$projectCode'] = ProjectCache(stepNumber: 0);
      return projectsCache['$projectCode'];
    }
  }
}
