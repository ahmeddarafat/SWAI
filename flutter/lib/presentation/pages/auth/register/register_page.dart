import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/model/requests_model.dart';
import 'package:google_solution2/presentation/widgets/global/public_button.dart';
import 'package:google_solution2/presentation/widgets/global/public_text.dart';
import 'package:google_solution2/presentation/widgets/global/public_text_form_field.dart';
import 'package:google_solution2/resources/constants/app_assets.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

import 'package:google_solution2/logic/auth/auth_cubit.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';
import '../../../../resources/constants/app_strings.dart';
import '../../../widgets/global/public_divider.dart';
import '../../../widgets/global/public_snack_bar.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return BlocConsumer<AuthCubit, AuthState>(
      listenWhen: (previous, current) {
        return (current is RegisterState || current is AuthnErrorState);
      },
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          cubit.changeSnipper();
        } else {
          if (cubit.spinner) {
            cubit.changeSnipper();
          }
          if (state is AuthnErrorState) {
            MySnackBar.error(
                message: state.error, color: Colors.red, context: context);
          } else if (state is RegisterSuccessState) {
            Navigator.pushReplacementNamed(context, AppRoutes.layouts);
          }
        }
      },
      builder: (context, state) {
        if (state is! RegisterSuccessState) {
          return ModalProgressHUD(
            inAsyncCall: cubit.spinner,
            child: const _RegisterPageContent(),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _RegisterPageContent extends StatefulWidget {
  const _RegisterPageContent();

  @override
  State<_RegisterPageContent> createState() => _RegisterPageContentState();
}

class _RegisterPageContentState extends State<_RegisterPageContent> {
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPassController;
  late final TextEditingController _phoneController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPassController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = AuthCubit.get(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.darkBlue,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    PublicText(
                      txt: AppStrings.hey,
                      color: AppColors.darkBlue,
                      size: 40.sp,
                    ),
                    20.ph,
                    PublicText(
                      txt: AppStrings.createAccount,
                      color: AppColors.grey,
                      size: 16.sp,
                    ),
                    SizedBox(height: 15.h),
                    PublicTextFormField(
                      hint: AppStrings.userNambe,
                      showprefixIcon: true,
                      prefixIcon: Icons.person,
                      controller: _nameController,
                      keyboardtype: TextInputType.text,
                      validator: (String? name) {
                        return name!.length >= 3
                            ? null
                            : AppStrings.invalidUserName;
                      },
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
                    SizedBox(height: 15.h),
                    PublicTextFormField(
                      hint: AppStrings.phone,
                      showprefixIcon: true,
                      prefixIcon: Icons.phone,
                      controller: _phoneController,
                      keyboardtype: TextInputType.phone,
                      validator: (String? phone) {
                        return phone!.length > 10
                            ? null
                            : AppStrings.invalidPhone;
                      },
                    ),
                    SizedBox(height: 35.h),

                    /// The register button
                    PublicButton(
                      title: AppStrings.signUp,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          var request = RegisterRequest(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _confirmPassController.text,
                            phone: _phoneController.text,
                          );
                          // To dismiss keyboard
                          FocusScope.of(context).unfocus();
                          cubit.register(request);
                        }
                      },
                    ),
                    15.ph,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        PublicText(
                          txt: AppStrings.alreadyHaveAccount,
                          color: AppColors.darkBlue,
                          size: 16.sp,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: PublicText(
                            txt: AppStrings.login,
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
