part of 'shop_bloc.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object> get props => [];
}

class ShopPageInitializedEvent extends ShopEvent {}

class ItemAddingCartEvent extends ShopEvent {
  List<NewCart> cartItems;

  ItemAddingCartEvent({required this.cartItems});
}

class ItemAddedCartEvent extends ShopEvent {
  List<NewCart> cartItems;

  ItemAddedCartEvent({required this.cartItems});
}

class ItemDeleteCartEvent extends ShopEvent {
  List<NewCart> cartItems;
  int? index;
  ItemDeleteCartEvent({required this.cartItems, this.index});
}
