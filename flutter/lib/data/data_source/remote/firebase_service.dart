import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/data/model/requests_model.dart';

import '../../error_handler/error_handler.dart';

abstract class FirebaseService {
  Future<UserCredential?> login(LoginRequest request);
  Future<UserCredential?> register(RegisterRequest request);
  Future<void> addUserInfo({
    required String id,
    required RegisterRequest request,
  });

  Future<List<String>> getUserInfo({required String id});
  Future<bool> isEmailUsed(String email);
  Future<void> resetPassword();

  Stream<QuerySnapshot<Map<String, dynamic>>> 
  getMessages(
      String conversationID);

  // Future<void> addMessage(String text);
}

class FirebaseServiceImpl implements FirebaseService {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;
  FirebaseServiceImpl(
      {required FirebaseAuth auth, required FirebaseFirestore db})
      : _auth = auth,
        _db = db;

  @override
  Future<UserCredential?> login(LoginRequest request) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        throw CustomException('The Email or Password is not correct');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException('The account already exists for that email.');
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<UserCredential?> register(RegisterRequest request) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: request.email,
        password: request.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CustomException('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        CustomException('The account already exists for that email.');
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  @override
  Future<void> addUserInfo(
      {required String id, required RegisterRequest request}) async {
    log(id);
    await _db.collection("user-info").doc(id).set({
      "name": request.name,
      "phone": request.phone,
    });
  }

  @override
  Future<List<String>> getUserInfo({required String id}) async {
    final userInfo = await _db.collection("user-info").doc(id).get();
    if (userInfo.data() != null) {
      return [
        userInfo.data()!['name'],
        userInfo.data()!['phone'],
      ];
    }
    return ["Unknown", "Unknown"];
  }

  // To know if the email in firebase auth to reset password
  @override
  Future<bool> isEmailUsed(String email) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: "0",
      );
      throw CustomException("Email dose not exist");
    } on FirebaseAuthException catch (e) {
      log(e.code);
      if (e.code == "wrong-password") {
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> resetPassword() async {
    // try{
    //   await _auth.
    // }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String conversationID) {
        log("firebase: get message");
        log("conversationId is : $conversationID");
    return _db
        .collection('conversations')
        .doc(conversationID)
        .collection("messages")
        .orderBy("timestamp")
        .snapshots();
  }

  Future<String> getConversationID(String userID1, String userID2) async {
    String conversationID = '';
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('conversations')
          .where('participants', arrayContainsAny: [userID1, userID2]).get();

      if (querySnapshot.docs.isNotEmpty) {
        conversationID = querySnapshot.docs.first.id;
      }
    } catch (e) {
      // TODO: Handle any potential errors here
      print('Error getting conversation ID: $e');
    }

    return conversationID;
  }

  // @override
  // Future<void> addMessage(String text) async {
  //   await _db.collection("chat").doc(documentPath).collection("messages").add({
  //     "text": text,
  //     "sendingTime": DateTime.now(),
  //     "isUserSender": true,
  //   });
  // }
}
