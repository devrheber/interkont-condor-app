part of 'aom_category_detail_bloc.dart';

abstract class AomCategoryDetailEvent extends Equatable {
  const AomCategoryDetailEvent();

  @override
  List<Object> get props => [];
}

class LoadDataEvent extends AomCategoryDetailEvent {
  const LoadDataEvent(this.projectCode, this.categoryId);

  final int projectCode;
  final int categoryId;
}

class UpdateEstadoDeActivoEvent extends AomCategoryDetailEvent {
  const UpdateEstadoDeActivoEvent(
    this.activoId,
    this.estado,
  );
  final int activoId;
  final EstadoDeActivo? estado;
}
