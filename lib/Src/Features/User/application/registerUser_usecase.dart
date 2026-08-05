import '../domain/entities/user.dart';
import '../domain/repository/user_repository.dart';

class RegisterUserUseCase{
    final UserRepository userRepository;

    RegisterUserUseCase(this.userRepository);

    Future<User> executeRegister(User user){
        return userRepository.createUser(user);
    }
}