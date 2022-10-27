import 'package:appalimentacion/domain/models/clasificacion.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'clasification_state.dart';

class ClasificationCubit extends Cubit<ClasificationState> {
  ClasificationCubit({
    required AomProjectsRepository aomProjectsRepository,
  })  : _aomProjectsRepository = aomProjectsRepository,
        super(ClasificationState());

  final AomProjectsRepository _aomProjectsRepository;

  Future<void> getClasifications() async {
    emit(state.copyWith(status: () => ClasificationsStatus.loading));

    try {
      final list = await _aomProjectsRepository.getClasifications();
      emit(
        state.copyWith(
            clasifications: () => list,
            status: () => ClasificationsStatus.success),
      );
    } on AomProjectsRepositoryException catch (error) {
      // TODO
    }
  }
}
