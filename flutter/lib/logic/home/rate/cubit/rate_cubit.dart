import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rate_state.dart';

class RateCubit extends Cubit<RateState> {
  RateCubit() : super(RateInitial());
  static RateCubit get(BuildContext context) => BlocProvider.of<RateCubit>(context);

  DateTime selectedDate = DateTime.now();
  void changeDate(DateTime date) {
    selectedDate = date;
    emit(RateChangeDate(date));
  }
}
