import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';

import '../../data/repository/repository.dart';

part 'consult_state.dart';

class ConsultCubit extends Cubit<ConsultState> {
  final Repository _repo;
  ConsultCubit({
    required Repository repo,
  })  : _repo = repo,
        super(ConsultInitial());

  static ConsultCubit get(BuildContext context) => BlocProvider.of(context);

  List<DoctorInfoModel> _doctors = [];
  List<DoctorInfoModel> doctorsViewed = [];

  int _refreshNumber = 0;
  Future<void> getDoctors() async {
    emit(ConsultLoadingState());
    try {
      _doctors = await _repo.getDoctors();
      doctorsViewed = _doctors;
      emit(ConsultSuccessState(_refreshNumber++));
    } catch (e) {
      log(e.toString());
      emit(ConsultErrorState());
    }
  }

  Future<void> getDoctorsRefresh() async {
    try {
      _doctors = await _repo.getDoctors();
      doctorsViewed = _doctors;
      emit(ConsultSuccessState(_refreshNumber++));
    } catch (e) {
      log(e.toString());
    }
  }

  void filterDoctorsByLabel(String label) {
    doctorsViewed = _doctors.where((doctor) {
      return doctor.specialty.toLowerCase() == label.toLowerCase();
    }).toList();
    emit(ConsultFilterState(label));
  }

  void filterDoctorBySearch(String str) {
    doctorsViewed = _doctors.where((doctor) {
      return doctor.name.toLowerCase().contains(str.toLowerCase());
    }).toList();
    emit(ConsultFilterState(str));
  }

  void removeFilter() {
    doctorsViewed = _doctors;
    emit(ConsultFilterState('no filter'));
  }

  // need testing
  ScrollController controller = ScrollController();
  ScrollPhysics physics = const ClampingScrollPhysics();

  void changePysics() {
    controller.addListener(() {
      if (controller.position.pixels <= 56) {
        physics = const ClampingScrollPhysics();
        emit(ConsultScrollingState(true));
      } else {
        physics = const BouncingScrollPhysics();
        emit(ConsultScrollingState(false));
      }
    });
  }

  void dipose() {
    controller.dispose();
  }
}
