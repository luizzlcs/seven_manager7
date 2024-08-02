import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageProfileController with ChangeNotifier {
  File? _imageFile;
  String message = '';

  File? get imageFile => _imageFile;

  void clear() {
    _imageFile = null;
    notifyListeners();
  }

  void pickEditAndUploadImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    } else {
      message = 'Nenhuma imagem foi selecionada';
      notifyListeners();
    }
  }
}
