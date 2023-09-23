import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/data/repository/repository.dart';
import 'package:google_solution2/presentation/pages/chats/chat_preview/chat_preview_page.dart';

import '../../../data/model/message.model.dart';

part 'conversation_state.dart';

class ConversationCubit extends Cubit<ConversationState> {
  final Repository repo;
  ConversationCubit({required this.repo}) : super(ConversationInitial());

  static ConversationCubit getInstance(BuildContext context) =>
      BlocProvider.of(context);

  late TextEditingController messageController;

  void init() {
    // call getConversationID method
    messageController = TextEditingController();
  }

  void dispose() {
    messageController.dispose();
  }

  // add getConversationID methods
  List<MessageLine> messagesList = [];
  Future<void> getMessages(DoctorInfoModel doctor) async {
    emit(ConversationLoadingState());
    var messageStream = await repo.getMessages(doctor);
    messageStream.listen((message) {
      if (message.docs.isEmpty) {
        emit(ConversationEmptyState());
      } else {
        final messageLine = modelMessage(message.docs.first);
        if (messageLine != null) {
          messagesList.add(messageLine);
          emit(ConversationSuccessState(messagesList.length.toString()));
        }
      }
    });
  }

  MessageLine? modelMessage(
      QueryDocumentSnapshot<Map<String, dynamic>>? message) {
    if (message != null) {
      return MessageLine(
        message: MessageLineModel.fromJosn(message.data()),
      );
    }
    return null;
  }
}
