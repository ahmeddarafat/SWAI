import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_solution2/presentation/widgets/public_snack_bar.dart';
import 'package:google_solution2/resources/constants/app_assets.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../logic/auth/auth_cubit.dart';
import '../../../../resources/constants/app_strings.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/public_button.dart';
import '../../../widgets/public_text.dart';

class VerifyCodePage extends StatelessWidget {
  final String email;
  const VerifyCodePage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return (current is VerifyEmailState || current is AuthnErrorState);
      },
      listener: (context, state) {
        if (state is VerifyEmailLoadingState) {
          cubit.changeSnipper();
        } else {
          if (cubit.spinner) {
            cubit.changeSnipper();
          }
          if (state is AuthnErrorState) {
            MySnackBar.error(
                message: state.error, color: Colors.red, context: context);
          } else if (state is VerifyEmailSuccessState) {
            Navigator.pushReplacementNamed(context, AppRoutes.resetPassword);
          }
        }
      },
      builder: (context, state) {
        if (state is! VerifyEmailSuccessState) {
          return ModalProgressHUD(
            inAsyncCall: cubit.spinner,
            child: _VerifyCodePageContent(
              email: email,
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _VerifyCodePageContent extends StatefulWidget {
  final String email;

  const _VerifyCodePageContent({required this.email});

  @override
  State<_VerifyCodePageContent> createState() => _VerifyCodePageContentState();
}

class _VerifyCodePageContentState extends State<_VerifyCodePageContent> {
  final _formKey = GlobalKey<FormState>();
  String code = "";

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: PublicText(
          txt: AppStrings.verifyCode,
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
        padding: EdgeInsets.all(30.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SvgPicture.asset(
                  AppImages.otp,
                  height: 240.h,
                  width: double.infinity,
                ),
                20.ph,
                PublicText(
                  txt: "${AppStrings.verifyCodeContent} ${widget.email}",
                  color: AppColors.darkBlue,
                  size: 17.sp,
                  align: TextAlign.center,
                ),
                50.ph,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OtpTextField(
                      numberOfFields: 4,
                      textStyle: const TextStyle(color: AppColors.darkBlue),
                      focusedBorderColor: AppColors.lightBlue,
                      showFieldAsBox: true,
                      fieldWidth: 52.w,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.darkBlue,
                          ),
                        ),
                        fillColor: AppColors.lightBlue,
                        filled: true,
                      ),
                      onSubmit: (value) {
                        code = value;
                      },
                    ),
                  ],
                ),
                90.ph,
                PublicButton(
                  title: AppStrings.send,
                  onPressed: () {
                    cubit.verifyEmail(code);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
