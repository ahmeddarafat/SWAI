part of '../chat_preview_page.dart';

class MessageLine extends StatelessWidget {
  final MessageLineModel message;

  const MessageLine({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          4.ph,
          Container(
            decoration: BoxDecoration(
              color: message.isMe ? AppColors.darkBlue : Colors.white,
              borderRadius: message.isMe
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
                message.text,
                style: TextStyle(
                    color: message.isMe ? Colors.white : AppColors.darkBlue,
                    fontSize: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
