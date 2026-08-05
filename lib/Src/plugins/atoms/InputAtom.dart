import 'package:flutter/material.dart';

class InputAtom extends StatefulWidget {
  const InputAtom({
    super.key,
    required this.labelText,
    required this.value,
    required this.onChanged,
  });

  final String labelText;
  final String value;
  final void Function(String) onChanged;

  @override
  State<InputAtom> createState() => _InputAtomState();
}

class _InputAtomState extends State<InputAtom> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: widget.labelText,
          hintText: widget.labelText,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

