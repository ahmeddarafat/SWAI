import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_solution2/data/model/onboarding_model.dart';
import 'package:google_solution2/presentation/widgets/public_button.dart';
import 'package:google_solution2/presentation/widgets/public_text.dart';
import 'package:google_solution2/resources/constants/app_constants.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';
import 'package:google_solution2/resources/styles/app_colors.dart';

import '../../../logic/onboarding/onboarding_cubit.dart';
import '../../../resources/constants/app_strings.dart';

part 'components/custom_dots.dart';
part 'components/onboarding_item.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    OnboardingCubit cubit = BlocProvider.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// skip button
              Row(
                children: [
                  const Spacer(),
                  PublicButton(
                    width: 80.w,
                    title: AppStrings.skip,
                    backgroundColor: AppColors.darkBlue,
                    onPressed: () {
                      if (cubit.curruntindext <
                          UIConstants.onboardinglist.length - 1) {
                        _pageController.animateToPage(
                          2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        );
                        cubit.changeindex(index: 2);
                      }
                    },
                  ),
                ],
              ),

              /// page view
              Expanded(
                child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: UIConstants.onboardinglist.length,
                  controller: _pageController,
                  itemBuilder: ((context, index) {
                    return OnboardingItem(
                      onBoarding: UIConstants.onboardinglist[index],
                    );
                  }),
                  onPageChanged: (index) {
                    cubit.changeindex(index: index);
                  },
                ),
              ),

              // the buttons of row
              BlocBuilder<OnboardingCubit, OnboardingState>(
                builder: (context, _) {
                  return Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          if (cubit.curruntindext > 0) {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            cubit.removefromindex();
                          }
                        },
                        child: PublicText(
                          txt: AppStrings.back,
                          color: AppColors.darkBlue,
                          fw: FontWeight.bold,
                          size: 16.sp,
                        ),
                      ),
                      80.pw,
                      CustomDots(myindex: cubit.curruntindext),
                      const Spacer(),
                      cubit.curruntindext == 2
                          ? PublicButton(
                              width: 80.w,
                              backgroundColor: AppColors.darkBlue,
                              title: AppStrings.begin,
                              verticalpadding: 14.h,
                              onPressed: () {
                                Navigator.pushReplacementNamed(
                                  context,
                                  AppRoutes.login,
                                );
                                // TODO: "data" - shared prefs, open onboarding just once
                                // SharedPrefs.setBool(key: 'seen', value: true);
                              },
                            )
                          : InkWell(
                              onTap: () {
                                if (cubit.curruntindext <
                                    UIConstants.onboardinglist.length - 1) {
                                  _pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                  cubit.changeindex();
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.darkBlue,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
