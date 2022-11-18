part of 'aom_report_step_2_bloc.dart';

abstract class AomReportStep2Event extends Equatable {
  const AomReportStep2Event();

  @override
  List<Object> get props => [];
}

class UpdateAnwserEvent extends AomReportStep2Event {
  const UpdateAnwserEvent(this.index, {required this.answer});
  final int index;
  final bool answer;
}

class UpdateQuestion1ReasonEvent extends AomReportStep2Event {
  const UpdateQuestion1ReasonEvent(this.reason);

  final String reason;
}

class UpdateQuestion1MonthsEvent extends AomReportStep2Event {
  const UpdateQuestion1MonthsEvent(this.months);

  final String months;
}
