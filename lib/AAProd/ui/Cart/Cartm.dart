import 'package:checkreg/AAProd/Logic/bloc/prodwithcart_bloc.dart';
import 'package:checkreg/Backend/models/Cart/New_Cartm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PCShoppingCart extends StatefulWidget {
  PCShoppingCart({Key? key}) : super(key: key);

  @override
  _PCShoppingCartState createState() => _PCShoppingCartState();
}

class _PCShoppingCartState extends State<PCShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProdwithcartBloc, ProdwithcartState>(
        listener: (context, state) {},
        builder: (context, state) {
          print("product page state: $state");
          if (state is ProdAddedCartState) {
            print(state.cartItems);
            return Center(child: CircularProgressIndicator());
          }

          if (state is ProductCartLoadedState) {
            return Scaffold(
              backgroundColor: Colors.yellow,
              appBar: AppBar(
                backgroundColor: Color(0XFFF8F5F0),
                title: Text(
                  'Shopping Cart',
                  style: TextStyle(color: Colors.purple),
                ),
                elevation: 0,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              bottomNavigationBar: Container(
                height: 68,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        blurRadius: 8,
                        color: Color(0xFF000000).withOpacity(0.20),
                      ),
                      BoxShadow(
                        offset: Offset(0, -1),
                        blurRadius: 3,
                        color: Color(0xFF000000).withOpacity(0.20),
                      ),
                      BoxShadow(
                        offset: Offset(0, -1),
                        blurRadius: 4,
                        color: Color(0xFF000000).withOpacity(0.14),
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text('Total Amount'),
                      // Text('\$${totalAmount.toStringAsFixed(2)}'),
                    ],
                  ),
                ),
              ),
              body: state.cartData == null || state.cartData.length == 0
                  ? Center(child: Text('Your Cart is Empty'))
                  : ListView.builder(
                      itemCount: state.cartData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Image.network(
                                        state.cartData[index].product!.title!,
                                        height: 64,
                                        width: 64,
                                      ),
                                      SizedBox(width: 20),
                                      Text(state
                                          .cartData[index].product!.title!),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          setState(() {
                                            if (state
                                                is ProductCartLoadedState) {
                                              state.cartData.removeAt(index);
                                              // calculateTotalAmount(cartItems);

                                              // ! CART ITEM DELETE
                                              BlocProvider.of<ProdwithcartBloc>(
                                                  context)
                                                ..add(ProdDeleteCartEvent(
                                                    product_id: state
                                                        .productData[0].id
                                                        .toString()));
                                              // ! END CART ITEM METHOD

                                            } else if (state
                                                is ProdAddedCartState) {
                                              state.cartData.removeAt(index);
                                              // calculateTotalAmount(cartItems);

                                              // BlocProvider.of<ProdwithcartBloc>(
                                              //     context)
                                              //   ..add(ProdDeleteCartEvent(
                                              //       cartItems: state.cartData));
                                              // ! CART ITEM DELETE
                                              BlocProvider.of<ProdwithcartBloc>(
                                                  context)
                                                ..add(ProdDeleteCartEvent(
                                                    product_id: state
                                                        .productData[0].id
                                                        .toString()));
                                              // ! END CART ITEM METHOD

                                            } else if (state
                                                is ProdDeletingCartState) {
                                              state.cartData.removeAt(index);
                                              // calculateTotalAmount(cartItems);

                                              // ! CART ITEM DELETE
                                              BlocProvider.of<ProdwithcartBloc>(
                                                  context)
                                                ..add(ProdDeleteCartEvent(
                                                    product_id: state
                                                        .productData[0].id
                                                        .toString()));
                                              // ! END CART ITEM METHOD
                                            }
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          if (state.cartData[index].quantity! >
                                              0)
                                            setState(() {
                                              // calculateTotalAmount(widget.cartData);
                                              state.cartData[index].quantity ??
                                                  -1;
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
                                                  color: Colors.black,
                                                  width: 0.5)),
                                          child: Text(
                                            state.cartData[index].quantity
                                                .toString(),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            // calculateTotalAmount(cartItems);
                                            // state.cartData[index].quantity
                                          });
                                        },
                                      ),
                                      Spacer(),
                                      Text(
                                          '\$${state.cartData[index].product!.discountPrice! * state.cartData[index].quantity!} ')
                                    ],
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
          if (state is ProdDeletingCartState) {
            // cartItems = state.cartItems;
            // calculateTotalAmount(cartItems);
          }

          if (state is ProdAddingCartState) {
            // cartItems = state.cartItems;
            // calculateTotalAmount(cartItems);
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
