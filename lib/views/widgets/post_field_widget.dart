import 'package:flutter/material.dart';

class PostField extends StatelessWidget {
  const PostField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: controller,
        maxLines: null,
        minLines: 1,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      ),
    );
  }
}
