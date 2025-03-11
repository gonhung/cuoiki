import 'package:equatable/equatable.dart';
import 'package:flutter_amazon_clone_bloc/src/data/models/user.dart';
import 'package:flutter_amazon_clone_bloc/src/data/repositories/user_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'user_state.dart';

class UserCubit extends HydratedCubit<UserState> {
  final UserRepository userRepository;

  UserCubit(this.userRepository) : super(UserInitialS());

  void setUser(User user) {
    emit(UserLoadingS());
    try {
      saveToStorage(user);
      emit(UserSuccessS(user: user.copyWith()));
    } catch (e) {
      emit(UserErrorS(errorString: e.toString()));
    }
  }

  Future<User> getUserData() async {
    try {
      User user = await userRepository.getUserData();
      emit(UserSuccessS(user: user));
      saveToStorage(user);
      return user;
    } catch (e) {
      emit(UserErrorS(errorString: e.toString()));
      throw e;
    }
  }

  User? get currentUser {
    if (state is UserSuccessS) {
      return (state as UserSuccessS).user;
    } else {
      return null;
    }
  }

  void updateUser(User updatedUser) {
    emit(UserLoadingS());
    try {
      saveToStorage(updatedUser);
      emit(UserSuccessS(user: updatedUser.copyWith()));
    } catch (e) {
      emit(UserErrorS(errorString: e.toString()));
    }
  }

  void saveUserAddress({required String address}) async {
    try {
      User user = await userRepository.saveUserAddress(address: address);
      updateUser(user);
    } catch (e) {
      emit(UserErrorS(errorString: e.toString()));
    }
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    try {
      final user = User.fromJson(json['user']);
      return UserSuccessS(user: user);
    } catch (_) {
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    if (state is UserSuccessS) {
      return {'user': state.user.toJson()};
    } else {
      return null;
    }
  }

  void saveToStorage(User updatedUser) async {
    try {
      await HydratedBloc.storage.write('user_data', updatedUser.toJson());
    } catch (e) {
      emit(
          UserErrorS(errorString: "Failed to save user data: ${e.toString()}"));
    }
  }
}
