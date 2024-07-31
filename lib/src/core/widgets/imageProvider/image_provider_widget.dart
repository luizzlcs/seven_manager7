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
    return CircleAvatar(
      radius: 75,
      backgroundColor: SevenManagerTheme.greyColor,
      child: CircleAvatar(
        radius: 72,
        backgroundColor: SevenManagerTheme.greenYellow,
        backgroundImage: pathImage.contains('https:')
            ? NetworkImage(pathImage)
            : AssetImage(pathImage),
      ),
    );
  }
}
