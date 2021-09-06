part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

// !  PROFILE FETCH Event
class FetchAddressEvent extends AddressEvent {
  @override
  List<Object> get props => [];
}

/* -------------------------------------------------------------------------- */
/*                          // ! PROFILE SAVE BUTTON                          */
/* -------------------------------------------------------------------------- */

class AddressSaveButtonEvent extends AddressEvent {
  final String fullname;
  final String email;
  final String phone;
  final String house;
  final String trade;
  final String city;
  final String area;
  final String pin_code;
  final String state;

  final String delTime;

  AddressSaveButtonEvent({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.house,
    required this.trade,
    required this.area,
    required this.city,
    required this.pin_code,
    required this.delTime,
    required this.state,
  });

  @override
  // List<Object> get props => [fullname, email, gender, pic];

  @override
  String toString() =>
      'AddressButton { username: $fullname, password: $email }';
}
