import 'package:checkreg/Backend/Logic/Bloc/Product/Product_Show/productshow_bloc.dart';
import 'package:checkreg/Backend/Respo/Product/ProdRespo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ! My import

class ProductListView extends StatefulWidget {
  static const routeName = '/list-product-screens';
  ProductListView({Key? key}) : super(key: key);

  @override
  _ProductListViewState createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> {
  ProductshowBloc prodBloc = ProductshowBloc(prodRespo: ProductDataRespo());

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProductshowBloc>(context);
    prodBloc.add(FetchProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: BlocConsumer<ProductshowBloc, ProductshowState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is ProductLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductErrorState) {
          return Center(child: Text(' this is eror ${state.message}'));
        }
        if (state is ProductLoadedState) {
          // return buildHintsList(state.productData);
          return ListShowWidget(productData: state.productData);
        }
        return Container();
      },
    )));
  }
}

class ListShowWidget extends StatelessWidget {
  dynamic productData;
  ListShowWidget({Key? key, this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new ListView.builder(
          itemCount: productData.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        height: 90,
                        width: 100,
                        child: Image(
                            image: NetworkImage(
                          productData[index].pic ?? '',
                        ))),

                    // child: Image.network(productData[index].pic ?? '')),
                    // SizedBox(height: 30),
                    Text(productData[index].title ?? 'No data '),
                  ],
                ),
              ),
            );
          }),
    );
    ;
  }
}
