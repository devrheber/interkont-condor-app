import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_category_detail_state.dart';

class AomReportCubit extends Cubit<AomReportState> {
  AomReportCubit() : super(AomReportState());

  void setStep(int step) =>
      emit(AomReportState(step: step));
}
