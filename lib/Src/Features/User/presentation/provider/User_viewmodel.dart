//User_viewmodel.dart
import 'package:flutter/foundation.dart';

import '../../application/deleteUser_usecase.dart';
import '../../application/getUser_usecase.dart';
import '../../application/loginUser_usecase.dart';
import '../../application/registerUser_usecase.dart';
import '../../application/updateUser_usecase.dart';
import '../../domain/entities/user.dart';

class UserViewModel extends ChangeNotifier {
  final GetUserUsecase getUser;
  final RegisterUserUseCase registerUser;
  final UpdateUserusecase updateUser;
  final DeleteuserUsecase deleteUser;
  final LoginUserUseCase loginUser;

  UserViewModel(
    this.getUser,
    this.registerUser,
    this.updateUser,
    this.deleteUser,
    this.loginUser,
  );

  bool isLoading = false;
  String? errorMessage;
  User? user;

  Future<void> login(String email, String password) async {
    errorMessage = null;
    isLoading = true;
    notifyListeners();

    try {
      user = await loginUser.executeLogin(email.trim(), password);
      errorMessage = null;
    } catch (error) {
      user = null;
      errorMessage = error.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}
