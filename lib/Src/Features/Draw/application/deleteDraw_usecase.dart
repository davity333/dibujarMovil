import '../domain/entities/draw.dart';
import '../domain/repository/draw_repository.dart';

class DeleteUseCase {
    final DrawRepository drawRepository;

    DeleteUseCase(this.drawRepository);

    Future<void> execute(int idDraw) {
        return drawRepository.deleteDraw(idDraw);
    }
}