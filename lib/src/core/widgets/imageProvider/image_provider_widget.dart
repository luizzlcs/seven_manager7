import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/imageProvider/image_profile_controller.dart';

import 'modal_bottom_sheet.dart';

class ImageLogoWidget extends StatelessWidget {
  final ImageProfileController _imageController = getIt();
  ImageLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    void showBottomSheet() {
      showModalBottomSheet(
        constraints: const BoxConstraints(maxWidth: 390),
        backgroundColor: SevenManagerTheme.goldFusion,
        context: context,
        builder: (_) {
          return OpcoesBottomSheet(
            onGalleryTap: () {
              Navigator.of(context).pop();
              _imageController.pick(ImageSource.gallery);
            },
            onCameraTap: () {
              Navigator.of(context).pop();
              _imageController.pick(ImageSource.camera);
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
