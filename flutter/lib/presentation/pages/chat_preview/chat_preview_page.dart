import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/presentation/widgets/public_text_form_field.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';

import '../../../data/model/doctor_info_model.dart';
import '../../../resources/styles/app_colors.dart';
import '../../widgets/public_text.dart';

class ChatPreviewPage extends StatefulWidget {
  final DoctorInfoModel doctor;
  const ChatPreviewPage({super.key,required this.doctor});

  @override
  State<ChatPreviewPage> createState() => _ChatPreviewPageState();
}

class _ChatPreviewPageState extends State<ChatPreviewPage> {
  late final TextEditingController _messageController;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                child: ListView(
                  reverse: true,
                  children: const [
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                    MessageLine(isMe: false, text: "I'm good, what about you"),
                    MessageLine(isMe: true, text: "Hi, How are you doing?!"),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: SizedBox(
                      height: 45.h,
                      child: PublicTextFormField(
                        hint: "Message",
                        controller: _messageController,
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
                          // TODO: "logic,data" - sending message
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

class MessageLine extends StatelessWidget {
  final String? text;
  final bool isMe;

  const MessageLine({
    Key? key,
    required this.isMe,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          4.ph,
          Container(
            decoration: BoxDecoration(
              color: isMe ? AppColors.darkBlue : Colors.white,
              borderRadius: isMe
                  ? const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      topLeft: Radius.circular(12),
                    )
                  : const BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
              border: Border.all(
                color: AppColors.darkBlue,
                width: 0.4,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              child: Text(
                '$text',
                style: TextStyle(
                    color: isMe ? Colors.white : AppColors.darkBlue, fontSize: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
