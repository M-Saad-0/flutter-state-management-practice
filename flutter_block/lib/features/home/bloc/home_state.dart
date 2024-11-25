part of 'home_bloc.dart';

sealed class HomeState extends Equatable {
  const HomeState();
  
  @override
  List<Object> get props => [];
}

abstract class HomeActionState extends HomeState{}

final class HomeInitial extends HomeState {}

class HomeLoadedState extends HomeState{}
class HomeLoadedSuccessState extends HomeState{
  final List<HomeProductDataModel> products;

  const  HomeLoadedSuccessState({required this.products});
}
class HomeErrorState extends HomeState{}

class HomeNavigateToWishlistActionPage extends HomeActionState{} 
class HomeNavigateToCartActionPage extends HomeActionState{} 
class HomeProductWishlistedActionState extends HomeActionState{}
class HomeProductCartedActionState extends HomeActionState{}