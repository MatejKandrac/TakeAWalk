import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rxdart/rxdart.dart';
import 'package:take_a_walk_app/domain/models/responses/profile_response.dart';
import 'package:take_a_walk_app/domain/repositories/users_repository.dart';
import 'package:take_a_walk_app/utils/network_image_mixin.dart';

part 'profile_state.dart';

class ProfileBloc extends Cubit<ProfileState> with NetworkImageMixin {
  final UsersRepository repository;
  final Dio dio;
  final BehaviorSubject<bool> _loadingController = BehaviorSubject();

  Stream<bool> get loadingStream => _loadingController.stream;

  FlutterSecureStorage storage = const FlutterSecureStorage();

  late ProfileResponse _data;

  ProfileBloc({required this.repository, required this.dio})
      : super(const ProfileLoadingState());

  void getProfileData() async {
    repository.getProfile().fold((error) => emit(const ProfileErrorState()),
        (data) async {
      _data = data;
      emit(ProfileDataState(profileData: data));
    });
  }

  getHeaders() => getImageHeaders(dio);

  void logOut() async {
    _loadingController.sink.add(true);
    await repository.deleteDeviceToken().fold((left) {
      _loadingController.sink.add(false);
      emit(ProfileDataState(profileData: _data, logoutState: false));
    }, (right) async {
      print("Deleted device token");
      //TODO DELETE FLOOR DATA
      await storage.deleteAll();
      print("Deleted device auth data");
      dio.options.headers.clear();
      _loadingController.sink.add(false);
      emit(ProfileDataState(profileData: _data, logoutState: true));
    });
  }
}
