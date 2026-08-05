import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../models/dto/draw_dto.dart';

abstract class DrawRemoteDataSource {
  Future<List<DrawDto>> getDraw();
  Future<DrawDto> createDraw(DrawDto dto);
  Future<DrawDto> updateDraw(DrawDto dto, int id);
  Future<void> deleteDraw(int id);
}

class DrawRemoteDataSourceImpl implements DrawRemoteDataSource {
  final http.Client client;
  final String baseUrl = "http://44.208.6.86:8080/api/v1";





  DrawRemoteDataSourceImpl({required this.client});

  @override
  Future<List<DrawDto>> getDraw() async {
    final uri = Uri.parse("$baseUrl/draw/getAll");
    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((e) => DrawDto.fromJson(e as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to fetch draws');
    }
  }

  @override
  Future<DrawDto> createDraw(DrawDto dto) async {
    final uri = Uri.parse("$baseUrl/draw/create");

    final response = await client.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "idDraw": dto.idDraw,
        "name": dto.name,
        "description": dto.description,
        "image_location": dto.imageUrl,
        "date": dto.date,
        "category": dto.category,
        "sections": dto.sections,
      }),
    );

    return DrawDto.fromJson(json.decode(response.body));
  }

  @override
  Future<DrawDto> updateDraw(DrawDto dto, int id) async {
    final payload = json.encode({
      "idDraw": dto.idDraw,
      "name": dto.name,
      "description": dto.description,
      "image_location": dto.imageUrl,
      "date": dto.date,
      "category": dto.category,
      "sections": dto.sections,
    });

    final uri = Uri.parse("$baseUrl/draw/update/$id");

    if (!kReleaseMode) {
      print('PUT $uri');
      print('PUT payload: $payload');
    }

    final response = await client.put(
      uri,
      headers: {"Content-Type": "application/json"},
      body: payload,
    );

    if (!kReleaseMode) {
      print('PUT status: ${response.statusCode}');
      print('PUT response body: ${response.body}');
    }

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to update draw: ${response.statusCode} ${response.body}');
    }

    return DrawDto.fromJson(json.decode(response.body));
  }

  @override
  Future<void> deleteDraw(int id) async {
    final uri = Uri.parse("$baseUrl/draw/delete/$id");
    await client.delete(uri);
  }
}
