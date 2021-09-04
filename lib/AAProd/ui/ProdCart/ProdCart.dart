import 'package:checkreg/AAProd/Logic/bloc/prodwithcart_bloc.dart';
import 'package:checkreg/AAProd/ui/Cart/Cartm.dart';
import 'package:checkreg/Fortend/Widget/AppBarWid.dart';
import 'package:checkreg/Fortend/Widget/Grid_List_prod.dart/GridWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PCDetail.dart';

// ! PRODUCT WITH CART PAGE

class ProdWithCartPage extends StatefulWidget {
  static const routeName = '/cartproduct-screens';

  ProdWithCartPage({Key? key}) : super(key: key);

  @override
  _ProdWithCartPageState createState() => _ProdWithCartPageState();
}

class _ProdWithCartPageState extends State<ProdWithCartPage> {
  ProdwithcartBloc prodBloc = ProdwithcartBloc();

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProdwithcartBloc>(context);
    prodBloc.add(FetchProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProdwithcartBloc, ProdwithcartState>(
      listener: (context, state) {
        print(
            '----------------------------------------------------------------');
        print('builder STATE :- $state');

        if (state is ProdwithcartInitial) {
        } else if (state is ProductCartLoadedState) {
          //   state.cartData;
          // state.cartData;

        }
        if (state is ProdAddedCartState) {
          // _cartItems = state.cartItems;

        }
        if (state is ProdDeletingCartState) {
          // _cartItems = state.cartItems;

        }
      },

      // ! BUILDER STATE IN BLOC
      builder: (context, state) {
        print(
            '----------------------------------------------------------------');
        print('builder STATE :- $state');

        if (state is ProductCartLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductCartErrorState) {
          return Center(child: Text(' this is eror ${state.message}'));
        }
        if (state is ProductCartLoadedState) {
          return Scaffold(
              appBar: CustomAppBar(
                titlename: 'ProductPage',
                actions: true,
              ),
              body: GridViewWidget(
                productstate: state.productData,
              ));
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                     // ! PRODUCT CART GRID VIEW WIDGET                     */
/* -------------------------------------------------------------------------- */

class ProdCartGVW extends StatelessWidget {
  ProdCartGVW({Key? key}) : super(key: key);

  dynamic productstate;

  @override
  Widget build(BuildContext context) {
    print('--------------------------------');
    print('PRODDATA:- $productstate');
    return Container(
      child: GridView.builder(
          shrinkWrap: true,
          itemCount: productstate.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.60,
            // crossAxisSpacing: 20,
            //   mainAxisSpacing: 20
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          itemBuilder: (context, index) {
            print('--------------------------------');
            print('PRODDATA:- $productstate');
            return PCLVBShow(prodData: productstate[index]);
          }),
    );
  }
}

// ! PRODUCT CART  LIST VIEW BUILDER

class PCLVBShow extends StatelessWidget {
  PCLVBShow({Key? key, this.prodData}) : super(key: key);

  dynamic prodData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: SizedBox(
        width: 160.0,
        child: Wrap(
          children: <Widget>[
            Image.asset(prodData.pic == null ? '' : prodData.pic),
            ListTile(
              onTap: () {
                print('--------------------------------');
                print('PRODDATA:- $prodData');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PCDetailPage(prodNumber: prodData['index'])));
              },
              title: Text(
                prodData.title,
                // title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                prodData.description,
                // subTitle,
                style: TextStyle(fontSize: 12.0),
              ),
            ),
            Row(
              children: [
                PCBtnC(
                  btnname: 'buynow',
                ),
                PCBtnC(
                  btnname: 'addtocart',
                  sendPage: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => BlocProvider.value(
                                value:
                                    BlocProvider.of<ProdwithcartBloc>(context),
                                child: PCShoppingCart())));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  // // buttons for product

}

/* -------------------------------------------------------------------------- */
/*                     // !ADD TO CART AND BUY NOW BUTTON                     */
/* -------------------------------------------------------------------------- */

class PCBtnC extends StatelessWidget {
  String btnname;
  dynamic sendPage;

  PCBtnC({Key? key, required this.btnname, this.sendPage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
            onTap: sendPage,
            //     () {
            //   Navigator.of(context).pushReplacementNamed(sendPage);
            // },
            child: Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.redAccent, Colors.red],
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                    child: Text(btnname,
                        style: TextStyle(color: Colors.white))))));
  }
}