import 'dart:js';

import 'package:checkreg/AAProd/Logic/bloc/prodwithcart_bloc.dart';
import 'package:checkreg/ACheckFolder/shop/bloc/shop_bloc.dart';
import 'package:checkreg/Backend/Logic/Bloc/Product/Product_Show/productshow_bloc.dart';
import 'package:checkreg/Backend/Logic/Bloc/Product/Search_Product/searchproduct_bloc.dart';
import 'package:checkreg/Backend/Logic/Bloc/RCLS/Cart/cartp_bloc.dart';
import 'package:checkreg/Backend/Respo/Authr/new_auth_respo/new_custlogin_respo.dart';
import 'package:checkreg/Backend/Respo/Product/ProdRespo.dart';
import 'package:checkreg/Backend/Respo/Product/SerachRespo.dart';
import 'package:checkreg/Backend/Respo/RCLS/Cart/CartRespo.dart';
import 'package:checkreg/Fortend/Widget/Form/formValdation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class MainBloc {
  static List<SingleChildWidget> allBlocs() {
    return [
      ChangeNotifierProvider(create: (ctx) => NewCustomUserLoginRespo()),
      ChangeNotifierProvider(create: (ctx) => AllFormValdation()),
      BlocProvider(
          create: (ctx) => ProductshowBloc(prodRespo: ProductDataRespo())),
      BlocProvider(
          create: (ctx) =>
              SearchproductBloc(searchRepository: SearchPDataRespo())),
      BlocProvider(
          create: (ctx) =>
              CartpBloc(cartRespo: CartDataRespo(), storage: storage)),
      BlocProvider(create: (context) => ShopBloc()),
      BlocProvider(create: (context) => ProdwithcartBloc())
    ];
  }
}
