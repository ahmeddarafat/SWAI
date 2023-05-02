part of 'rate_cubit.dart';

abstract class RateState extends Equatable {
  const RateState();

  @override
  List<Object> get props => [];
}

class RateInitial extends RateState {}

class RateChangeDate extends RateState {
  final DateTime date;
  const RateChangeDate(this.date);

  @override
  List<Object> get props => [date];
}
