class MedicineModel {
  final String image;
  final String name;
  final String type;
  final String generalUsage;
  final String composition;
  final String usageInstructions;
  final int noType;
  final double price;

  MedicineModel({
    required this.image,
    required this.name,
    required this.type,
    required this.generalUsage,
    required this.composition,
    required this.usageInstructions,
    required this.noType,
    required this.price,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      image: json["image"],
      name: json["name"],
      type: json["type"],
      generalUsage: json["generalUsage"],
      composition: json["composition"],
      usageInstructions: json["usageInstructions"],
      noType: json["noType"],
      price: double.parse(json["price"]),
    );
  }
}
