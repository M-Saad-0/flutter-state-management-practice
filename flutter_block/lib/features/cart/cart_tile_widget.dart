import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_block/features/cart/bloc/cart_bloc.dart';
import 'package:flutter_block/features/home/bloc/home_bloc.dart';
import 'package:flutter_block/features/home/models/home_product_data_model.dart';

class CartTileWidget extends StatefulWidget {
  final HomeProductDataModel model;final CartBloc cartBloc;
  const CartTileWidget({super.key, required this.model, required this.cartBloc});

  @override
  State<CartTileWidget> createState() => CarttTileWidgetState();
}

class CarttTileWidgetState extends State<CartTileWidget> {
  bool _hover = false;
  

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 1, color: const Color.fromARGB(125, 255, 255, 255))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
            onEnter: (_) {
              setState(() {
                _hover = true;
              });
            },
            onExit: (_) {
              setState(() {
                _hover = false;
              });
            },
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.model.imageUrl),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _hover ? 1.0 : 0.0,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                      height: 200,
                      width: double.maxFinite,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(widget.model.name),
          Text(
            widget.model.description,
            style: const TextStyle(
              color: Color.fromARGB(146, 255, 255, 255),
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text(
                "\$${widget.model.price}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              
              IconButton(
                  onPressed: () {
                    widget.cartBloc.add(CartRemoveFromCartEvent(model: widget.model)
                     );
                  },
                  icon: const Icon(Icons.shopping_cart))
            ],
          )
        ],
      ),
    );
  }
}
