import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_solution2/data/model/measurements_model.dart';
import 'package:google_solution2/data/repository/repo.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  // final Repo _repo;
  DashboardCubit()
      : super(
          GetMeasurementsState(
            MeasurementsModel(
              heartRate: 0,
              temperature: 0,
              oxygenRate: 0,
              glucoseRate: 0,
            ),
          ),
        );

  static DashboardCubit get(BuildContext context) => BlocProvider.of(context);

  MeasurementsModel measurements = MeasurementsModel(
    heartRate: 0,
    temperature: 0,
    oxygenRate: 0,
    glucoseRate: 0,
  );

  Future getMeasurements(Repo repo) async {
    measurements = await repo.getMeasurements();
    log(measurements.toString());
    emit(GetMeasurementsState(measurements));
  }
}
