import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final bool multiLines;

  const TextFormFieldWidget(
      {super.key,
      required this.name,
      required this.controller,
      required this.multiLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        validator: (value) => value!.isEmpty ? "$name can't be empty" : null,
        decoration: InputDecoration(hintText: name),
        minLines: multiLines ? 6 : 1,
        maxLines: multiLines ? 6 : 1,
      ),
    );
  }
}
