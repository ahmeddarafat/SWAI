import 'package:email_otp/email_otp.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import 'package:google_solution2/data/repository/repository.dart';
import '../../data/error_handler/error_handler.dart';
import '../../data/model/requests_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Repository _repo;
  AuthCubit({
    required Repository repo,
  })  : _repo = repo,
        super(AuthInitial());

  static AuthCubit get(BuildContext context) => BlocProvider.of(context);

  /// Sinpper
  bool _spinner = false;
  bool get spinner {
    return _spinner;
  }

  void changeSnipper() {
    _spinner = !_spinner;
  }

  /// Auth
  void login(LoginRequest request) async {
    emit(LoginLoadingState());
    try {
      if (await _repo.login(request)) {
        emit(LoginSuccessState());
      }
    } catch (e) {
      if (e is CustomException) {
        emit(AuthnErrorState(e.message));
      }
    }
  }

  void register(RegisterRequest request) async {
    emit(RegisterLoadingState());
    try {
      if (await _repo.register(request)) {
        emit(RegisterSuccessState());
      }
    } catch (e) {
      if (e is CustomException) {
        emit(AuthnErrorState(e.message));
      }
    }
  }

  EmailOTP myauth = EmailOTP();
  String email = '';
  Future<void> forgotPassword(String email) async {
    emit(ForgotPasswordLoadingState());
    try {
      if (await _repo.forgotPassword(email)) {
        myauth.setConfig(
          appEmail: "ahmed.arafat@gmail.com",
          appName: "Health Care",
          userEmail: email,
          otpLength: 4,
          otpType: OTPType.digitsOnly,
        );
        myauth.sendOTP();
        this.email = email;
        emit(ForgotPasswordSuccessState());
      }
    } catch (e) {
      if (e is CustomException) {
        emit(AuthnErrorState(e.message));
      }
    }
  }

  Future<void> verifyEmail(String otp) async {
    emit(VerifyEmailLoadingState());
    if (await myauth.verifyOTP(otp: otp)) {
      emit(VerifyEmailSuccessState());
    } else {
      emit(AuthnErrorState("Wrong Code, Send Again"));
    }
  }
}
