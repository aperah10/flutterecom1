import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkreg/Backend/Respo/Product/ProdRespo.dart';
import 'package:checkreg/Backend/Respo/RCLS/Cart/CartRespo.dart';
import 'package:checkreg/Backend/models/Cart/New_Cartm.dart';
import 'package:checkreg/Backend/models/Product/New_Product_m.dart';
import 'package:equatable/equatable.dart';

part 'prodwithcart_event.dart';
part 'prodwithcart_state.dart';

class ProdwithcartBloc extends Bloc<ProdwithcartEvent, ProdwithcartState> {
  // ! Adding Repo for data logic
  CartDataRespo cartRespo = CartDataRespo();
  ProductDataRespo prodRespo = ProductDataRespo();

  ProdwithcartBloc() : super(ProdwithcartInitial());

  @override
  Stream<ProdwithcartState> mapEventToState(
    ProdwithcartEvent event,
  ) async* {
    // ! FIRST STATE /EVENT FOR FETECH DATA
    if (event is FetchProductEvent) {
      yield ProductCartLoadingState();

      try {
        List<ProductC> productData = await prodRespo.getProduct();
        List<NewCart> cartData = await cartRespo.getCartData();

        // print('-----------------------------------------------------------');
        // print('productData:- $productData ');
        // print('cartData:- $cartData ');
        yield ProductCartLoadedState(
            productData: productData, cartData: cartData);
      } catch (e) {
        yield ProductCartErrorState(message: e.toString());
      }
    }

    /* -------------------------------------------------------------------------- */
    /*                  // ! CART ADDED , ADDING  , DELETING BLOC                 */
    /* -------------------------------------------------------------------------- */
    if (event is ProdAddingCartEvent) {
      print('ProdAddingCartEvent Happend');

      //  List<NewCart> cartData = await cartRespo.getCartData();
      yield ProdAddingCartState(cartItems: event.cartItems);
    }

    if (event is ProdAddedCartEvent) {
      print('ProdAddedCartEvent Happend');

      // print(event.quantity);
      // bool prodid = await cartRespo.addCartData(
      //     product_id: event.product_id, quantity: event.quantity);
      List<NewCart> prodList = await cartRespo.addCartData(
          product_id: event.product_id, quantity: event.quantity);
      print('RESULT  OF ADDTOCART :- $prodList');
      yield ProdAddedCartState(cartItems: prodList);
    }
    if (event is ProdDeleteCartEvent) {
      print('ProdDeleteCartEvent Happend');
      List<NewCart> prodList = await cartRespo.delCartData(
        product_id: event.product_id,
      );
      print('RESULT  OF ADDTOCART :- $prodList');
      yield ProdDeletingCartState(cartItems: prodList);
    }
  }
}
