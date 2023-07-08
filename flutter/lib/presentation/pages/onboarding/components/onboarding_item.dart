part of '../onboarding_page.dart';

class OnboardingItem extends StatelessWidget {
  final OnBoardingModel onBoarding;
  const OnboardingItem({
    Key? key,
    required this.onBoarding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SvgPicture.asset(
          onBoarding.img,
          height: 400.h,
          width: double.infinity,
        ),
        PublicText(
          txt: onBoarding.title,
          color: AppColors.darkBlue,
          fw: FontWeight.bold,
          size: 22.sp,
        ),
        10.ph,
        PublicText(
          txt: onBoarding.description,
          color: AppColors.grey,
          size: 18.sp,
          align: TextAlign.center,
        ),
      ],
    );
  }
}
