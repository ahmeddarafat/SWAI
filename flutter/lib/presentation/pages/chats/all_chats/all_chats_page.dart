import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/logic/consult/consult_cubit.dart';
import 'package:google_solution2/resources/extensions/extensions.dart';
import 'package:google_solution2/resources/router/app_router.dart';

import '../../../../resources/constants/app_strings.dart';
import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/global/public_text.dart';
import '../../../widgets/global/public_text_form_field.dart';
import '../../consult/find_doctor/components/doctor_list_tile.dart';

class AllChatsPage extends StatefulWidget {
  const AllChatsPage({super.key});

  @override
  State<AllChatsPage> createState() => _AllChatsPageState();
}

class _AllChatsPageState extends State<AllChatsPage> {
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
    var cubit = ConsultCubit.get(context);
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
              PublicTextFormField(
                showprefixIcon: true,
                prefixIcon: Icons.search,
                hint: "Search",
                controller: _searchController,
                validator: null,
                borderRadius: 12,
                onChanged: (value) {
                  cubit.filterDoctorBySearch(value);
                },
              ),
              15.ph,
              Expanded(
                child: BlocBuilder<ConsultCubit, ConsultState>(
                  builder: (context, state) {
                    return ListView.separated(
                      itemCount: cubit.doctorsViewed.length,
                      itemBuilder: (_, index) => InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.chatPreview,arguments: cubit.doctorsViewed[index]),
                        child:
                            DoctorListTile(doctor: cubit.doctorsViewed[index]),
                      ),
                      separatorBuilder: (_, __) => 5.ph,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
