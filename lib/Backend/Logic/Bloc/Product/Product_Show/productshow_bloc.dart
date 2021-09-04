import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkreg/Backend/Respo/Product/ProdRespo.dart';
import 'package:checkreg/Backend/Respo/RCLS/Cart/CartRespo.dart';
import 'package:checkreg/Backend/models/Cart/New_Cartm.dart';
import 'package:checkreg/Backend/models/Product/New_Product_m.dart';
import 'package:equatable/equatable.dart';

part 'productshow_event.dart';
part 'productshow_state.dart';

class ProductshowBloc extends Bloc<ProductshowEvent, ProductshowState> {
  final ProductRespo prodRespo;
  final CartRespo? cartRespo;
  ProductshowBloc({required this.prodRespo, this.cartRespo})
      : super(ProductshowInitial());

  // @override
  // ProductshowState get initialState => ProductshowInitial();
  @override
  Stream<ProductshowState> mapEventToState(
    ProductshowEvent event,
  ) async* {
    if (event is FetchProductEvent) {
      yield ProductLoadingState();

      try {
        dynamic token = storage.getItem('token');
        List<ProductC> productData = await prodRespo.getProduct();
        List<NewCart> cartData = await cartRespo!.getCartData();
        // yield ProductLoadedState(productData: productData);
        yield ProductLoadedState(productData: productData, cartData: cartData);
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
    // ! CART EVENT METHOD IN PRODUCT BLOC
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
