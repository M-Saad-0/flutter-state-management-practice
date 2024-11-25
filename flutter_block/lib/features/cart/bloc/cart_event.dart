
part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class CartInitialEvent extends CartEvent{}
class CartRemoveFromCartEvent extends CartEvent{
  final HomeProductDataModel model;
const  CartRemoveFromCartEvent({required this.model});
}