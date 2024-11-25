part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class HomeInitialEvent extends HomeEvent{}

class HomeProductWishlistButtonClickedEvent extends HomeEvent{
  final HomeProductDataModel clickedProduct;

  const HomeProductWishlistButtonClickedEvent({required this.clickedProduct});

}

class HomeProductCartButtonClickedEvent extends HomeEvent{
  final HomeProductDataModel clickedProduct;

 const HomeProductCartButtonClickedEvent({required this.clickedProduct});

}

class HomeWishlistButtonNavigateClickedEvent extends HomeEvent{

}

class HomeCartButtonNavigateClickedEvent extends HomeEvent{
  
}