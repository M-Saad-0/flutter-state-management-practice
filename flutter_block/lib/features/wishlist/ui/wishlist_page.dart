import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_block/features/wishlist/bloc/wishbloc_bloc.dart';
import 'package:flutter_block/features/wishlist/ui/wishlist_tile_widget.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishblocBloc wishlistBloc = WishblocBloc();
  @override
  initState() {
    wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Wishlist Items"),),
      body: BlocConsumer<WishblocBloc ,WishblocState>(
        bloc: wishlistBloc,
        listenWhen: (context, state)=>state is WishblocActionState,
        buildWhen: (context, state)=>state is! WishblocActionState,
        listener: (context, state) {
          
        },
        builder: (context, state) {
          switch(state) {
                      case WishblocInitial():
              return const Center(child: CircularProgressIndicator(),);
            case WishlistLoadSuccess():
              return ListView.builder(
                    itemCount: state.wishlistItems.length,
                    itemBuilder: (context, index) => WishlistTileWidget(
                          model: state.wishlistItems[index],
                          wishblocBloc: wishlistBloc,
                        ));
              
            default:return const SizedBox();
          }
        },
      ),
    );
  }
}
