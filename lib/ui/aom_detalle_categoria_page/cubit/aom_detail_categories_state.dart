part of 'aom_detail_categories_cubit.dart';

enum AomDetailCategoriesStatus { initial, loading, success, failure }

class AomDetailCategoriesState extends Equatable {
  const AomDetailCategoriesState({
    this.gestionAom,
    this.status = AomDetailCategoriesStatus.initial,
  });

  final List<GestionAom>? gestionAom;
  final AomDetailCategoriesStatus status;

  AomDetailCategoriesState copyWith({
    List<GestionAom>? Function()? gestionAom,
    AomDetailCategoriesStatus Function()? status,
  }) {
    return AomDetailCategoriesState(
      gestionAom: gestionAom != null ? gestionAom() : this.gestionAom,
      status: status != null ? status() : this.status,
    );
  }

  @override
  List<Object> get props => [gestionAom!, status];
}

class AomDetailCategoriesInitial extends AomDetailCategoriesState {}
