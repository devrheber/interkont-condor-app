import 'package:appalimentacion/ui/lista_proyectos_aom_page/bloc/aom_projects_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AOMProjectsEvent', () {
    group('AOMProjectsGetProjects', () {
      test('supports value equality', () {
        expect(
          AomProjectsGetProjects().props,
          equals(<Object?>[]),
        );
      });
    });
  });
}
