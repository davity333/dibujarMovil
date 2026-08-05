import '../domain/entities/draw.dart';
import '../domain/repository/draw_repository.dart';

class CreateUseCase {
    final DrawRepository drawRepository;

    CreateUseCase(this.drawRepository);

    Future<Draw> execute(Draw draw){
        return drawRepository.createDraw(draw);
    }
}