import '../entities/draw.dart';

abstract class DrawRepository{
  Future<List<Draw>> getDraw();
  Future<Draw> createDraw(Draw draw);
  Future<Draw> updateDraw(Draw draw);
  Future<void> deleteDraw(int idDraw);
}