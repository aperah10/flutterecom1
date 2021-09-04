import 'package:checkreg/AAProd/Logic/bloc/prodwithcart_bloc.dart';
import 'package:checkreg/AAProd/ui/Cart/Cartm.dart';
import 'package:checkreg/Backend/models/Cart/New_Cartm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PCDetailPage extends StatefulWidget {
  static const routeName = '/cartproductdetails-screens';
  PCDetailPage({Key? key, this.prodNumber}) : super(key: key);
  dynamic prodNumber;

  @override
  _PCDetailPageState createState() => _PCDetailPageState();
}

class _PCDetailPageState extends State<PCDetailPage> {
  bool _itemselected = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProdwithcartBloc, ProdwithcartState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ProdAddingCartState) {
            //  state.cartItems;
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
                                  // widget.shopItem.product!.title!,
                                  widget.prodNumber.product.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Spacer(),
                                Text(
                                  '\$${widget.prodNumber.product.discountPrice}',
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
                                    if (widget.prodNumber.quantity > 0)
                                      setState(() {
                                        widget.prodNumber.quantity--;
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
                                      widget.prodNumber.quantity.toString(),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    setState(() {
                                      widget.prodNumber.quantity++;
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
                                  quantity: widget.prodNumber.quantity,
                                  product: widget.prodNumber.product,
                                  createdOn: widget.prodNumber.createdOn,
                                  customerCart: widget.prodNumber.customerCart,
                                  id: widget.prodNumber.id,
                                );
                                List<NewCart> cart = [];
                                cart.add(cartItem);

                                BlocProvider.of<ProdwithcartBloc>(context)
                                  ..add(ProdAddedCartEvent(cartItems: cart));

                                setState(() {
                                  _itemselected = true;
                                });
                              } else
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                      value: BlocProvider.of<ProdwithcartBloc>(
                                          context),
                                      child: PCShoppingCart(),
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
        });
  }
}
