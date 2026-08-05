import '../../Features/Draw/domain/entities/draw.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Atoms/Title.dart';
import '../Atoms/InputAtom.dart';
import '../Atoms/Button.dart';
import '../../Features/Draw/presentation/provider/draw_provider.dart';
import '../Molecules/select.dart';
import 'package:image_picker/image_picker.dart';
class ModalForm extends StatefulWidget {
  final Draw? draw;
  const ModalForm({super.key, this.draw});

  @override
  State<ModalForm> createState() => _ModalFormState();
}

class _ModalFormState extends State<ModalForm>{
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  bool _initialized = false;
  
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DrawViewModel>();

    if (!_initialized) {
      if (widget.draw != null) {
        titleController.text = widget.draw!.name;
        descriptionController.text = widget.draw!.descriptionDraw;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          vm.setCategory(widget.draw!.category);
        });
      } else {
        titleController.clear();
        descriptionController.clear();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          vm.clearSelection();
        });
      }
      _initialized = true;
    }


    return Dialog(
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 40,
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              /// TITULO
              Center(
                child: AppTitle(
                  widget.draw != null ? "Editar dibujo" : "Agregar nuevo dibujo",
                ),
              ),

              const SizedBox(height: 35),

              /// INPUT TITULO
              const Text(
                "Título del dibujo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              InputAtom(
                labelText: "Nombre del dibujo",
                value: titleController.text,
                onChanged: (value) {
                  titleController.text = value;
                },
              ),

              const SizedBox(height: 25),

              /// DESCRIPCION
              const Text(
                "Descripción",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 10),

              TextField(
                controller: descriptionController,
                maxLines: 5,

                decoration: InputDecoration(
                  hintText: "Escribe una descripción...",

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// BOTON IMAGEN
              SizedBox(
                width: double.infinity,
                height: 50,

                child: ElevatedButton(
                  onPressed: () => vm.selectImage(ImageSource.gallery),

                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),

                  child: const Text(
                    "Agregar imagen",
                  ),
                ),
              ),

              //mostrar imagen de la galeria que seleccione
              if (vm.selectedImage != null) ...[
                const SizedBox(height: 20),
                Image.file(
                  vm.selectedImage!,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ] else if (widget.draw != null && widget.draw!.imageUrl.isNotEmpty) ...[
                const SizedBox(height: 20),
                Image.network(widget.draw!.imageUrl, height:150, fit: BoxFit.cover, errorBuilder: (c,e,s) => const Icon(Icons.broken_image)),
              ],

              const SizedBox(height: 35),

              CategoryDropdown(
                onCategorySelected: (value) {
                  vm.setCategory(value); // viewmodel
                },
              ),

              /// BOTONES
              Row(
                children: [

                  Expanded(
                    child: SizedBox(
                      height: 50,

                      child: Button(
                        text: "Cancelar",
                        onPressed: () =>
                            Navigator.pop(context),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: SizedBox(
                      height: 50,

                      child: Button(
                        text: widget.draw != null ? "Actualizar" : "Agregar",
                        onPressed: () async {
                          final vmLocal = context.read<DrawViewModel>();
                          vmLocal.setDate();

                          if (vmLocal.selectedCategory == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Selecciona una categoría")),
                            );
                            return;
                          }

                          if (vmLocal.dateToday == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Error generando la fecha")),
                            );
                            return;
                          }

                          if (widget.draw == null) {
                            // crear
                            await vmLocal.addDraw(
                              Draw(
                                idDraw: 0,
                                name: titleController.text,
                                descriptionDraw: descriptionController.text,
                                imageUrl: "",
                                category: vmLocal.selectedCategory!,
                                date: vmLocal.dateToday!,
                              ),
                            );
                          } else {
                            // editar
                            final existing = widget.draw!;
                            // si no seleccionó nueva imagen, editDraw conservará la URL
                            await vmLocal.editDraw(
                              Draw(
                                idDraw: existing.idDraw,
                                name: titleController.text,
                                descriptionDraw: descriptionController.text,
                                imageUrl: existing.imageUrl,
                                category: vmLocal.selectedCategory ?? existing.category,
                                date: vmLocal.dateToday!,
                              ),
                            );
                          }

                          Navigator.pop(context);
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
