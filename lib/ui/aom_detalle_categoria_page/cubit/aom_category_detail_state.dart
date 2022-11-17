part of 'aom_category_detail_cubit.dart';

class AomReportState extends Equatable {
  const AomReportState({
    this.step = 1,
  });

  final int step;

  @override
  List<Object> get props => [step];
}
