import 'package:flutter/material.dart';

class FormSubmitBtnWidget extends StatelessWidget {
  final void Function() onPressed;
  final bool isUpdatePost;

  const FormSubmitBtnWidget(
      {super.key, required this.onPressed, required this.isUpdatePost});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(isUpdatePost ? Icons.edit : Icons.add),
      label: Text(isUpdatePost ? "Update" : "Add"),
    );
  }
}
