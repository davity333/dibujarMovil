import '../domain/entities/user.dart';
import '../domain/repository/user_repository.dart';

class LoginUserUseCase{
    final UserRepository userRepository;

    LoginUserUseCase(this.userRepository);

    Future<User> executeLogin(String email, String password){
        return userRepository.loginUser(email, password);
    }
}