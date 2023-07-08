import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';

import '../../../data/dummy_data/dummy_data.dart';
import '../../../resources/constants/app_strings.dart';
import '../../../resources/styles/app_colors.dart';
import '../../widgets/public_text.dart';
import '../../widgets/public_text_form_field.dart';
import '../consult/components/doctor_list_tile.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: PublicText(
            txt: AppStrings.talkWithDoctor,
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
              // TODO : "Logic" - filtering doctors
              PublicTextFormField(
                showprefixIcon: true,
                prefixIcon: Icons.search,
                hint: "Search",
                controller: _searchController,
                validator: null,
                borderRadius: 12,
              ),
              15.ph,
              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  itemBuilder: (_, index) => InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, AppRoutes.chatPreview),
                    child: DoctorListTile(doctor: doctorInfo),
                  ),
                  separatorBuilder: (_, __) => 5.ph,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
