import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:provider/provider.dart';
import '../../Features/Draw/presentation/provider/draw_provider.dart';
class CategoryDropdown extends StatefulWidget {
  final void Function(String?) onCategorySelected;

  const CategoryDropdown({
    super.key,
    required this.onCategorySelected,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  final List<String> categories = [
    'Texas Chainsaw Massacre',
    'Escuela',
    'Parodia',
    'Metal',
  ];
  
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
      final vm = context.watch<DrawViewModel>();
    return Column(
      children: [
        Text(vm.selectedCategory ?? "No se ha seleccionado ninguna categoría"),
        //space
        const SizedBox(height: 20),
        DropdownButtonFormField2<String>(
          isExpanded: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      hint: const Text(
        'Selecciona una categoría',
        style: TextStyle(fontSize: 14),
      ),
      items: categories
          .map(
            (item) => DropdownItem<String>(
              value: item,
              child: Text(item, style: const TextStyle(fontSize: 14)),
            ),
          )
          .toList(),
      validator: (value) {
        if (value == null) {
          return 'Selecciona una categoría.';
        }
        return null;
      },
      onChanged: (value) {
        setState(() {
          selectedCategory = value;
        });

        widget.onCategorySelected(value);
      },
    )
      ],
    );
  }
}
