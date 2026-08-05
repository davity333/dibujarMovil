//user_mapper.dart
import '../../../domain/entities/user.dart';
import '../dto/draw_dto.dart';

class UserMapper {
  static User toEntity(UserDto dto) {
    return User(
      id: dto.id,
      firstName: dto.firstName,
      lastName: dto.lastName,
      email: dto.email,
      password: dto.password,
      rol: dto.rol,
    );
  }
}