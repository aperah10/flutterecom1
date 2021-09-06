import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:checkreg/Backend/Respo/Prof_Address/ProfileRespo.dart';
import 'package:checkreg/Backend/models/Prof_Address/Profilem.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  // ! Adding Repo for data logic

  ProfileDataRespo profRespo = ProfileDataRespo();

  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    // ! FIRST STATE /EVENT FOR FETECH DATA
    if (event is FetchProfileEvent) {
      yield ProfileLoadingState();

      try {
        List<Profile> profData = await profRespo.getProfileData();

        // print('-----------------------------------------------------------');
        // print('productData:- $productData ');
        // print('cartData:- $cartData ');
        yield ProfileLoadedState(
          profileData: profData,
        );
      } catch (e) {
        yield ProfileErrorState(error: e.toString());
      }
    }

    /* -------------------------------------------------------------------------- */
    /*                  // ! PROFILE ADDED , ADDING  , DELETING BLOC                 */
    /* -------------------------------------------------------------------------- */
    if (event is ProfileSaveButtonEvent) {
      print('ProdAddedCartEvent Happend');
      List<Profile> prodList = await profRespo.addProfileData(
          fullname: event.fullname,
          email: event.email,
          pic: event.pic,
          gender: event.gender);

      print('RESULT  OF ADDTOCART :- $prodList');
      yield ProfileSuccessState();
    }
  }
}
