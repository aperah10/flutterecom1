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
  // final CartRespo? cartRespo;
  ProductshowBloc({
    required this.prodRespo,
  }) : super(ProductshowInitial());

  // @override
  // ProductshowState get initialState => ProductshowInitial();
  @override
  Stream<ProductshowState> mapEventToState(
    ProductshowEvent event,
  ) async* {
    if (event is FetchProductEvent) {
      yield ProductLoadingState();

      try {
        List<ProductC> productData = await prodRespo.getProduct();

        // yield ProductLoadedState(productData: productData);
        yield ProductLoadedState(
          productData: productData,
        );
      } catch (e) {
        yield ProductErrorState(message: e.toString());
      }
    }
  }
}
