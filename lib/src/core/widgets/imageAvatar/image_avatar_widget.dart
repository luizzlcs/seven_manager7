import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';
import 'package:seven_manager/src/core/widgets/imageAvatar/image_profile_controller.dart';

import 'options_bottom_sheet.dart';

class ImageAvatarWidget extends StatefulWidget {

  const ImageAvatarWidget({super.key});

  @override
  State<ImageAvatarWidget> createState() => _ImageAvatarWidgetState();
}

class _ImageAvatarWidgetState extends State<ImageAvatarWidget> {
  final ImageProfileController _imageController = getIt();

@override
  void initState() {
    _imageController.addListener(message);
    super.initState();
  }
  
  void message(){
    Messages.showError(_imageController.message, context);
  }
  @override
  Widget build(BuildContext context) {
    
    void showBottomSheet() {
      showModalBottomSheet(
        constraints: const BoxConstraints(maxWidth: 390),
        backgroundColor: SevenManagerTheme.goldFusion,
        context: context,
        builder: (_) {
          return OptionsBottomSheet(
            onGalleryTap: () {
              Navigator.of(context).pop();
              _imageController.pickEditAndUploadImage(ImageSource.gallery);
            },
            onCameraTap: () {
              Navigator.of(context).pop();
              _imageController.pickEditAndUploadImage(ImageSource.camera);
            },
            onRemoveTap: () {
              Navigator.of(context).pop();
              _imageController.clear();
              log('Incrementar método de limparsssss URL da imagem');
            },
          );
        },
      );
    }

    return Stack(
      children: [
        CircleAvatar(
          radius: 75,
          backgroundColor: SevenManagerTheme.tealBlue,
          child: AnimatedBuilder(
            animation: _imageController,
            builder: (context, child) {
              return CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey[300],
                backgroundImage: _imageController.imageFile != null
                    ? FileImage(_imageController.imageFile!)
                    : const AssetImage(
                        AppImages.avatar,
                      ),
              );
            },
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: IconButton(
              onPressed: () {
                showBottomSheet();
              },
              icon: Icon(
                PhosphorIcons.pencilSimpleLine(
                  PhosphorIconsStyle.regular,
                ),
              ),
              color: Colors.grey[800],
            ),
          ),
        ),
      ],
    );
  }
}
