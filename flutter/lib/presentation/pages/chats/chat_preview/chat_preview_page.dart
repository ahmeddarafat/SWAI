import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/message.model.dart';
import 'package:google_solution2/logic/chat/conversation/conversation_cubit.dart';
import 'package:google_solution2/presentation/widgets/global/public_text_form_field.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../../data/model/doctor_info_model.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/global/public_text.dart';

part 'components/message_line.dart';

class ChatPreviewPage extends StatefulWidget {
  final DoctorInfoModel doctor;
  const ChatPreviewPage({super.key, required this.doctor});

  @override
  State<ChatPreviewPage> createState() => _ChatPreviewPageState();
}

class _ChatPreviewPageState extends State<ChatPreviewPage> {
  late final ConversationCubit cubit;

  void bind() {
    cubit = ConversationCubit.getInstance(context);
    cubit.init();
    cubit.getMessages(widget.doctor);
  }

  @override
  void initState() {
    super.initState();
    bind();
  }

  @override
  void dispose() {
    cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('rebuilt');
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: PublicText(
            txt: widget.doctor.name,
            color: AppColors.darkBlue,
            fw: FontWeight.bold,
            size: 20.sp,
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.darkBlue,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
          child: Column(
            children: [
              Expanded(
                child: BlocBuilder<ConversationCubit, ConversationState>(
                  builder: (context, state) {
                    if (state is ConversationLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if(state is ConversationEmptyState){
                       return const Center(
                        child: Text("Say Hey"),
                      );
                    }else {
                      return ListView(
                        reverse: true,
                        children: cubit.messagesList.reversed.toList(),
                      );
                    }
                  },
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 45.h,
                      child: PublicTextFormField(
                        hint: "Message",
                        controller: cubit.messageController,
                        validator: null,
                        borderRadius: 12,
                      ),
                    ),
                  ),
                  10.pw,
                  SizedBox(
                    width: 45.h,
                    height: 45.h,
                    child: FittedBox(
                      child: FloatingActionButton(
                        backgroundColor: AppColors.darkBlue,
                        onPressed: () {
                          // _logic.sendMessage(
                          //   _messageController.text,
                          // );
                          // _messageController.clear();
                        },
                        child: const Icon(Icons.send),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/// Draft
  // FutureBuilder(
  //   future: _logic.getMessages(widget.doctor),
  //   builder: (_, snapshot) {
  //     if (snapshot.connectionState == ConnectionState.waiting) {
  //       return const Center(
  //         child: CircularProgressIndicator(),
  //       );
  //     } else {
  //       return StreamBuilder(
  //         stream: snapshot.data,
  //         builder: (_, snapshot) {
  //           if (snapshot.data!.docs.isEmpty) {
  //             return const Center(
  //               child: PublicText(txt: "Say Hi"),
  //             );
  //           } else {
  //             var messages = snapshot.data;
  //             _logic.modelMessages(messages);
  //             return ListView(
  //               reverse: true,
  //               children: _logic.messagesList.reversed.toList(),
  //             );
  //           }
  //         },
  //       );
  //     }
  //   },
  // )
