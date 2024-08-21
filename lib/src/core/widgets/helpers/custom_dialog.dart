import 'package:flutter/material.dart';
import 'package:seven_manager/src/core/theme/seven_manager_theme.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final VoidCallback onConfirm;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.icon,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: SevenManagerTheme.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 4,
      title: Row(
        children: [
           Icon(
            icon,
            size: 50,
            color: SevenManagerTheme.tealBlue,
          ),
          const SizedBox(
             width:8 ,
          ),
          Text(
            title,
            style: const TextStyle(
              color: SevenManagerTheme.tealBlue,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      content: Text(
        content,
        style: const TextStyle(
          color: SevenManagerTheme.tealBlue,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          child: const Text(
            'Não',
            style: TextStyle(
              color: SevenManagerTheme.tealBlue,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        TextButton(
          child: const Text(
            'Sim',
            style: TextStyle(
              color: SevenManagerTheme.redOrange,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
        )
      ],
    );
  }
}

void showPresentDialog(
    {required BuildContext context,
    required String title,
    required String content,
    required IconData icon,
    required VoidCallback onConfirm}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomDialog(
        title: title,
        content: content,
        icon: icon,
        onConfirm: onConfirm,
      );
    },
  );
}
