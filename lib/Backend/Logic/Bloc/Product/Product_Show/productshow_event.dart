part of 'productshow_bloc.dart';

abstract class ProductshowEvent extends Equatable {}

class FetchProductEvent extends ProductshowEvent {
  @override
  List<Object> get props => [];
}

/* -------------------------------------------------------------------------- */
/*                   // ! ADDDING CART EVENT IN PRODUCT PAGE                  */
/* -------------------------------------------------------------------------- */

class ItemAddingCartEvent extends ProductshowEvent {
  List<NewCart> cartItems;

  ItemAddingCartEvent({required this.cartItems});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ItemAddedCartEvent extends ProductshowEvent {
  List<NewCart> cartItems;

  ItemAddedCartEvent({required this.cartItems});

  @override
  // TODO: implement props
  List<Object?> get props =>
      throw UnimplementedError('ItemAddedcartEvent failed');
}

class ItemDeleteCartEvent extends ProductshowEvent {
  List<NewCart> cartItems;
  int index;
  ItemDeleteCartEvent({required this.cartItems, required this.index});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
