part of 'aom_category_detail_cubit.dart';

class AomCategoryDetailState extends Equatable {
  const AomCategoryDetailState({
    this.step = 1,
  });

  final int step;

  @override
  List<Object> get props => [step];
}
