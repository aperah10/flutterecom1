import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkreg/Backend/Logic/Bloc/Authr/auth/userauthenticate_bloc.dart';
import 'package:checkreg/Backend/Respo/Authr/new_auth_respo/new_custlogin_respo.dart';
import 'package:equatable/equatable.dart';

part 'userlogin_event.dart';
part 'userlogin_state.dart';

class UserloginBloc extends Bloc<UserloginEvent, UserloginState> {
  //  REPOSTIPRY FOR
  final NewCustomUserLoginRespo userRepository;
  // final UserLoginStorage userLoginStorage;
  final UserauthenticateBloc authenticationBloc;

  UserloginBloc(
      {required this.authenticationBloc, required this.userRepository})
      : super(UserloginInitial());

  @override
  Stream<UserloginState> mapEventToState(
    UserloginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final usertoken = await userRepository.newloginNow(
            phone: event.phone, password: event.password);

        print('this is user token in login bloc ${usertoken.runtimeType}');

        if (usertoken != 'errror') {
          // authenticationBloc.add(LoggedIn(usertoken: usertoken));
          yield LoginSucccess();
        }
        yield UserloginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
