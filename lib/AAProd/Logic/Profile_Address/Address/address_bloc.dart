import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkreg/Backend/Respo/Prof_Address/AddressRespo.dart';
import 'package:checkreg/Backend/models/Prof_Address/Addressm.dart';
import 'package:equatable/equatable.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  // ! Adding Repo for data logic
  AddressDataRespo profRespo = AddressDataRespo();

  AddressBloc() : super(AddressInitial());

  @override
  Stream<AddressState> mapEventToState(
    AddressEvent event,
  ) async* {
    // ! FIRST STATE /EVENT FOR FETECH DATA
    if (event is FetchAddressEvent) {
      yield AddressLoadingState();

      try {
        List<Address> profData = await profRespo.getAddressData();

        // print('-----------------------------------------------------------');
        // print('productData:- $productData ');
        // print('cartData:- $cartData ');
        yield AddressLoadedState(
          addressData: profData,
        );
      } catch (e) {
        yield AddressErrorState(error: e.toString());
      }
    }

    /* -------------------------------------------------------------------------- */
    /*                  // ! Address ADDED , ADDING  , DELETING BLOC                 */
    /* -------------------------------------------------------------------------- */
    if (event is AddressSaveButtonEvent) {
      print('ProdAddedCartEvent Happend');
      List<Address> prodList = await profRespo.addAddressData(
          fullname: event.fullname,
          email: event.email,
          phone: event.phone,
          house: event.house,
          trade: event.trade,
          area: event.area,
          city: event.city,
          pin_code: event.pin_code,
          delTime: event.delTime,
          state: event.state);

      print('RESULT  OF ADDTOCART :- $prodList');
      yield AddressSuccessState();
    }
  }
}
