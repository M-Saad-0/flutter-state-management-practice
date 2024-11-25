import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block/features/cart/ui/cartpage.dart';
import 'package:flutter_block/features/home/bloc/home_bloc.dart';
import 'package:flutter_block/features/home/ui/product_tile_widget.dart';
import 'package:flutter_block/features/wishlist/ui/wishlist_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartActionPage) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Cartpage()));
        } else if (state is HomeNavigateToWishlistActionPage) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishlistPage()));
        } else if(state is HomeProductCartedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item has been added to cart.")));
        } else if(state is HomeProductWishlistedActionState){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item has been added to wishlist.")));
        }
      },
      builder: (context, state) {
        switch (state) {
          case HomeInitial():
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedState():
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          case HomeLoadedSuccessState():
            return Scaffold(
              appBar: AppBar(
                title: const Text("My Grocery App"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtonNavigateClickedEvent());
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartButtonNavigateClickedEvent());
                      },
                      icon: const Icon(Icons.shopping_cart_outlined))
                ],
              ),
              body: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) => ProductTileWidget(
                        model: state.products[index],
                        homeBloc: homeBloc,
                      )),
            );
          case HomeErrorState():
            return const Center(
              child: Text("Some error has occured"),
            );
          default:
            return const Scaffold(body: SizedBox());
        }
      },
    );
  }
}
