import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_solution2/presentation/widgets/global/public_snack_bar.dart';
import 'package:google_solution2/resources/constants/app_assets.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../logic/auth/auth_cubit.dart';
import '../../../../resources/constants/app_strings.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/global/public_button.dart';
import '../../../widgets/global/public_text.dart';
import '../../../widgets/global/public_text_form_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return (current is ForgotPasswordState || current is AuthnErrorState);
      },
      listener: (context, state) {
        if (state is ForgotPasswordLoadingState) {
          cubit.changeSnipper();
        } else {
          if (cubit.spinner) {
            cubit.changeSnipper();
          }
          if (state is AuthnErrorState) {
            MySnackBar.error(
                message: state.error, color: Colors.red, context: context);
          } else if (state is ForgotPasswordSuccessState) {
            Navigator.pushNamed(
              context,
              AppRoutes.verifyCode,
              arguments: cubit.email,
            );
          }
        }
      },
      builder: (context, state) {
        if (state is! ForgotPasswordSuccessState) {
          return ModalProgressHUD(
            inAsyncCall: cubit.spinner,
            child: const _ForgotPasswordPageContent(),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _ForgotPasswordPageContent extends StatefulWidget {
  const _ForgotPasswordPageContent();

  @override
  State<_ForgotPasswordPageContent> createState() =>
      _ForgotPasswordPageContentState();
}

class _ForgotPasswordPageContentState
    extends State<_ForgotPasswordPageContent> {
  late final TextEditingController _emailController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: PublicText(
          txt: AppStrings.forgotPassword,
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
                  AppImages.forgotPassword,
                  height: 250.h,
                  width: double.infinity,
                ),
                PublicText(
                  txt: AppStrings.forgotPasswordContent,
                  color: AppColors.darkBlue,
                  size: 17.sp,
                  align: TextAlign.center,
                ),
                50.ph,
                PublicTextFormField(
                  hint: AppStrings.emailAddress,
                  showprefixIcon: true,
                  prefixIcon: Icons.email,
                  controller: _emailController,
                  keyboardtype: TextInputType.emailAddress,
                  validator: (String? email) {
                    return email!.isEmailValid()
                        ? null
                        : AppStrings.invalidEmail;
                  },
                ),
                100.ph,
                PublicButton(
                  title: AppStrings.send,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // To dismiss keyboard
                      FocusScope.of(context).unfocus();
                      cubit.forgotPassword(_emailController.text);
                    }
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
