//datasource/draw_repository_impl.dart
import 'package:paperinthelifedraw/Src/Features/Draw/domain/repository/draw_repository.dart';
import 'dart:convert';

import '../../domain/entities/draw.dart';
import '../models/dto/draw_dto.dart';
import '../models/mapper/draw_mapper.dart';

import '../resource/draw_remote_data.dart';


class DrawRepositoryImpl implements DrawRepository {
  final DrawRemoteDataSource remote;

  DrawRepositoryImpl({required this.remote});

  @override
  Future<List<Draw>> getDraw() async {
    final dtoList = await remote.getDraw();
    return dtoList.map((dto) => DrawMapper.toEntity(dto)).toList();
  }

  @override
  Future<Draw> createDraw(Draw draw) async {
    final dto = DrawDto(
      idDraw: draw.idDraw,
      name: draw.name,
      description: draw.descriptionDraw,
      imageUrl: draw.imageUrl,
      date: draw.date,
      category: draw.category,
      sections: [], 
    );

    final createdDto = await remote.createDraw(dto);
    return DrawMapper.toEntity(createdDto);
  }

  @override
  Future<Draw> updateDraw(Draw draw) async {
    final dto = DrawDto(
      idDraw: draw.idDraw,
      name: draw.name,
      description: draw.descriptionDraw,
      imageUrl: draw.imageUrl,
      date: draw.date,
      category: draw.category,
      sections: [],
    );

    final updatedDto = await remote.updateDraw(dto, draw.idDraw);
    return DrawMapper.toEntity(updatedDto);
  }

  @override
  Future<void> deleteDraw(int idDraw) async {
    await remote.deleteDraw(idDraw);
  }
}