import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/presentation/widgets/public_button.dart';
import 'package:google_solution2/presentation/widgets/public_divider.dart';
import 'package:google_solution2/presentation/widgets/public_text.dart';
import 'package:google_solution2/presentation/widgets/public_text_form_field.dart';
import 'package:google_solution2/resources/constants/app_assets.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import 'package:google_solution2/logic/auth/auth_cubit.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';
import '../../../resources/constants/app_strings.dart';
import '../../widgets/public_snack_bar.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            // Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          }
        }
      },
      builder: (context, state) {
        if (state is! AuthnSuccessState) {
          return ModalProgressHUD(
            inAsyncCall: cubit.spinner,
            child: const LoginPageContent(),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class LoginPageContent extends StatefulWidget {
  const LoginPageContent({super.key});

  @override
  State<LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    PublicText(
                      txt: AppStrings.welcome,
                      color: AppColors.darkBlue,
                      size: 40.sp,
                    ),
                    20.ph,
                    PublicText(
                      txt: AppStrings.signInToContinue,
                      color: AppColors.grey,
                      size: 16.sp,
                    ),
                    SizedBox(height: 15.h),
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
                    SizedBox(height: 15.h),
                    PublicTextFormField(
                      hint: AppStrings.password,
                      showprefixIcon: true,
                      prefixIcon: Icons.password,
                      showSuffixIcon: true,
                      isPassword: true,
                      validator: (String? value) {
                        return value!.isPassValid()
                            ? null
                            : AppStrings.passwordIsShort;
                      },
                      controller: _passwordController,
                      keyboardtype: TextInputType.visiblePassword,
                    ),
                    10.ph,
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, AppRoutes.forgotPassword);
                        },
                        child: PublicText(
                          txt: AppStrings.doForgotPassword,
                          color: AppColors.lightBlue,
                          size: 16.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 35.h),

                    /// The Login button
                    PublicButton(
                      title: AppStrings.login,
                      backgroundColor: AppColors.lightBlue,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // To dismiss keyboard
                          FocusScope.of(context).unfocus();
                        }
                      },
                    ),
                    15.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        PublicText(
                          txt: AppStrings.dontHaveAccount,
                          color: AppColors.darkBlue,
                          size: 16.sp,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.register);
                          },
                          child: PublicText(
                            txt: AppStrings.signUp,
                            color: AppColors.lightBlue,
                            size: 16.sp,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const PublicDivider(),
                        SizedBox(width: 15.w),
                        PublicText(
                          txt: AppStrings.or,
                          color: AppColors.darkBlue,
                          size: 22.sp,
                        ),
                        SizedBox(width: 15.w),
                        const PublicDivider(),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () async {
                            // if (connectivityCubit.state
                            //     is ConnectivityOnlineState) {
                            //   await _authenticateWithGoogleAccount(
                            //       context, cubit);
                            // } else {
                            //   String message =
                            //       'Please Check Your Internet Connection';
                            //   MySnackBar.error(
                            //       message: message,
                            //       color: Colors.red,
                            //       context: context);
                            // }
                          },
                          child: Image.asset(
                            AppIcons.googleIcon,
                          ),
                        ),
                        SizedBox(width: 100.w),

                        /// facebook icon
                        /// there is an error need to debug
                        InkWell(
                          onTap: () {
                            /// the code is in sign up screen
                          },
                          child: Image.asset(AppIcons.facebookIcon),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
