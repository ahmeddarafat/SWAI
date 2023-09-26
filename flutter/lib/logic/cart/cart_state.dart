part of 'cart_cubit.dart';

@immutable
class CartState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {}

class AddToCartState extends CartState {
  final int id;

  AddToCartState({required this.id});
  @override
  List<Object?> get props => [id];
}

class ChangeCartItemState extends CartState {
  final int id;
  final int newCount;

  ChangeCartItemState({required this.id, required this.newCount});

  @override
  List<Object?> get props => [id, newCount];
}
