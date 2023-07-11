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

  // /// Login
  // void login(LoginRequest request) {
  //   try {
  //     _repo.login(request);
  //     emit(AuthnLoadingState());
  //   } catch (e) {
  //     if (e is CustomException) {
  //       emit(AuthnErrorState(e.message));
  //     }
  //   }
  // }
}
