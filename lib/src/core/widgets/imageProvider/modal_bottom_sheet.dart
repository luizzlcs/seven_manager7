import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OpcoesBottomSheet extends StatelessWidget {
  const OpcoesBottomSheet({
    super.key,
    required this.onGalleryTap,
    required this.onCameraTap,
    required this.onRemoveTap,
  });

  final VoidCallback onGalleryTap;
  final VoidCallback onCameraTap;
  final VoidCallback onRemoveTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(83, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: ListTile(
              leading: Icon(
                  size: 40,
                  PhosphorIcons.googlePhotosLogo(PhosphorIconsStyle.regular)),
              title: const Text(
                'Galeria',
                style: TextStyle(fontSize: 22),
              ),
              onTap: onGalleryTap,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(83, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: ListTile(
              leading: Icon(
                  size: 40, PhosphorIcons.camera(PhosphorIconsStyle.regular)),
              title: const Text(
                'Câmera',
                style: TextStyle(fontSize: 22),
              ),
              onTap: onCameraTap,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(83, 255, 255, 255),
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: ListTile(
              leading: Icon(
                  size: 40, PhosphorIcons.trash(PhosphorIconsStyle.regular)),
              title: const Text(
                'Remover',
                style: TextStyle(fontSize: 22),
              ),
              onTap: onRemoveTap,
            ),
          ),
        ],
      ),
    );
  }
}
