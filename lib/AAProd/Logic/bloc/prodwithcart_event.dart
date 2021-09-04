part of 'prodwithcart_bloc.dart';

abstract class ProdwithcartEvent extends Equatable {
  ProdwithcartEvent();

  @override
  List<Object> get props => [];
}

// ! FIRST EVENT FOR FETCHING / INITIALIZE THE EVENT
class FetchProductEvent extends ProdwithcartEvent {
  @override
  List<Object> get props => [];
}
/* -------------------------------------------------------------------------- */
/*                        // ! CART EVETNS WITH PRODUCT                       */
/* -------------------------------------------------------------------------- */

class ProdAddingCartEvent extends ProdwithcartEvent {
  List<NewCart> cartItems;

  ProdAddingCartEvent({required this.cartItems});

  @override
  List<Object> get props => [cartItems];
}

class ProdAddedCartEvent extends ProdwithcartEvent {
  List<NewCart> cartItems;

  ProdAddedCartEvent({required this.cartItems});
  @override
  List<Object> get props => [cartItems];
}

class ProdDeleteCartEvent extends ProdwithcartEvent {
  List<NewCart> cartItems;
  int? index;
  ProdDeleteCartEvent({required this.cartItems, this.index});
  @override
  List<Object> get props => [cartItems, index!];
}
