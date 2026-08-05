import '../domain/entities/user.dart';
import '../domain/repository/user_repository.dart';

class UpdateUserusecase{
    final UserRepository repository;

    UpdateUserusecase(this.repository);

    Future<User> executeUpdate(User user, int id) async{
        return repository.updateUser(user);
    }
}