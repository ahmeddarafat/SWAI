class MedicineModel {
  final String image;
  final String name;
  final String type;
  final String generalUsage;
  final String composition;
  final String usageInstructions;
  final int number;
  final double price;

  MedicineModel({
    required this.image,
    required this.name,
    required this.type,
    required this.generalUsage,
    required this.composition,
    required this.usageInstructions,
    required this.number,
    required this.price,
  });
}
