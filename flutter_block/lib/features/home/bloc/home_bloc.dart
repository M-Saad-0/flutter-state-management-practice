import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block/data/cart_items.dart';
import 'package:flutter_block/data/grocery_data.dart';
import 'package:flutter_block/data/wishlist_items.dart';
import 'package:flutter_block/features/home/models/home_product_data_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
    on<HomeProductWishlistButtonClickedEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeWishlistButtonNavigateClickedEvent>(
        homeWishlistButtonNavigateClickedEvent);
    on<HomeCartButtonNavigateClickedEvent>(homeCartButtonNavigateClickedEvent);
    on<HomeInitialEvent>(homeInitialEvent);
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
        CartItems.cartItems.add(event.clickedProduct);
        emit(HomeProductCartedActionState());
      }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtonClickedEvent event, Emitter<HomeState> emit) {
        WishlistItems.wishlistItems.add(event.clickedProduct);
        emit(HomeProductWishlistedActionState());
      }

  FutureOr<void> homeCartButtonNavigateClickedEvent(
      HomeCartButtonNavigateClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartActionPage());
  }

  FutureOr<void> homeWishlistButtonNavigateClickedEvent(
      HomeWishlistButtonNavigateClickedEvent event, Emitter<HomeState> emit) {
    emit(HomeNavigateToWishlistActionPage());
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadedState());
    try {
      await Future.delayed(
          const Duration(seconds: 3),
          () => emit(HomeLoadedSuccessState(
              products: GroceryData.groceryProducts
                  .map((e) => HomeProductDataModel(
                      id: e['id'],
                      name: e['name'],
                      description: e['description'],
                      price: e['price'],
                      imageUrl: e['imageUrl']))
                  .toList())));
    } catch (e) {
      emit(HomeErrorState());
    }
  }
}
