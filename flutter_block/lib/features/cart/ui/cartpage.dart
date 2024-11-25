import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_block/features/cart/cart_tile_widget.dart';

class Cartpage extends StatefulWidget {
  const Cartpage({super.key});

  @override
  State<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends State<Cartpage> {
  CartBloc cartBloc = CartBloc();
  @override
  void initState() {
    cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Items"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (context, state) {},
          listenWhen: (previous, current) => current is CartActionState,
          buildWhen: (previous, current) => current is! CartActionState,
          builder: (context, state) {
            if (state.runtimeType is CartInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.runtimeType == CartSuccessState) {
              final successState = state as CartSuccessState;
              print("ok");
              return ListView.builder(
                itemCount: successState.cartItems.length,
                itemBuilder: (context, index) => CartTileWidget(
                  model: successState.cartItems[index],
                  cartBloc: cartBloc,
                ),
              );
            } else {
              return const SizedBox();
            }
          },
          ),
    );
  }
}
