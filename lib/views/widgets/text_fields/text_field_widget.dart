import 'package:flutter/material.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    required this.controller,
    required this.validator,
    required this.label,
    this.hintText = "Enter a value",
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.textAlign = TextAlign.left,
    this.fieldEnabled = true,
    this.maxlines = 1,
    this.maxLength,
    this.isLabelGrey = false,
    this.autofocus = false,
    this.suffixIconFunction,
    this.suffixIcon,
    this.onChanged,
  });
  final TextEditingController controller;
  final String hintText;
  final String label;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FormFieldValidator validator;
  final TextAlign textAlign;
  final bool fieldEnabled;
  final int maxlines;
  final int? maxLength;
  final bool isLabelGrey;
  final bool autofocus;
  final Function? suffixIconFunction;
  final IconData? suffixIcon;
  final Function? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label.isEmpty
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(
                  left: 3,
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    color: isLabelGrey ? lightGrey : blackColor,
                    fontWeight: isLabelGrey ? FontWeight.w400 : null,
                    fontSize: isLabelGrey ? 12 : null,
                  ),
                ),
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
          maxLines: maxlines,
          maxLength: maxLength,
          autofocus: autofocus,
          onChanged: (value) => onChanged == null ? null : onChanged!(value),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIconFunction != null && suffixIcon != null
                ? IconButton(
                    onPressed: () => suffixIconFunction!(),
                    icon: Icon(
                      suffixIcon,
                      color: primaryColor,
                    ),
                  )
                : null,
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
                color: primaryColor.withOpacity(0.3),
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
                color: primaryColor,
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
