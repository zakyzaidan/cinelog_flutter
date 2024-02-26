import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cinelog/features/profile/model/user_model.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileInitialEvent>(profileInitialEvent);
  }

  FutureOr<void> profileInitialEvent(
      ProfileInitialEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoadingState());
    UserModel user = await event.getUser();
    emit(ProfileLoadedSuccessState(user: user));
  }
}
