part of 'wishbloc_bloc.dart';

sealed class WishblocState extends Equatable {
  const WishblocState();
  
  @override
  List<Object> get props => [];
}

abstract class WishblocActionState extends WishblocState{}
final class WishblocInitial extends WishblocState {}

final class WishlistLoadSuccess extends WishblocState {
  final List<HomeProductDataModel> wishlistItems;
  const WishlistLoadSuccess({required this.wishlistItems});
}

