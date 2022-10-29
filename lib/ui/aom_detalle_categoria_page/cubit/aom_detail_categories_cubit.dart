import 'package:appalimentacion/domain/models/models.dart';
import 'package:appalimentacion/domain/repository/aom_projects_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_detail_categories_state.dart';

class AomDetailCategoriesCubit extends Cubit<AomDetailCategoriesState> {
  AomDetailCategoriesCubit({
    required AomProjectsRepository aomProjectsRepository,
  })  : _aomProjectsRepository = aomProjectsRepository,
        super(AomDetailCategoriesInitial());

  final AomProjectsRepository _aomProjectsRepository;

  Future<void> getGestionObra(int projectCode) async {
    emit(state.copyWith(status: () => AomDetailCategoriesStatus.loading));
    try {
      final list = await _aomProjectsRepository.getGestionAom(projectCode);
      emit(state.copyWith(
        gestionAom: () => list,
        status: () => AomDetailCategoriesStatus.success,
      ));
    } on AomProjectsRepositoryException catch (_) {
      // TODO
      emit(state.copyWith(
        status: () => AomDetailCategoriesStatus.failure,
      ));
    }
  }
}
