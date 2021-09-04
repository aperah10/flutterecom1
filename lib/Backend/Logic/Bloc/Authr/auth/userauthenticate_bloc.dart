import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:localstorage/localstorage.dart';

part 'userauthenticate_event.dart';
part 'userauthenticate_state.dart';

class UserauthenticateBloc
    extends Bloc<UserauthenticateEvent, UserauthenticateState> {
  // final CustomUserLoginRespo userRepository;
  LocalStorage userLoginStorage = new LocalStorage('usertoken');

  UserauthenticateBloc() : super(UserauthenticateInitial());

  // @override
  // UserauthenticateBloc get initialState =>
  //  UserauthenticateInitial();

  @override
  Stream<UserauthenticateState> mapEventToState(
    UserauthenticateEvent event,
  ) async* {
    print(event);
    if (event is AppStarted) {
      try {
        // ? THERE ARE TWO METHOD FOR USING TOKEN :-
        // ? 1. SINGLE TOKEN :- loginhasToken();
        // ? 2. MULITPLE TOKEN :- reghasToken()=>Register, loginhasToken() => Login

        bool hasToken = await userLoginStorage.getItem('usertoken');
        // bool reghasToken = await userLoginStorage.reghasToken();
        // print('this is register token $reghasToken');
        print('this is login token $hasToken');
        // if (reghasToken == true || hasToken == true) {
        //   yield AuthenticatedAuthenticated();
        // }
        if (hasToken) {
          yield AuthenticatedAuthenticated();
        } else {
          yield AuthenticationUnauthenticated();
        }
      } catch (e) {
        print(e);
      }
    }

    /* -------------------------------------------------------------------------- */
    /*                           REGISTER TOKEN CHECKING                          */
    /* -------------------------------------------------------------------------- */

    //  2. WHEN EVENT IS LOGIN
    if (event is SignedIn) {
      yield AuthenticationLoading();
      // await userLoginStorage.regpersistToken(event.regtoken);
      await userLoginStorage.getItem(event.regtoken);
      yield AuthenticatedAuthenticated();
    }

    /* -------------------------------------------------------------------------- */
    /*                                 LOGIN BLOC                                 */
    /* -------------------------------------------------------------------------- */
    //  2. WHEN EVENT IS LOGIN
    if (event is LoggedIn) {
      yield AuthenticationLoading();
      // await userRepository.loginpersistToken(event.usertoken);
      await userLoginStorage.getItem(event.usertoken);
      yield AuthenticatedAuthenticated();
    }

    // 3. WHEN EVENT IS LOGGOUT
    if (event is LoggedOut) {
      yield AuthenticationLoading();
      // await userRepository.logindeleteToken();
      await userLoginStorage.deleteItem('usertoken');
      yield AuthenticationUnauthenticated();
    }
  }
}

// try {
//   bool reghasToken = await userLoginStorage.reghasToken();
// print('this is register token $reghasToken');

// if (reghasToken) {
// yield AuthenticatedAuthenticated();
// }
//   // bool hasToken = await userRepository.loginhasToken();
//  else {
//     yield AuthenticationUnauthenticated();
//   }
// } catch (e) {
//   print(e);
// }
