import 'package:either_dart/either.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';

part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> {
  final UsersRepository repository;

  ProfileBloc(this.repository) : super(const ProfileDataState("", "", "", ""));

  void getProfileData(int userId) async {
    repository.getProfile(userId).fold(
            (error) => () {},
            (data) async {
          emit(ProfileDataState(
              data.username, data.email, data.bio, data.image));
        }
    );
  }
}
