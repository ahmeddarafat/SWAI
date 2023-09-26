import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_solution2/data/data_source/local/local_data_source.dart';
import 'package:google_solution2/data/model/cart/cart_item_model.dart';
import 'package:google_solution2/data/model/store/medicine_model.dart';
import 'package:google_solution2/resources/di/di.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  static CartCubit get(BuildContext context) => BlocProvider.of(context);

  final db = getIt<LocalDataSource>();
  List<CartItem> medicinesCart = [];

  void addToCart(MedicineModel medicine) {
    medicinesCart.add(
      CartItem(
        count: 1,
        medicine: medicine,
      ),
    );
    db.insertToCart(medicine.id);
    calculateTotalPrice();
    emit(AddToCartState(id: medicine.id));
  }

  void increaseMedicine(int index) {
    int count = medicinesCart[index].count;
    count++;
    db.updateToCart(
      medicineId: medicinesCart[index].medicine.id,
      newCount: count,
    );
    medicinesCart[index] = medicinesCart[index].copyWith(count: count);
    calculateTotalPrice();
    emit(
      ChangeCartItemState(
        id: medicinesCart[index].medicine.id,
        newCount: count,
      ),
    );
  }

  void decreaseMedicine(int index) {
    int count = medicinesCart[index].count;
    if (count > 1) {
      count--;
      db.updateToCart(
        medicineId: medicinesCart[index].medicine.id,
        newCount: count,
      );
      medicinesCart[index] = medicinesCart[index].copyWith(count: count);
      calculateTotalPrice();
      emit(
        ChangeCartItemState(
          id: medicinesCart[index].medicine.id,
          newCount: count,
        ),
      );
    }
  }

  double totalPrice = 0;
  void calculateTotalPrice() {
    totalPrice = 0;
    for (var element in medicinesCart) {
      totalPrice += element.medicine.price * element.count;
    }
  }
}
