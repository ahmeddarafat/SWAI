import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_solution2/presentation/widgets/public_snack_bar.dart';
import 'package:google_solution2/resources/constants/app_assets.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../logic/auth/auth_cubit.dart';
import '../../../resources/constants/app_strings.dart';
import '../../../resources/styles/app_colors.dart';
import '../../widgets/public_button.dart';
import '../../widgets/public_text.dart';
import '../../widgets/public_text_form_field.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthnLoadingState) {
          cubit.changeSnipper();
        } else {
          if (cubit.spinner) {
            cubit.changeSnipper();
          }
          if (state is AuthnErrorState) {
            MySnackBar.error(
                message: state.error, color: Colors.red, context: context);
          } else if (state is AuthnSuccessState) {
            Navigator.pushReplacementNamed(context, AppRoutes.confirmPassword);
          }
        }
      },
      builder: (context, state) {
        if (state is! AuthnSuccessState) {
          return ModalProgressHUD(
            inAsyncCall: cubit.spinner,
            child: const _ResetPasswordPageContent(),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _ResetPasswordPageContent extends StatefulWidget {
  const _ResetPasswordPageContent();

  @override
  State<_ResetPasswordPageContent> createState() =>
      _ResetPasswordPageContentState();
}

class _ResetPasswordPageContentState extends State<_ResetPasswordPageContent> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPassController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _confirmPassController = TextEditingController();
  }

  @override
  void dispose() {
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: PublicText(
          txt: AppStrings.createNewPassword,
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
                  AppImages.resetPassword,
                  height: 250.h,
                  width: double.infinity,
                ),
                PublicText(
                  txt: AppStrings.resetPasswordContent,
                  color: AppColors.darkBlue,
                  size: 17.sp,
                  align: TextAlign.center,
                ),
                50.ph,
                PublicTextFormField(
                  hint: AppStrings.password,
                  showprefixIcon: true,
                  prefixIcon: Icons.password,
                  showSuffixIcon: true,
                  isPassword: true,
                  controller: _passwordController,
                  keyboardtype: TextInputType.visiblePassword,
                  validator: (String? value) {
                    return value!.isPassValid()
                        ? null
                        : AppStrings.passwordIsShort;
                  },
                ),
                SizedBox(height: 15.h),
                PublicTextFormField(
                  hint: AppStrings.confirmPass,
                  showprefixIcon: true,
                  prefixIcon: Icons.password,
                  showSuffixIcon: true,
                  isPassword: true,
                  controller: _confirmPassController,
                  keyboardtype: TextInputType.visiblePassword,
                  validator: (String? value) {
                    return value == _passwordController.text
                        ? null
                        : AppStrings.notMatchPassword;
                  },
                ),
                50.ph,
                PublicButton(
                  title: AppStrings.send,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // To dismiss keyboard
                      FocusScope.of(context).unfocus();
                      // TODO: "data" - request to change pass
                      // demo code
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.confirmPassword,
                        (_) => false,
                      );
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
