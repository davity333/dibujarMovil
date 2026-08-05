import '../domain/entities/draw.dart';
import '../domain/repository/draw_repository.dart';

class UpdateUseCase {
    final DrawRepository drawRepository;

    UpdateUseCase(this.drawRepository);

    Future<Draw> execute(Draw draw) {
        return drawRepository.updateDraw(draw);
    }
}