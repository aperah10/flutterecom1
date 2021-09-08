import 'package:checkreg/Fortend/RCLS/CartScr.dart';
import 'package:checkreg/Fortend/secscrren/Product_Scr/ListView.dart';
import 'package:checkreg/Fortend/secscrren/SerachProduct/SearchProduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

// !my imports
import 'Fortend/new_auth_screen/new_home.dart';
import 'Fortend/new_auth_screen/new_login_scr.dart';
import 'Fortend/new_auth_screen/new_signup_scr.dart';
import 'Fortend/secscrren/Product_Scr/GridViewList.dart';
import 'ZExtraFile/AllproviderList.dart';

main() {
  // final userRepository = CustomUserLoginRespo();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final CustomUserLoginRespo userRepository;

  MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LocalStorage storage = new LocalStorage('usertoken');

    return MultiProvider(
      providers: MainBloc.allBlocs(),
      child: MaterialApp(
        builder: (context, widget) => ResponsiveWrapper.builder(
            ClampingScrollWrapper.builder(context, widget!),
            defaultScale: true,
            minWidth: 480,
            // defaultName: DESKTOP,
            breakpoints: [
              ResponsiveBreakpoint.autoScale(480, name: MOBILE),
              ResponsiveBreakpoint.resize(600, name: MOBILE),
              ResponsiveBreakpoint.resize(850, name: TABLET),
              ResponsiveBreakpoint.resize(1080, name: DESKTOP),
            ],
            background: Container(color: Color(0xFFF5F5F5))),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: storage.ready,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            if (storage.getItem('token') == null) {
              return NewLoginScrrens();
            }

            return NewHomeScreen();
          },
        ),
        routes: {
          NewHomeScreen.routeName: (ctx) => NewHomeScreen(),
          NewLoginScrrens.routeName: (ctx) => NewLoginScrrens(),
          NewSignUpScreen.routeName: (ctx) => NewSignUpScreen(),
          ProductGridView.routeName: (ctx) => ProductGridView(),
          ProductListView.routeName: (ctx) => ProductListView(),
          SearchProductPage.routeName: (ctx) => SearchProductPage(),
          CartScreen.routeName: (ctx) => CartScreen()
        },
      ),
    );
  }
}
