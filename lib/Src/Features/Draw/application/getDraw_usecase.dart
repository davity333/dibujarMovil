import '../domain/entities/draw.dart';
import '../domain/repository/draw_repository.dart';

class GetDrawUseCase {
  final DrawRepository drawRepository;

  GetDrawUseCase(this.drawRepository);

  Future<List<Draw>> execute(){
    return drawRepository.getDraw();
  }
}