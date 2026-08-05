// lib/Src/Features/Draw/presentation/provider/draw_provider.dart
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../domain/entities/draw.dart';
import '../../application/getDraw_usecase.dart';
import '../../application/createDraw_usecase.dart';
import '../../application/updateDraw_usecase.dart';
import '../../application/deleteDraw_usecase.dart';

class DrawViewModel extends ChangeNotifier {
  final GetDrawUseCase getDraws;
  final CreateUseCase createDraw;
  final UpdateUseCase updateDraw;
  final DeleteUseCase deleteDrawUseCase;

  List<Draw> draws = [];
  bool isLoading = false;

  File? selectedImage;
  String? selectedImagePath;
  String? selectedCategory;
  String? dateToday;

  DrawViewModel({
    required this.getDraws,
    required this.createDraw,
    required this.updateDraw,
    required this.deleteDrawUseCase,
  });

  void setCategory(String? value) {
    selectedCategory = value;
    notifyListeners();
  }

  void setDate() {
    final now = DateTime.now();
    dateToday = "${now.year}-${now.month}-${now.day}";
    notifyListeners();
  }

  void clearSelection() {
    selectedImage = null;
    selectedImagePath = null;
    selectedCategory = null;
    dateToday = null;
    notifyListeners();
  }

  Future<void> loadDraws() async {
    isLoading = true;
    notifyListeners();

    draws = await getDraws.execute();

    isLoading = false;
    notifyListeners();
  }

  Future<void> addDraw(Draw draw) async {
    final imageUrl = await uploadImageToCloudinary();
    const placeholderUrl = "https://res.cloudinary.com/dxjzijyva/image/upload/v1734920615/Products/tpumnlfyocm8w51viddg.png";

    final newDraw = Draw(
      idDraw: draw.idDraw,
      name: draw.name,
      descriptionDraw: draw.descriptionDraw,
      imageUrl: imageUrl ?? placeholderUrl,
      date: draw.date,
      category: draw.category,
    );

    await createDraw.execute(newDraw);
    await loadDraws();
    clearSelection();
  }

  Future<void> editDraw(Draw draw) async {
    String finalUrl = draw.imageUrl;

    if (selectedImage != null) {
      final uploaded = await uploadImageToCloudinary();
      if (uploaded != null) finalUrl = uploaded;
    }

    final updated = Draw(
      idDraw: draw.idDraw,
      name: draw.name,
      descriptionDraw: draw.descriptionDraw,
      imageUrl: finalUrl,
      date: draw.date,
      category: draw.category,
    );

    if (kDebugMode) {
      print('Updating draw with id: ${updated.idDraw}');
      print('name: ${updated.name}');
      print('description: ${updated.descriptionDraw}');
      print('image_location: ${updated.imageUrl}');
      print('date: ${updated.date}');
      print('category: ${updated.category}');
    }

    await updateDraw.execute(updated);
    await loadDraws();
    clearSelection();
  }

  Future<void> deleteDraw(int id) async {
    await deleteDrawUseCase.execute(id);
    await loadDraws();
  }

  Future<void> selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      selectedImage = File(pickedFile.path);
      selectedImagePath = pickedFile.path;
      if (kDebugMode) {
        print("Imagen seleccionada: ${pickedFile.path}");
      }
    } else {
      if (kDebugMode) {
        print("No se seleccionó ninguna imagen.");
      }
    }

    notifyListeners();
  }

  Future<String?> uploadImageToCloudinary() async {
    if (selectedImage == null) return null;

    final url = 'https://api.cloudinary.com/v1_1/dxjzijyva/image/upload';
    final bytes = await selectedImage!.readAsBytes();
    final base64Image = base64Encode(bytes);

    final response = await http.post(
      Uri.parse(url),
      body: {
        "file": "data:image/png;base64,$base64Image",
        "upload_preset": "duhastmech",
        "folder": "Episodes",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["secure_url"];
    } else {
      if (kDebugMode) {
        print("Error subiendo imagen: ${response.body}");
      }
      return null;
    }
  }
}
