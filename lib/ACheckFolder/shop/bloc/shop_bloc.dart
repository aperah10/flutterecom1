import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkreg/Backend/Respo/Product/ProdRespo.dart';
import 'package:checkreg/Backend/Respo/RCLS/Cart/CartRespo.dart';
import 'package:checkreg/Backend/models/Cart/New_Cartm.dart';
import 'package:checkreg/Backend/models/Product/New_Product_m.dart';
import 'package:equatable/equatable.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  CartDataRespo cartRespo = CartDataRespo();
  ProductDataRespo prodRespo = ProductDataRespo();

  ShopBloc() : super(ShopInitial()) {
    add(ShopPageInitializedEvent());
  }
//
  @override
  Stream<ShopState> mapEventToState(
    ShopEvent event,
  ) async* {
    if (event is ShopPageInitializedEvent) {
      // ShopData shopData = await shopDataProvider.getShopItems();
      // ShopData cartData = await shopDataProvider.geCartItems();
      dynamic token = storage.getItem('token');
      List<ProductC> productData = await prodRespo.getProduct();
      List<NewCart> cartData = await cartRespo.getCartData();
      yield ShopPageLoadedState(shopData: productData, cartData: cartData);
    }
    if (event is ItemAddingCartEvent) {
      yield ItemAddingCartState(cartItems: event.cartItems);
    }
    if (event is ItemAddedCartEvent) {
      yield ItemAddedCartState(cartItems: event.cartItems);
    }
    if (event is ItemDeleteCartEvent) {
      yield ItemDeletingCartState(cartItems: event.cartItems);
    }
  }
}
