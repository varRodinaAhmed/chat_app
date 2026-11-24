import 'dart:async';

import 'package:flutter/material.dart';

class customTextfield extends StatelessWidget {
  String title;
  bool obsecure;
  TextEditingController? controller;
  void Function(String) onSubmitted;
  customTextfield({
    super.key,
    required this.title,
    required this.onSubmitted,
    this.obsecure = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
        ),
        TextFormField(
          controller: controller,
          obscureText: obsecure,
          onFieldSubmitted: onSubmitted,
          validator: (value) {
            if (value!.isEmpty) {
              return ('field is required');
            }
          },
        ),
      ],
    );
  }
}
