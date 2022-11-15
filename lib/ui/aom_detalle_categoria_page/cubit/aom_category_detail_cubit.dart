import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'aom_category_detail_state.dart';

class AomCategoryDetailCubit extends Cubit<AomCategoryDetailState> {
  AomCategoryDetailCubit() : super(AomCategoryDetailState());

  void setStep(int step) =>
      emit(AomCategoryDetailState(step: step));
}
