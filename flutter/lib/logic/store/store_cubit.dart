import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_solution2/data/model/store/medicine_model.dart';

import '../../data/repository/repository.dart';

part 'store_state.dart';

class StoreCubit extends Cubit<StoreState> {
  final Repository _repo;
  StoreCubit({
    required Repository repo,
  })  : _repo = repo,
        super(StoreInitial());

  static StoreCubit get(BuildContext context) => BlocProvider.of(context);

  List<MedicineModel> medicines = [];
  List<MedicineModel> medicinesViewed = [];

  int _refreshNumber = 0;
  Future<void> getMedicines() async {
    emit(StoretLoadingState());
    try {
      medicines = await _repo.getMedicines();
      medicinesViewed = medicines;
      emit(StoretSuccessState(_refreshNumber++));
    } catch (e) {
      log(e.toString());
      emit(StoretErrorState());
    }
  }

  Future<void> getMedicinesRefresh() async {
    try {
      medicines = await _repo.getMedicines();
      medicinesViewed = medicines;
      emit(StoretSuccessState(_refreshNumber++));
    } catch (e) {
      log(e.toString());
    }
  }

  void filterBySearch(String str) {
    medicinesViewed = medicines.where((medicine) {
      return medicine.name.toLowerCase().contains(str.toLowerCase());
    }).toList();
    emit(StoretFilterState(str));
  }
}
