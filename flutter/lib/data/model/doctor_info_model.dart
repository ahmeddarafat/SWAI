
class DoctorInfoModel {
  final int id;
  final String image;
  final String name;
  final int reviews;
  final double rate;
  final int experience;
  final String specialty;
  String? specialtyImage;
  final int patients;
  final String description;
  final List<String> availableTime;

  DoctorInfoModel({
    required this.id,
    required this.image,
    required this.name,
    required this.reviews,
    required this.rate,
    required this.experience,
    required this.specialty,
    this.specialtyImage,
    required this.patients,
    required this.description,
    required this.availableTime,
  });

  factory DoctorInfoModel.fromJson(Map<String, dynamic> json) {
    return DoctorInfoModel(
      id: json["id"],
      image: json["image"],
      name: json["name"],
      reviews: json["reviews"],
      rate: json["rate"],
      experience: json["experience"],
      specialty: json["specialty"],
      patients: json["patients"],
      description: json["description"],
      availableTime: json['availableTime'].cast<String>(),
    );
  }
  @override
  String toString() => "DoctorInfoModel(id: $id)";
}
