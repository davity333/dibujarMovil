//draw_dto.dart
import '../../../domain/entities/user.dart';

class UserDto {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rol;

  UserDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rol,
  });

  UserDto.fromJson(Map<String, dynamic> json)
      : id = (() {
          final v = json['idUser'];
          if (v is int) return v;
          if (v is String) return int.tryParse(v) ?? 0;
          if (v is num) return v.toInt();
          return 0;
        })(),
        firstName = (json['firstName'] ?? '').toString(),
        lastName = (json['lastName'] ?? '').toString(),
        email = (json['email'] ?? '').toString(),
        password = (json['password'] ?? '').toString(),
        rol = (json['rol'] ?? '').toString();
}