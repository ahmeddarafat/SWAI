import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_solution2/data/dummy_data/dummy_data.dart';

import '../../../../resources/styles/app_colors.dart';
import '../../../widgets/global/public_text.dart';

class FQAPage extends StatefulWidget {
  const FQAPage({super.key});

  @override
  State<FQAPage> createState() => _FQAPageState();
}

class _FQAPageState extends State<FQAPage> {
  late List data;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: PublicText(
          txt: "FQA",
          fw: FontWeight.bold,
          size: 22.sp,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
          color: AppColors.darkBlue,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                DummayData.fqa[panelIndex].isExpanded = isExpanded;
              });
            },
            children: DummayData.fqa.map((element) {
              return ExpansionPanel(
                canTapOnHeader: true,
                isExpanded: element.isExpanded,
                headerBuilder: (_, __) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
                      child: PublicText(
                        txt: element.question,
                        color: AppColors.darkBlue,
                      ),
                    ),
                  );
                },
                body: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
                    child: PublicText(
                      txt: element.answer,
                      max: 20,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
