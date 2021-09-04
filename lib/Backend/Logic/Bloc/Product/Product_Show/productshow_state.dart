part of 'productshow_bloc.dart';

abstract class ProductshowState extends Equatable {}

class ProductshowInitial extends ProductshowState {
  @override
  List<Object> get props => [];
}

class ProductLoadingState extends ProductshowState {
  @override
  List<Object> get props => [];
}

class ProductLoadedState extends ProductshowState {
  List<ProductC> productData;
  List<NewCart>? cartData;
  ProductLoadedState({required this.productData, this.cartData});

  @override
  List<Object> get props => [];
}

class ProductErrorState extends ProductshowState {
  String message;
  ProductErrorState({required this.message});
  @override
  List<Object> get props => [];
}

/* -------------------------------------------------------------------------- */
/*                    // ! CART ADDED STATE IN PRODUCT BLOC                   */
/* -------------------------------------------------------------------------- */

class ItemAddingCartState extends ProductshowState {
  MainCart? cartData;
  List<NewCart> cartItems;

  ItemAddingCartState({this.cartData, required this.cartItems});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ItemAddedCartState extends ProductshowState {
  List<NewCart> cartItems;

  ItemAddedCartState({required this.cartItems});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class ItemDeletingCartState extends ProductshowState {
  List<NewCart> cartItems;

  ItemDeletingCartState({required this.cartItems});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
