import 'dart:convert';

import 'package:checkreg/Backend/models/Prof_Address/Addressm.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

/* -------------------------------------------------------------------------- */
/*           
             ! ADDDRESS PAGE GET AND POST METHOD   
                                                                                */
/* -------------------------------------------------------------------------- */
LocalStorage storage = new LocalStorage('usertoken');
var token = storage.getItem('token');

class AddressDataRespo {
  Future<List<Address>> getAddressData() async {
    String baseUrl = 'https://djecoms.herokuapp.com/address/';
    try {
      var res = await http.get(Uri.parse(baseUrl), headers: {
        "Authorization": "token $token",
      });

      if (res.statusCode == 200) {
        var datar = jsonDecode(res.body);
        // print('datatr $datar');
        MainAddress mpt = MainAddress.fromJson({'addressData': datar});
        print(
            '----------------------------------------------------------------------------');
        // print('Cart RESPO MPT:- $mpt');
        // List<ProductM> productData = MainProductM.fromJson({'datar':datar});
        List<Address> addressData = mpt.addressData;
        // print('Cart RESPO PRODDATA :- $cartData');

        return addressData;
      } else {
        // server error
        return Future.error("Server Error !");
      }
    } catch (e) {
      print('Error:- $e');
      return Future.error("Error Fetching Data !");
    }
  }

  /* -------------------------------------------------------------------------- */
  /*                           // ! ADDRESS POST METHOD                         */
  /* -------------------------------------------------------------------------- */

  Future<List<Address>> addAddressData({
    required String fullname,
    required String email,
    required String phone,
    required String house,
    required String trade,
    required String area,
    required String city,
    required String pin_code,
    required String delTime,
    required String state,
  }) async {
    String Baseurl = 'https://djecoms.herokuapp.com/address/';
    // var token = storage.getItem('token');
    try {
      var res = await http.post(Uri.parse(Baseurl),
          body: json.encode({
            "fullname": fullname,
            "email": email,
            "phone": phone,
            "house": house,
            "trade": trade,
            "area": area,
            "city": city,
            "pin_code": pin_code,
            "delTime": delTime,
            "state": state,
          }),
          headers: {
            "Content-Type": "application/json; charset=UTF-8",
            'Authorization': "token $token"
          });
      var data = json.decode(res.body) as Map;
      print('this is data $data');
      print(res.body);
      print('CART POST MEHTOD Statuc Code  :-  ${res.statusCode}');

      if (res.statusCode == 200) {
        return getAddressData();
        // return true;
      }
      return Future.error("Error Fetching Data !");

      // return false;
    } catch (e) {
      print("e ADDRESS");
      print(e);
      // return false;
      return Future.error("Error Fetching Data !");
    }
  }
}
