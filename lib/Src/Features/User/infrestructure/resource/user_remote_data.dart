//user_remote_data.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/dto/draw_dto.dart';

abstract class UserRemoteDataSource {
  Future<UserDto> loginUser(String email, String password);
  Future<List<UserDto>> getUsers();
  Future<UserDto> createUser(UserDto dto);
  Future<UserDto> updateUser(UserDto dto, int id);
  Future<void> deleteUser(int id);
}

class UserRemoteDataSourceImp implements UserRemoteDataSource {
  final http.Client client;
  // Ajustado a puerto 8080 según tu backend
final String baseUrl = "http://54.147.60.252:8080/api/v1";

  UserRemoteDataSourceImp({required this.client});

  @override
  Future<UserDto> loginUser(String email, String password) async {
    final uri = Uri.parse("$baseUrl/user/login");
    final response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return UserDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to login user');
    }
  }


  @override
  Future<List<UserDto>> getUsers() async {
    final uri = Uri.parse("$baseUrl/user/getAll");
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((e) => UserDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  @override
  Future<UserDto> createUser(UserDto dto) async {
    final uri = Uri.parse("$baseUrl/user/create");

    final response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "id": dto.id,
        "firstName": dto.firstName,
        "lastName": dto.lastName,
        "email": dto.email,
        "password": dto.password,
        "rol": dto.rol,
      }),
    );

    return UserDto.fromJson(json.decode(response.body));
  }

  @override
  Future<UserDto> updateUser(UserDto dto, int id) async {
    final uri = Uri.parse("$baseUrl/user/update/$id");

    final response = await client.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "id": dto.id,
        "firstName": dto.firstName,
        "lastName": dto.lastName,
        "email": dto.email,
        "password": dto.password,
        "rol": dto.rol,
      }),
    );

    return UserDto.fromJson(json.decode(response.body));
  }

  @override
  Future<void> deleteUser(int id) async {
    final uri = Uri.parse("$baseUrl/user/delete/$id");
    await client.delete(uri);
  }
}