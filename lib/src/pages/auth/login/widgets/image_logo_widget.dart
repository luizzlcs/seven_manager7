import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';

class ImageLogoWidget extends StatelessWidget {
  const ImageLogoWidget({
    super.key,
    required this.pathImage,
  });

  final String pathImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: CircleAvatar(
        radius: 68,
        backgroundColor: SevenManagerTheme.greenYellow,
        child: CircleAvatar(
          radius: 65,
          backgroundColor: SevenManagerTheme.greenYellow,
          backgroundImage: pathImage.contains('httpss:')
              ? NetworkImage(pathImage)
              : AssetImage(pathImage),
        ),
      ),
    );
  }
}
