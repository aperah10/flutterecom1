import 'package:checkreg/AAProd/Logic/bloc/prodwithcart_bloc.dart';
import 'package:checkreg/AAProd/ui/Cart/Cartm.dart';
import 'package:checkreg/Backend/models/Product/New_Product_m.dart';
import 'package:checkreg/Fortend/Widget/AppBarWid.dart';
import 'package:checkreg/Fortend/Widget/Grid_List_prod.dart/GridWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'PCDetail.dart';

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
    return BlocListener<ProdwithcartBloc, ProdwithcartState>(
        listener: (context, state) {
      // print(
      //     '----------------------------------------------------------------');
      // print('builder STATE :- $state');

      if (state is ProdwithcartInitial) {
      } else if (state is ProductCartLoadedState) {
        //   state.cartData;
        // state.cartData;
        print('THis is listner ProductCartLoaded State');
      }
      if (state is ProdAddedCartState) {
        print('THis is ProductAdded State ${state.cartItems}');
        // BlocProvider.of<ProdwithcartBloc>(context)
        //     .add(ProdAddedCartEvent(cartItems: state.cartItems));
        // BlocProvider.of<ProdwithcartBloc>(context)
        //     .add(ProdAddedCartEvent(id: state.cartItems[0].product.id));
        Scaffold(body: Center(child: Text('PRODUCT ADDED IN CART')));
      }
      if (state is ProdDeletingCartState) {
        // _cartItems = state.cartItems;
        // print('THis is ProdDeletingLoaded State');
        // print('THis is ProductDelete State ${state.cartItems}');
        Scaffold(body: Center(child: Text('PRODUCT Delete IN CART')));
      }
    }, child: BlocBuilder<ProdwithcartBloc, ProdwithcartState>(
      // ! BUILDER STATE IN BLOC
      builder: (context, state) {
        // print(
        //     '----------------------------------------------------------------');
        // print('builder STATE :- $state');

        if (state is ProductCartLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is ProductCartErrorState) {
          return Center(child: Text(' this is eror ${state.message}'));
        }
        if (state is ProductCartLoadedState) {
          // print('stae of Productcart laoded ${state.productData}');
          // print('state of Productcart Cart laoded ${state.cartData}');
          return Scaffold(
              appBar: CustomAppBar(
                titlename: 'ProductPage',
                actions: true,
              ),
              body: ProdCartGVW(
                productstate: state.productData,
              ));
        }
        return Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    ));
  }
}

/* -------------------------------------------------------------------------- */
/*                                    // !                                    */
/* -------------------------------------------------------------------------- */

// ! PRODUCT WITH CART PAGE

// class ProdWithCartPage extends StatefulWidget {
//   static const routeName = '/cartproduct-screens';

//   ProdWithCartPage({Key? key}) : super(key: key);

//   @override
//   _ProdWithCartPageState createState() => _ProdWithCartPageState();
// }

// class _ProdWithCartPageState extends State<ProdWithCartPage> {
//   ProdwithcartBloc prodBloc = ProdwithcartBloc();

//   @override
//   void initState() {
//     prodBloc = BlocProvider.of<ProdwithcartBloc>(context);
//     prodBloc.add(FetchProductEvent());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<ProdwithcartBloc, ProdwithcartState>(
//       listener: (context, state) {
//         // print(
//         //     '----------------------------------------------------------------');
//         // print('builder STATE :- $state');

//         if (state is ProdwithcartInitial) {}
//         // else if (state is ProductCartLoadedState) {
//         //   //   state.cartData;
//         //   // state.cartData;
//         //   print('THis is listner ProductCartLoaded State');
//         // }
//         if (state is ProdAddedCartState) {
//           print('THis is ProductAdded State ${state.cartItems}');
//           // BlocProvider.of<ProdwithcartBloc>(context)
//           //     .add(ProdAddedCartEvent(cartItems: state.cartItems));
//           // BlocProvider.of<ProdwithcartBloc>(context)
//           //     .add(ProdAddedCartEvent(id: state.cartItems[0].product.id));
//           Scaffold(body: Center(child: Text('PRODUCT ADDED IN CART')));
//         }
//         if (state is ProdDeletingCartState) {
//           // _cartItems = state.cartItems;
//           // print('THis is ProdDeletingLoaded State');
//           // print('THis is ProductDelete State ${state.cartItems}');
//           Scaffold(body: Center(child: Text('PRODUCT Delete IN CART')));
//         }
//       },

//       // ! BUILDER STATE IN BLOC
//       builder: (context, state) {
//         // print(
//         //     '----------------------------------------------------------------');
//         // print('builder STATE :- $state');

//         if (state is ProductCartLoadingState) {
//           return Center(child: CircularProgressIndicator());
//         }
//         if (state is ProductCartErrorState) {
//           return Center(child: Text(' this is eror ${state.message}'));
//         }
//         if (state is ProductCartLoadedState) {
//           // print('stae of Productcart laoded ${state.productData}');
//           // print('state of Productcart Cart laoded ${state.cartData}');
//           return Scaffold(
//               appBar: CustomAppBar(
//                 titlename: 'ProductPage',
//                 actions: true,
//               ),
//               body: ProdCartGVW(
//                 productstate: state.productData,
//               ));
//         }
//         return Scaffold(body: Center(child: CircularProgressIndicator()));
//       },
//     );
//   }
// }

/* -------------------------------------------------------------------------- */
/*                     // ! PRODUCT CART GRID VIEW WIDGET                     */
/* -------------------------------------------------------------------------- */

class ProdCartGVW extends StatelessWidget {
  ProdCartGVW({Key? key, required this.productstate}) : super(key: key);

  dynamic productstate;
  // List<ProductC> productstate;

  @override
  Widget build(BuildContext context) {
    // print('--------------------------------');
    // print('PRODDATA:- $productstate');
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
            // print('--------------------------------');
            // print('PRODDATA:- $productstate');
            // print(index);
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
                print('---------------------------------------------------');
                print('PRODDATA:- $prodData');

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PCDetailPage(prodNumber: prodData)));
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
                    btnname: prodData.title == 'p2' &&
                            prodData.description == 'this is p2'
                        ? "gotocart"
                        : 'addtocart',
                    sendPage: () {
                      BlocProvider.of<ProdwithcartBloc>(context)
                        ..add(ProdAddedCartEvent(
                            product_id: prodData.id, quantity: 999));
                    }),
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
