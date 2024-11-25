part of 'wishbloc_bloc.dart';

sealed class WishblocEvent extends Equatable {
  const WishblocEvent();

  @override
  List<Object> get props => [];
}

class WishlistInitialEvent extends WishblocEvent{}
class WishlistRemoveFromWishlist extends WishblocEvent{
  final HomeProductDataModel model;
  const WishlistRemoveFromWishlist({required this.model});
}