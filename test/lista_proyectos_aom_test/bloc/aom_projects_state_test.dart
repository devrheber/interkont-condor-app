import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/ui/lista_proyectos_aom_page/bloc/aom_projects_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Project mockProject = Project(
      codigoproyecto: 001,
      nombreproyecto: 'Proyecto de Prueba',
      valorproyecto: 10000,
      valorejecutado: 0,
      porcentajeProyectado: 0,
      semaforoproyecto: 'verde',
      codigocategoria: 001,
      imagencategoria: '',
      colorcategoria: 'colorCategorio',
      nombrecategoria: 'categoria-1',
      objeto: 'objeto',
      pendienteAprobacion: false);

  final mockProjects = [mockProject];

  group('AOMProjectState', () {
    AomProjectsState createSubject({
      AomProjectsStatus status = AomProjectsStatus.initial,
      List<Project>? projects,
    }) {
      return AomProjectsState(
        status: status,
        projects: projects ?? mockProjects,
      );
    }

    test('supports value equality', () {
      expect(
        createSubject(),
        equals(createSubject()),
      );
    });

    test('props are correct', () {
      expect(
        createSubject(
          status: AomProjectsStatus.initial,
          projects: mockProjects,
        ).props,
        equals(<Object?>[
          AomProjectsStatus.initial,
          mockProjects,
        ]),
      );
    });

    group('copyWith', () {
      test('return the same object if not arguments are provide', () {
        expect(
          createSubject().copyWith(),
          equals(createSubject()),
        );
      });

      test('retains the old value for every parameter if null is provider', () {
        expect(
          createSubject().copyWith(
            status: null,
            projects: null,
          ),
          equals(createSubject()),
        );
      });

      test('replaces every non-null parameter', () {
        expect(
          createSubject().copyWith(
            status: () => AomProjectsStatus.success,
            projects: () => [],
          ),
          equals(
            createSubject(
              status: AomProjectsStatus.success,
              projects: [],
            ),
          ),
        );
      });
    });
  });
}
