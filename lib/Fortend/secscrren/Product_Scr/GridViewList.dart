import 'package:checkreg/Backend/Logic/Bloc/Product/Product_Show/productshow_bloc.dart';
import 'package:checkreg/Backend/Respo/Product/ProdRespo.dart';
import 'package:checkreg/Fortend/Widget/AppBarWid.dart';
import 'package:checkreg/Fortend/Widget/Grid_List_prod.dart/GridWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ! my import

class ProductGridView extends StatefulWidget {
  static const routeName = '/grid-product-screens';
  ProductGridView({
    Key? key,
  }) : super(key: key);

  @override
  _ProductGridViewState createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {
  ProductshowBloc prodBloc = ProductshowBloc(prodRespo: ProductDataRespo());

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProductshowBloc>(context);
    prodBloc.add(FetchProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductshowBloc, ProductshowState>(
        listener: (context, state) {},
        builder: (context, state) {
          print("produc page state: $state");
          if (state is ProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProductErrorState) {
            return Center(child: Text(' this is eror ${state.message}'));
          }
          if (state is ProductLoadedState) {
            return Scaffold(
                appBar: CustomAppBar(
                  titlename: 'ProductPage',
                  actions: true,
                ),
                body: GridViewWidget(
                  productstate: state.productData,
                ));
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
