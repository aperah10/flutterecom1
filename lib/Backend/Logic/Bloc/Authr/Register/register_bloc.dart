import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkreg/Backend/Logic/Bloc/Authr/auth/userauthenticate_bloc.dart';
import 'package:checkreg/Backend/Respo/Authr/new_auth_respo/new_custlogin_respo.dart';
import 'package:equatable/equatable.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final NewCustomUserLoginRespo userRepository;
  final UserauthenticateBloc authenticationBloc;

  RegisterBloc({required this.userRepository, required this.authenticationBloc})
      : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is SignUpButtonPressed) {
      yield RegisterLoading();

      try {
        var user = await userRepository.registernow(
            email: event.email,
            phone: event.phone,
            fullname: event.fullname,
            password: event.password);
        print('this is Register token RUNTYPE : -  ${user.runtimeType}');
        if (user != 'errror') {
          // authenticationBloc.add(SignedIn(regtoken: user));
          // yield RegisterSucced(user: user);
          yield RegisterSucced();
        }
        yield RegisterInitial();
      } catch (e) {
        yield RegisterFailed(message: e.toString());
      }
    }
  }
}
