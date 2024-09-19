import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seven_manager/src/core/constants/app_images.dart';
import 'package:seven_manager/src/core/injection/injection.dart';
import 'package:seven_manager/src/core/services/firebase/firebase_storage_service.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';
import 'package:seven_manager/src/core/widgets/helpers/messages.dart';
import 'options_bottom_sheet.dart';

class ImageAvatarWidget extends StatefulWidget {
  const ImageAvatarWidget({super.key, required this.imageController});

  final dynamic imageController;

  @override
  State<ImageAvatarWidget> createState() => _ImageAvatarWidgetState();
}

class _ImageAvatarWidgetState extends State<ImageAvatarWidget> with AutomaticKeepAliveClientMixin {
  final FirebaseStorageService _storage = getIt();

  @override
  void initState() {
    widget.imageController.addListener(message);
    super.initState();
  }

  void message() {
    if (widget.imageController.message.contains('Nenhuma')) {
      Messages.showError(widget.imageController.message, context);
    }
  }

  @override

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    void showBottomSheet() {
      showModalBottomSheet(
        constraints: const BoxConstraints(maxWidth: 390),
        backgroundColor: SevenManagerTheme.goldFusion,
        context: context,
        builder: (_) {
          return OptionsBottomSheet(
            onGalleryTap: () {
              Navigator.of(context).pop();
              widget.imageController.pickEditAndUploadImage(ImageSource.gallery);
            },
            onCameraTap: () {
              Navigator.of(context).pop();
              widget.imageController.pickEditAndUploadImage(ImageSource.camera);
            },
            onRemoveTap: () {
              Navigator.of(context).pop();
              widget.imageController.clearFile();
              if (widget.imageController.urlImage != null) {
                _storage.deleteImage(widget.imageController.urlImage!);
              }
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
            animation: widget.imageController,
            builder: (context, child) {
              return CircleAvatar(
                radius: 65,
                backgroundColor: Colors.grey[300],
                backgroundImage: widget.imageController.imageFile != null
                    ? FileImage(widget.imageController.imageFile!)
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
            backgroundColor: SevenManagerTheme.tealBlue,
            child: IconButton(
              onPressed: () {
                showBottomSheet();
              },
              icon: Icon(
                PhosphorIcons.pencilSimpleLine(
                  PhosphorIconsStyle.regular,
                ),
              ),
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
  
  
}
