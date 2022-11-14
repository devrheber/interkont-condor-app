import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/projects_repository.dart';
import 'package:appalimentacion/ui/lista_proyectos_aom_page/bloc/aom_projects_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProjectsRepository extends Mock implements ProjectsRepository {}

class FakeProject extends Fake implements Project {}

void main() {
  final mockProjects = [
    Project(
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
      pendienteAprobacion: false,
      estadoobra: 9,
    ),
    Project(
      codigoproyecto: 002,
      nombreproyecto: 'Proyecto de Prueba 2',
      valorproyecto: 10000,
      valorejecutado: 0,
      porcentajeProyectado: 0,
      semaforoproyecto: 'verde',
      codigocategoria: 001,
      imagencategoria: '',
      colorcategoria: 'colorCategorio',
      nombrecategoria: 'categoria-1',
      objeto: 'objeto',
      pendienteAprobacion: false,
      estadoobra: 9,
    ),
    Project(
      codigoproyecto: 003,
      nombreproyecto: 'Proyecto de Prueba 3',
      valorproyecto: 10000,
      valorejecutado: 0,
      porcentajeProyectado: 0,
      semaforoproyecto: 'verde',
      codigocategoria: 001,
      imagencategoria: '',
      colorcategoria: 'colorCategorio',
      nombrecategoria: 'categoria-1',
      objeto: 'objeto',
      pendienteAprobacion: false,
      estadoobra: 9,
    ),
  ];

  group('AOMProjectsBloc', () {
    late ProjectsRepository projectsRepository;

    setUp(() {
      registerFallbackValue(FakeProject());
    });

    setUp(() {
      projectsRepository = MockProjectsRepository();
      when(
        () => projectsRepository.getAomProjects(),
      ).thenAnswer((_) => Future.value(mockProjects));
    });

    AomProjectsBloc buildBloc() {
      return AomProjectsBloc(projectsRepository: projectsRepository);
    }

    group('constructor', () {
      test('works properly', () => expect(buildBloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          buildBloc().state,
          equals(const AomProjectsState()),
        );
      });
    });

    group('AOMProjectGetProjects', () {
      blocTest<AomProjectsBloc, AomProjectsState>('starts get getProjects',
          build: buildBloc,
          act: (bloc) => bloc.add(AomProjectsGetProjects()),
          verify: (_) {
            verify(() => projectsRepository.getAomProjects()).called(1);
          });
    });

    blocTest<AomProjectsBloc, AomProjectsState>(
      'emits state with updated status and projects',
      build: buildBloc,
      act: (bloc) => bloc.add(AomProjectsGetProjects()),
      expect: () => [
        const AomProjectsState(
          status: AomProjectsStatus.loading,
        ),
        AomProjectsState(
          status: AomProjectsStatus.success,
          projects: mockProjects,
        )
      ],
    );

    blocTest<AomProjectsBloc, AomProjectsState>(
      'emits state with failure status '
      'when repository getProjects emits error',
      setUp: () {
        when(
          () => projectsRepository.getAomProjects(),
        ).thenAnswer((_) => Future.error(Exception('oops')));
      },
      build: buildBloc,
      act: (bloc) => bloc.add(AomProjectsGetProjects()),
      expect: () => [
        const AomProjectsState(status: AomProjectsStatus.loading),
        const AomProjectsState(status: AomProjectsStatus.failure),
      ],
    );
  });
}
