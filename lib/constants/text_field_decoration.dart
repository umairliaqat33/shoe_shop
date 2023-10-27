import 'package:flutter/material.dart';

class TextFieldDecoration {
  static const kTextFieldDecoration = InputDecoration(
    hintText: 'Enter a value',
  );
  static InputDecoration kPasswordFieldDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(
      10,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(
          10,
        ),
      ),
      borderSide: BorderSide(
        color: Colors.lightBlue.withOpacity(0.3),
      ),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          10,
        ),
      ),
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          10,
        ),
      ),
      borderSide: BorderSide(
        color: Colors.blue,
      ),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          10,
        ),
      ),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          10,
        ),
      ),
      borderSide: BorderSide(
        color: Colors.red,
      ),
    ),
  );
}
