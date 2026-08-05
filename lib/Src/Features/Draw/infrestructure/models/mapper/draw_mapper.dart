import '../../../domain/entities/draw.dart';
import '../dto/draw_dto.dart';
class DrawMapper {
  static Draw toEntity(DrawDto dto) {
    return Draw(
      idDraw: dto.idDraw,
      name: dto.name,
      descriptionDraw: dto.description,
      imageUrl: dto.imageUrl,
      date: dto.date,
      category: dto.category,
    );
  }
}
