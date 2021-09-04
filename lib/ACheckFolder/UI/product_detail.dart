import 'dart:ui';

import 'package:checkreg/ACheckFolder/UI/shopping_cart.dart';
import 'package:checkreg/ACheckFolder/shop/bloc/shop_bloc.dart';
import 'package:checkreg/Backend/models/Cart/New_Cartm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({Key? key, required this.shopItem}) : super(key: key);

  final NewCart shopItem;
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List<NewCart> cartItems = [];

  bool _itemselected = false;
  @override
  Widget build(BuildContext context) {
    return BlocListener<ShopBloc, ShopState>(
      listener: (context, state) {},
      child: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ItemAddingCartState) {
            cartItems = state.cartItems;
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                "Product Details",
              ),
              elevation: 0,
              backgroundColor: Colors.orange,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      height: 350,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Image.network(widget.shopItem.),
                            Text('this is pic'),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Text(
                                  widget.shopItem.product!.title!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  '\$${widget.shopItem.product!.discountPrice!}',
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Quantity',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    if (widget.shopItem.quantity! > 0)
                                      setState(() {
                                        widget.shopItem.quantity! - 1;
                                      });
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 30,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 0.5)),
                                    child: Text(
                                      widget.shopItem.quantity.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      widget.shopItem.quantity! + 1;
                                    });
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: FlatButton(
                            color: Colors.pink,
                            onPressed: () {
                              if (_itemselected == false) {
                                NewCart cartItem = NewCart(
                                  // imageUrl: widget.shopItem.imageUrl,
                                  // title: widget.shopItem.title,
                                  // price: widget.shopItem.price,
                                  quantity: widget.shopItem.quantity,
                                  product: widget.shopItem.product,
                                  createdOn: widget.shopItem.createdOn,
                                  customerCart: widget.shopItem.customerCart,
                                  id: widget.shopItem.id,
                                );

                                cartItems.add(cartItem);

                                BlocProvider.of<ShopBloc>(context)
                                  ..add(
                                      ItemAddedCartEvent(cartItems: cartItems));

                                setState(() {
                                  _itemselected = true;
                                });
                              } else
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: BlocProvider.of<ShopBloc>(context),
                                      child: ShoppingCart(),
                                    ),
                                  ),
                                );
                            },
                            child: Text(
                              _itemselected ? 'Go to Cart' : 'Add to Cart',
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
