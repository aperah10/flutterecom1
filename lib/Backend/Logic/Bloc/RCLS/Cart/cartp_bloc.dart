import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkreg/Backend/Respo/RCLS/Cart/CartRespo.dart';
import 'package:checkreg/Backend/models/Cart/New_Cartm.dart';
import 'package:equatable/equatable.dart';

import 'package:localstorage/localstorage.dart';

part 'cartp_event.dart';
part 'cartp_state.dart';

class CartpBloc extends Bloc<CartpEvent, CartpState> {
  final CartRespo cartRespo;
  LocalStorage storage = new LocalStorage('usertoken');

  CartpBloc({required this.cartRespo, required this.storage})
      : super(CartpInitial());

  @override
  Stream<CartpState> mapEventToState(
    CartpEvent event,
  ) async* {
    if (event is FetchCartEvent) {
      yield CartLoadingState();
      try {
        dynamic token = storage.getItem('token');
        // print('bloc toekn $token');
        List<NewCart> cartData = await cartRespo.getCartData();
        print('bloc cartData $cartData');
        yield CartLoadedState(cartData: cartData);
      } catch (e) {
        yield CartErrorState(message: e.toString());
      }
    }
  }
}
