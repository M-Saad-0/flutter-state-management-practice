import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block/data/cart_items.dart';
import 'package:flutter_block/features/home/models/home_product_data_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartSuccessState(cartItems: CartItems.cartItems));
  }

  FutureOr<void> cartRemoveFromCartEvent(CartRemoveFromCartEvent event, Emitter<CartState> emit) {
    
    bool removed  = CartItems.cartItems.remove(event.model);

    print(CartItems.cartItems.length);
    emit(CartSuccessState(cartItems: CartItems.cartItems)); 
  }
}
