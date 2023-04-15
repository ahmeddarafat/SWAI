part of 'dashboard_cubit.dart';

@immutable
abstract class DashboardState extends Equatable{
  @override
  List<Object?> get props => [];
}

class GetMeasurementsState extends DashboardState {
  final MeasurementsModel measurements;

  GetMeasurementsState(this.measurements);
  @override
  List<Object?> get props => [measurements];
}

