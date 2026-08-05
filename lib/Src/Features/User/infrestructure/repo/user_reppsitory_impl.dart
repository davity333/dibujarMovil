//user_repository_impl.dart
import '../../../User/domain/repository/user_repository.dart';
import '../../domain/entities/user.dart';

import '../models/dto/draw_dto.dart';
import '../models/mapper/user_mapper.dart';

import '../resource/user_remote_data.dart';
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remote;

  //final localDataSource = UserLocalDataSource(const FlutterSecureStorage());

  UserRepositoryImpl({required this.remote});

  @override
  Future<User> loginUser(String email, String password) async {
    final userDto = await remote.loginUser(email, password);
    return UserMapper.toEntity(userDto);
  }

  @override
  Future<List<User>> getUsers() async {
    final dtoList = await remote.getUsers();
    return dtoList.map((dto) => UserMapper.toEntity(dto)).toList();
  }

  @override
  Future<User> createUser(User user) async {
    final dto = UserDto(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      password: user.password,
      rol: user.rol,
    );

    final createdDto = await remote.createUser(dto);
    return UserMapper.toEntity(createdDto);
  }

  @override
  Future<User> updateUser(User user) async {
    final dto = UserDto(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      password: user.password,
      rol: user.rol,
    );

    final updatedDto = await remote.updateUser(dto, user.id);
    return UserMapper.toEntity(updatedDto);
  }

  @override
  Future<void> deleteUser(int id) async {
    await remote.deleteUser(id);
  }
}
