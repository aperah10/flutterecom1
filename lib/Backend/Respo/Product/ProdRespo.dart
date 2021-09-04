import 'dart:convert';

import 'package:checkreg/Backend/models/Product/New_Product_m.dart';
import 'package:http/http.dart' as http;

/* -------------------------------------------------------------------------- */
/*           
              !     SHOW ALL PRODUCT LIST WITH TWO PATTERN :-  
              ! 1. MAKEING ANOTHER ABSTRACT CLASS :- LIKE THIS PAGE 
              ! 2. WITHOUT ANY ABSTRACT CLASS :- REGISTER, LOGIN PAGE   
                                                                                */
/* -------------------------------------------------------------------------- */

abstract class ProductRespo {
  Future<List<ProductC>> getProduct();
}

class ProductDataRespo extends ProductRespo {
  String baseUrl = 'https://djecoms.herokuapp.com/p/';
  @override
  Future<List<ProductC>> getProduct() async {
    try {
      var res = await http.get(Uri.parse(baseUrl));
      // print(res.statusCode);
      if (res.statusCode == 200) {
        var datar = jsonDecode(res.body);
        // var datajson = jsonDecode(res.body).toString();
        // print(
        // '--------------------------------------------------------------------');
        // print('datajson :- $datajson');
        MainProduct mpt = MainProduct.fromJson({'productData': datar});
        // print(
        //     '--------------------------------------------------------------------');
        // print(mpt);
        // List<ProductM> productData = MainProductM.fromJson({'datar':datar});
        List<ProductC> productData = mpt.productData;
        // print(
        //     '--------------------------------------------------------------------');
        // print(productData);

        return productData;
      } else {
        // server error
        return Future.error("Server Error !");
      }
    } catch (e) {
      print('Error:- $e');
      return Future.error("Error Fetching Data !");
    }
  }
}



/* -------------------------------------------------------------------------- */
/*           
              !    SHOW SINGLE PRODUCT LIST :-  
                
                                                                                */
/* -------------------------------------------------------------------------- */