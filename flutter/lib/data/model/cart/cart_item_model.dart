

import 'package:google_solution2/data/model/store/medicine_model.dart';

class CartItem {
  int count;
  final MedicineModel medicine;

  CartItem({
    required this.count,
    required this.medicine,
  });

  CartItem copyWith({
    int? count,
    MedicineModel? medicine,
  }) {
    return CartItem(
      count: count ?? this.count,
      medicine: medicine ?? this.medicine,
    );
  }

  @override
  String toString() =>
      'CartItem(count: $count, medicine: ${medicine.toString()})';
}
