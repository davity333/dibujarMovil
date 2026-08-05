import '../domain/entities/user.dart';
import '../domain/repository/user_repository.dart';


class DeleteuserUsecase {
  final UserRepository repository;
  
  DeleteuserUsecase(this.repository);

  Future<void> executeDelete(int id) async{
    return repository.deleteUser(id);
  }
}