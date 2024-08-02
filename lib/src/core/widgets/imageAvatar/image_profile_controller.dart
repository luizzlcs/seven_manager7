import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageProfileController with ChangeNotifier {
  File? _imageFile;
  String message = '';
  String? _userProfileImageUrl;

  File? get imageFile => _imageFile;
  String? get userProfileImageUrl => _userProfileImageUrl;

  void clear() {
    _imageFile = null;
    _userProfileImageUrl = null;
    notifyListeners();
  }

  Future<void> pickEditAndUploadImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);
    
    if (pickedFile == null) {
      message = 'Nenhuma imagem foi selecionada';
      notifyListeners();
      return;
    }

    CroppedFile? croppedFile = await cropImage(pickedFile.path);

    if (croppedFile == null) {
      message = 'Edição de imagem cancelada';
      notifyListeners();
      return;
    }

    _imageFile = File(croppedFile.path);
    notifyListeners();

    // Upload da imagem para o Firebase Storage
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child('profile_images/$fileName.jpg');

      UploadTask uploadTask = ref.putFile(_imageFile!);

      TaskSnapshot taskSnapshot = await uploadTask;

      _userProfileImageUrl = await taskSnapshot.ref.getDownloadURL();
      
      message = "Imagem enviada com sucesso";
      notifyListeners();
    } catch (e) {
      message = "Erro ao fazer upload da imagem: $e";
      notifyListeners();
    }
  }

  Future<CroppedFile?> cropImage(String sourcePath) async {
    return await ImageCropper().cropImage(
      sourcePath: sourcePath,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Editar Imagem de Perfil',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        ),
        IOSUiSettings(
          title: 'Editar Imagem de Perfil',
        ),
      ],
    );
  }
}