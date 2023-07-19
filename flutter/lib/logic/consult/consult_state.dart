part of 'consult_cubit.dart';

@immutable
abstract class ConsultState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ConsultInitial extends ConsultState {}

class ConsultLoadingState extends ConsultState {}

class ConsultErrorState extends ConsultState {}

class ConsultSuccessState extends ConsultState {
  final int number;
  ConsultSuccessState(this.number);

  @override
  List<Object?> get props => [number];
}

class ConsultFilterState extends ConsultState {
  final String label;

  ConsultFilterState(this.label);

  @override
  List<Object?> get props => [label];
}

class ConsultScrollingState extends ConsultState {
  final bool isFixed;
  ConsultScrollingState(this.isFixed);

  @override
  List<Object?> get props => [isFixed];
}
