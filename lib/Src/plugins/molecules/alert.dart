import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String title;
  final String message;
  final String confirmText;

  const Alert({
    super.key,
    required this.title,
    required this.message,
    this.confirmText = 'Eliminar',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(confirmText),
        ),
      ],
    );
  }
}