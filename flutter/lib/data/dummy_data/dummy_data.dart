import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/resources/constants/app_assets.dart';

import '../model/point_model.dart';

List<PointModel> rateDataSource = [
  PointModel(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      0,
    ),
    60,
  ),
  PointModel(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      5,
    ),
    80,
  ),
  PointModel(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      6,
    ),
    65,
  ),
  PointModel(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      7,
    ),
    40,
  ),
  PointModel(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      8,
    ),
    90,
  ),
  PointModel(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      11,
    ),
    78,
  ),
  // HeartRateData('16:00', 80),
  // HeartRateData('17:00', 180),
  PointModel(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      17,
    ),
    100,
  ),
  PointModel(
    DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      23,
    ),
    80,
  ),
];

DoctorInfoModel doctorInfo = DoctorInfoModel(
    image: AppImages.doctor1,
    name: "Dr. Ahmed Arafat",
    reviews: 120,
    rate: 4,
    experience: 7,
    specialty: "Dentist",
    specialtyImage: AppIcons.tooth,
    people: 3000,
    description:
        "A Dentist is a licensed professional who examines, diagnoses, treats, and advises patients on dental issues. They clean teeth, fill cavities, perform extractions and surgeries, and promote oral health.",
    availableTime: [
      "5PM - 9PM",
      "5PM - 9PM",
      "5PM - 9PM",
      "5PM - 9PM",
      "5PM - 9PM",
      "No",
      "No",
    ]);
