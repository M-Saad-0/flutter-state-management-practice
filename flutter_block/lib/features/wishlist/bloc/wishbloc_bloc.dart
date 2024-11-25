import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_block/data/wishlist_items.dart';
import 'package:flutter_block/features/home/models/home_product_data_model.dart';

part 'wishbloc_event.dart';
part 'wishbloc_state.dart';

class WishblocBloc extends Bloc<WishblocEvent, WishblocState> {
  WishblocBloc() : super(WishblocInitial()) {
    on<WishlistRemoveFromWishlist>(wishlistRemoveFromWishlist);
    on<WishlistInitialEvent>((event, emit) {
      emit(WishlistLoadSuccess(wishlistItems: WishlistItems.wishlistItems));
    });
  }

  FutureOr<void> wishlistRemoveFromWishlist(WishlistRemoveFromWishlist event, Emitter<WishblocState> emit) {
    WishlistItems.wishlistItems.remove(event.model);
    emit(WishlistLoadSuccess(wishlistItems: WishlistItems.wishlistItems));
  }
}
