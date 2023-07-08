import 'package:google_solution2/data/model/article_model.dart';
import 'package:google_solution2/data/model/doctor_info_model.dart';
import 'package:google_solution2/data/model/drug_model.dart';
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
  ],
);

DrugModel drugModel = DrugModel(
  image: AppImages.ibuprofen,
  name: "Ibuprofen 200mg",
  type: "capsules",
  generalUsage:
      "Make sure you take ibuprofen as directed on the label or leaflet, or as instructed by a health professional.",
  composition:
      "Make sure you take ibuprofen as directed on the label or leaflet, or as instructed by a health professional.",
  usageInstructions:
      "Make sure you take ibuprofen as directed on the label or leaflet, or as instructed by a health professional.",
  number: 16,
  price: 8.99,
);

ArticleModel articleModel = ArticleModel(
  image: AppImages.stethoscope,
  title: "Make sure you take ibu profen as directed on the label or leaflet, or as instructed by a health professional.",
  description: "clinic, an organized medical service offering diagnostic, therapeutic, or preventive outpatient services. Often, the term covers an entire medical teaching centre, including the hospital and the outpatient facilities. The medical care offered by a clinic may or may not be connected with a hospital.The term clinic may be used to designate all the activities of a general clinic or only a particular division of the work— e.g., the psychiatric clinic, neurology clinic, or surgery clinic. The entire activity when connected with a hospital is typically called the outpatient department, and the specific subdivisions may be referred to as clinics.The first clinic in the English-speaking world, the London Dispensary, was founded in 1696 as a central means of dispensing medicines to the sick poor whom the physicians were treating in the patients’ homes. The New York City, Philadelphia, and Boston dispensaries, founded in 1771, 1786, and 1796, respectively, had the same objective. Later, for the sake of convenience, physicians began to treat their free patients at the dispensary. The number of such clinics did not increase rapidly, and as late as 1890 only 132 were operating in the United States. The impetus for the mushroomlike growth that has occurred since that time came with the rapid growth of hospitals and also from the public health movement.",
  author: "Dr. Luka Modric",
  url: "url",
  publishedAt: "May 06, 2023",
);
