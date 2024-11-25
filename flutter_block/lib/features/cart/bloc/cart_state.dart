part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

abstract class CartActionState extends CartState{}

final class CartInitial extends CartState {}
final class CartSuccessState extends CartState {
  final List<HomeProductDataModel> cartItems;
  const CartSuccessState({required this.cartItems});
   @override
  List<Object> get props => [cartItems];
}
