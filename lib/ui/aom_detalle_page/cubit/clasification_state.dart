part of 'clasification_cubit.dart';

enum ClasificationsStatus { initial, loading, success, failure }

class ClasificationState extends Equatable {
  const ClasificationState({
    this.status = ClasificationsStatus.initial,
    this.clasifications = const [],
  });

  final ClasificationsStatus status;
  final List<Clasificacion> clasifications;

  ClasificationState copyWith({
    ClasificationsStatus Function()? status,
    List<Clasificacion> Function()? clasifications,
  }) {
    return ClasificationState(
      status: status != null ? status() : this.status,
      clasifications:
          clasifications != null ? clasifications() : this.clasifications,
    );
  }

  @override
  List<Object> get props => [status, clasifications];
}
