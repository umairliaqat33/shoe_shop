import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    required this.lable,
    this.hintText = "Enter a value",
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.textAlign = TextAlign.left,
    this.fieldEnabled = true,
  });
  final TextEditingController controller;
  final String hintText;
  final String lable;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FormFieldValidator validator;
  final TextAlign textAlign;
  final bool fieldEnabled;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        lable.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(
                  left: 3,
                ),
                child: Text(lable),
              ),
        SizedBox(
          height: SizeConfig.height8(context),
        ),
        TextFormField(
          enabled: fieldEnabled,
          controller: controller,
          textInputAction: inputAction,
          keyboardType: inputType,
          textAlign: textAlign,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
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
          ),
        ),
      ],
    );
  }
}
