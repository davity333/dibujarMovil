import '../domain/entities/user.dart';
import '../domain/repository/user_repository.dart';

class GetUserUsecase{
    final UserRepository userRepository;

    GetUserUsecase(this.userRepository);

    Future<List<User>> executeGet() async{
        return await userRepository.getUsers();
    }
}