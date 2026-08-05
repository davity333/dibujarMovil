//user_repository.dart
import '../entities/user.dart';
abstract class UserRepository {
  Future<User> loginUser(String email, String password);
  Future<List<User>> getUsers();
  Future<User> createUser(User user);
  Future<User> updateUser(User user);
  Future<void> deleteUser(int idUser);
}