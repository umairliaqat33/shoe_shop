import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/constants/text_field_decoration.dart';
import 'package:shoe_shop/utils/utils.dart';

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _textVisible = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 3,
          ),
          child: Text('Password'),
        ),
        SizedBox(
          height: SizeConfig.width8(context),
        ),
        TextFormField(
          validator: (value) => Utils.passwordValidator(value),
          textInputAction: TextInputAction.done,
          obscureText: _textVisible,
          controller: widget.controller,
          decoration: TextFieldDecoration.kPasswordFieldDecoration.copyWith(
            hintText: 'Password mini 8 characters',
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _textVisible = !_textVisible;
                });
              },
              icon: _textVisible
                  ? Image.asset(
                      'assets/password_visibility_off.png',
                      height: 20,
                      width: 20,
                    )
                  : Image.asset(
                      'assets/password_visibility_on.png',
                      height: 20,
                      width: 20,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
