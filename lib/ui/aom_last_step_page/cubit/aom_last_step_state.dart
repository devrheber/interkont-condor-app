part of 'aom_last_step_cubit.dart';

abstract class AomLastStepState extends Equatable {
  const AomLastStepState();

  @override
  List<Object> get props => [];
}

class AomLastStepInitial extends AomLastStepState {
  const AomLastStepInitial();
}

class AomLastStepLoading extends AomLastStepState {}

class AomLastStepFailure extends AomLastStepState {
  const AomLastStepFailure(this.errorMessage);

  final String errorMessage;
}

class AomLastStepSuccess extends AomLastStepState {
  const AomLastStepSuccess(this.message);

  final String message;
}
