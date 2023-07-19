part of 'store_cubit.dart';

@immutable
abstract class StoreState extends Equatable {

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

class StoretLoadingState extends StoreState {}

class StoretErrorState extends StoreState {}

class StoretSuccessState extends StoreState {
  final int number;
  StoretSuccessState(this.number);

  @override
  List<Object?> get props => [number];
}

class StoretFilterState extends StoreState {
  final String label;

  StoretFilterState(this.label);

  @override
  List<Object?> get props => [label];
}
