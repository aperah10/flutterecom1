import 'dart:convert';

import 'package:checkreg/Backend/models/Cart/New_Cartm.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

/* -------------------------------------------------------------------------- */
/*           
              !     SHOW ALL PRODUCT LIST WITH TWO PATTERN :-  
              ! 1. MAKEING ANOTHER ABSTRACT CLASS :- LIKE THIS PAGE 
              ! 2. WITHOUT ANY ABSTRACT CLASS :- REGISTER, LOGIN PAGE   
                                                                                */
/* -------------------------------------------------------------------------- */
LocalStorage storage = new LocalStorage('usertoken');
var token = storage.getItem('token');

abstract class CartRespo {
  Future<List<NewCart>> getCartData();
  // Future<List<NewCart>> addCartData();
}

class CartDataRespo extends CartRespo {
  @override
  Future<List<NewCart>> getCartData() async {
    String baseUrl = 'https://djecoms.herokuapp.com/cart/';
    try {
      var res = await http.get(Uri.parse(baseUrl), headers: {
        "Authorization": "token $token",
      });

      if (res.statusCode == 200) {
        var datar = jsonDecode(res.body);
        // print('datatr $datar');
        MainCart mpt = MainCart.fromJson({'cartData': datar});
        print(
            '----------------------------------------------------------------------------');
        // print('Cart RESPO MPT:- $mpt');
        // List<ProductM> productData = MainProductM.fromJson({'datar':datar});
        List<NewCart> cartData = mpt.cartData;
        // print('Cart RESPO PRODDATA :- $cartData');

        return cartData;
      } else {
        // server error
        return Future.error("Server Error !");
      }
    } catch (e) {
      print('Error:- $e');
      return Future.error("Error Fetching Data !");
    }
  }

  // ! ADD TO CART ENVET
  @override
  Future<void> addCartData(
      // {}
      ) async {
    String Baseurl = 'http://10.0.2.2:8000/api/addtocart/';
    // var token = storage.getItem('token');
    try {
      var res = await http.post(Uri.parse(Baseurl),
          body: json.encode({
            // 'id': id,
          }),
          headers: {
            "Content-Type": "application/json",
            'Authorization': "token $token"
          });
      var data = json.decode(res.body) as Map;
      print('CART POST MEHTOD Statuc Code  :-  ${res.statusCode}');
      if (data['error'] == false) {
        getCartData();
      }
    } catch (e) {
      print("e addtoCart");
      print(e);
    }
  }
}
