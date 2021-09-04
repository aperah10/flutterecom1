import 'package:checkreg/Backend/Logic/Bloc/RCLS/Cart/cartp_bloc.dart';
import 'package:checkreg/Backend/Respo/RCLS/Cart/CartRespo.dart';
import 'package:checkreg/Fortend/Widget/AppBarWid.dart';
import 'package:checkreg/Fortend/Widget/Grid_List_prod.dart/GridWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screens';
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartpBloc cartBloc = CartpBloc(cartRespo: CartDataRespo(), storage: storage);

  // ! LOAD INIT STATE IS CART PAGE
  @override
  void initState() {
    cartBloc = BlocProvider.of<CartpBloc>(context);
    cartBloc.add(FetchCartEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartpBloc, CartpState>(
        listener: (context, state) {},
        builder: (context, state) {
          print("produc page state: $state");
          if (state is CartLoadingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is CartErrorState) {
            return Center(child: Text(' this is eror ${state.message}'));
          }
          if (state is CartLoadedState) {
            return Scaffold(
                body: LoadedCartPage(
              cartData: state.cartData,
            ));
          }
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}

// !LOADED PAGE CART STATE
class LoadedCartPage extends StatelessWidget {
  dynamic cartData;
  LoadedCartPage({Key? key, this.cartData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titlename: 'Cart'),
      body: new Container(
          child: Stack(
        children: <Widget>[
          ListView.builder(
              itemCount: cartData.length,
              itemBuilder: (context, index) {
                print(index);
                // return dataOfListView(product: CatModel.items[index]);
                return ListdataScreen(cartprod: cartData[index]);
              }),

          // ! TOTAL PRICE
          Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100.0,
                width: 100.0,
                child: Text(
                  'Total :- ',
                ),
              )),

          //! SUBMIT BUTTON TO
          Align(
              alignment: Alignment.bottomCenter,
              child: BtnC(
                btnname: 'Continue',
              )),
        ],
      )),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                            // ! CART LIST SCREEN                           */
/* -------------------------------------------------------------------------- */

class ListdataScreen extends StatelessWidget {
  dynamic cartprod;
  var iconname;
  ListdataScreen({Key? key, this.cartprod, this.iconname}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      margin: EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
      color: Color(0xffEEEEEE),
      child: ListTile(
        // on ListItem clicked
        onTap: () {},

        // Image of ListItem
        leading: Container(child: Text('this is product pic')),

        // Lists of titles
        title: Container(
          margin: EdgeInsets.only(top: 10.0),
          height: 80.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(bottom: 2.0),
                  child: Text(
                    cartprod.product.title.toString(),
                    // 'this is name',

                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 10.0),
                  )),
              Container(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Text(
                  "Item Cetegory",
                  style: TextStyle(),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 3.0),
                child: Text(
                  cartprod.quantity.toString(),
                  // product.price.toString(),
                  style: TextStyle(color: Color(0xff374ABE)),
                ),
              ),
            ],
          ),
        ),

        // Item Add and Remove Container
        subtitle: Container(
            child: Wrap(
          direction: Axis.horizontal,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // print();
              },
              child: Icon(
                Icons.remove,
                size: 19.0,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10.0, top: 1.0, right: 10.0),
              child: Text(
                cartprod.quantity.toString(),
                style: TextStyle(color: Colors.black),
              ),
            ),

            // Add count button
            GestureDetector(
                onTap: () {
                  // itemCount++;
                },
                child: iconCond(iconname: 'add')
                //  Icon(
                //   Icons.add,
                //   size: 19.0,
                // ),
                ),
          ],
        )),

        // trailing shows the widget on the right corner of the list item
        trailing: iconCond(iconname: iconname),
      ),
    ));
  }
}

// Widget Conditon check
Widget iconCond({var iconname}) {
  Widget child;

  switch (iconname) {
    case 'refresh':
      child = Icon(
        Icons.refresh,
        size: 30,
        color: Color(0xff374ABE),
      );
      break;
    case 'add':
      child = Icon(
        Icons.add,
        size: 20,
        color: Color(0xff374ABE),
      );
      break;
    default:
      child = Icon(
        Icons.cancel,
        size: 30,
        color: Color(0xff374ABE),
      );
  }

  // Finally returning a Widget
  return Container(child: child);
}
