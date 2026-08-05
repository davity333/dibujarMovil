import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Atoms/Title.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Features/Draw/presentation/provider/draw_provider.dart';
import '../Atoms/Button.dart';
import '../../Features/Draw/domain/entities/draw.dart';
import 'ModalForm.dart';
import 'alert.dart';

class DrawCard extends StatelessWidget {
  const DrawCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.date,
    required this.category,
    required this.idDraw,
  });

  final int idDraw;
  final String title;
  final String description;
  final String imagePath;
  final String date;
  final String category;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DrawViewModel>();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image left
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade200,
              ),
              clipBehavior: Clip.hardEdge,
              child: (imagePath.isNotEmpty && imagePath.startsWith('http'))
                  ? Image.network(imagePath, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.broken_image))
                  : (imagePath.isNotEmpty)
                      ? Image.asset(imagePath, fit: BoxFit.cover)
                      : const Center(child: Icon(Icons.image, size: 40, color: Colors.grey)),
            ),

            const SizedBox(width: 12),

            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      Text('Fecha: $date', style: Theme.of(context).textTheme.bodySmall),
                      Text(
                        'Categoría: $category',
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Actions
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Button(
                  text: 'Editar',
                  onPressed: () {
                    final vm = Provider.of<DrawViewModel>(context, listen: false);
                    vm.clearSelection();
                    showDialog(
                      context: context,
                      builder: (context) => ModalForm(
                        draw: Draw(
                          idDraw: idDraw,
                          name: title,
                          descriptionDraw: description,
                          imageUrl: imagePath,
                          date: date,
                          category: category,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 8),
                Button(
                  text: 'Eliminar',
                  onPressed: () async {
                    final shouldDelete = await showDialog<bool>(
                      context: context,
                      builder: (context) => const Alert(
                        title: 'Eliminar dibujo',
                        message: '¿Deseas eliminar este dibujo?',
                        confirmText: 'Eliminar',
                      ),
                    );

                    if (shouldDelete == true) {
                      vm.deleteDraw(idDraw);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
