import 'dart:developer';
import 'dart:io';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_storage_service.dart';

class ImageProfileController with ChangeNotifier {
  ImageProfileController({required this.storage});

  final FirebaseStorageService storage;


  File? _imageFile;
  String? urlImage;
  String message = '';

  File? get imageFile => _imageFile;

  void clear() {
    _imageFile = null;
    notifyListeners();
  }

  void pickEditAndUploadImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: source);
   
    // Deletando imagem do Storage    
    if(urlImage != null){
      storage.deleteImage(urlImage!);
    }
    
    
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      message = '';

      

      notifyListeners();

      try {
        // Crie uma referência única para o arquivo
        DateTime now = DateTime.now();
        String formattedDate =  UtilData.obterDataDDMMAAAA(now);
        String formattedDateRemove = formattedDate.replaceAll('/','');
        String formattedTime = UtilData.obterHoraHHMMSS(now);
        String fileName = '$formattedDateRemove-$formattedTime';
        Reference ref =
            FirebaseStorage.instance.ref().child('images/$fileName');

        // Converta XFile para File
        File file = File(pickedFile.path);

        // Faça o upload da imagem
        UploadTask uploadTask = ref.putFile(file);
        // Aguarde o upload ser concluído
        TaskSnapshot taskSnapshot = await uploadTask;

        // Obtenha a URL de download da imagem
        String downloadURL = await taskSnapshot.ref.getDownloadURL();
        urlImage = downloadURL;
      } on Exception catch (e) {
        log('Erro ao fazer upload da imagem: $e');
      }
    } else {
      if (_imageFile != null) {
        message = '';
      } else {
        message = 'Nenhuma imagem foi selecionada';
      }
      notifyListeners();
    }
  }
}
