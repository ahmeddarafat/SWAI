import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';

import '../../model/requests_model.dart';
import 'api_service.dart';
import 'firebase_service.dart';

abstract class RemoteDataSource {
  /// api service
  Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? query,
  });

  /// firebase service

  Future<UserCredential?> login(LoginRequest request);
  Future<UserCredential?> register(RegisterRequest request);
  Future<void> addUserInfo({
    required String id,
    required RegisterRequest request,
  });
  Future<List<String>> getUserInfo({
    required String id,
  });
  Future<bool> isEmailUsed(String email);
  Future<void> resetPassword();

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
    DoctorInfoModel doctor,
  );

  // Future<void> addMessage(String text);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final ApiService _apiService;
  final FirebaseService _firebaseService;

  RemoteDataSourceImpl({
    required ApiService apiService,
    required FirebaseService firebaseService,
  })  : _apiService = apiService,
        _firebaseService = firebaseService;

  @override
  Future<Response> getData(
      {required String endPoint, Map<String, dynamic>? query}) async {
    return await _apiService.getData(endPoint: endPoint, query: query);
  }

  @override
  Future<UserCredential?> login(LoginRequest request) async {
    return await _firebaseService.login(request);
  }

  @override
  Future<UserCredential?> register(RegisterRequest request) async {
    return await _firebaseService.register(request);
  }

  @override
  Future<void> addUserInfo(
      {required String id, required RegisterRequest request}) async {
    await _firebaseService.addUserInfo(id: id, request: request);
  }

  @override
  Future<List<String>> getUserInfo({required String id}) async {
    return _firebaseService.getUserInfo(id: id);
  }

  // To know if the email in firebase auth to reset password
  @override
  Future<bool> isEmailUsed(String email) async {
    return await _firebaseService.isEmailUsed(email);
  }

  @override
  Future<void> resetPassword() async {
    await _firebaseService.resetPassword();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      DoctorInfoModel doctor)  {
        // TODO - Testing: change the conversation id to var
        log("remote: get messages");
    return  _firebaseService.getMessages("2EU5ddedwMX9qlYIHdn3");
  }

  // @override
  // Future<void> addMessage(String text) async {
  //   await _firebaseService.addMessage(text);
  // }
}
