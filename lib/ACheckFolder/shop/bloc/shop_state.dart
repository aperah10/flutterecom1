part of 'shop_bloc.dart';

abstract class ShopState extends Equatable {
  const ShopState();

  @override
  List<Object> get props => [];
}

class ShopInitial extends ShopState {}

class ShopPageLoadedState extends ShopState {
  // ShopData shopData;
  // ShopData cartData;
  List<ProductC> shopData;
  List<NewCart> cartData;
  ShopPageLoadedState({required this.cartData, required this.shopData});
}

class ItemAddingCartState extends ShopState {
  MainCart? cartData;
  List<NewCart> cartItems;

  ItemAddingCartState({this.cartData, required this.cartItems});
}

class ItemAddedCartState extends ShopState {
  List<NewCart> cartItems;

  ItemAddedCartState({required this.cartItems});
}

class ItemDeletingCartState extends ShopState {
  List<NewCart> cartItems;

  ItemDeletingCartState({required this.cartItems});
}
