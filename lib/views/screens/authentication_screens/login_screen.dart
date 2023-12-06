// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/auth_controller.dart';
import 'package:shoe_shop/utils/assets.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/screens/authentication_screens/registration_screen.dart';
import 'package:shoe_shop/views/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';
import 'package:shoe_shop/views/widgets/text_fields/password_text_field.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final AuthProvider _authProvider = AuthProvider();
  bool _showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.height10(context) * 10,
            left: SizeConfig.width8(context) * 2,
            right: SizeConfig.width8(context) * 2,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: SizeConfig.height15(context) * 10,
                    child: Image.asset(Assets.logo),
                  ),
                  SizedBox(
                    height: SizeConfig.height18(context) * 3,
                  ),
                  TextFormFieldWidget(
                    label: 'Email',
                    controller: emailController,
                    validator: (value) => Utils.emailValidator(value),
                    hintText: "Johndoe@gmail.com",
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: SizeConfig.height8(context),
                  ),
                  PasswordTextField(controller: _passController),
                  SizedBox(
                    height: SizeConfig.height12(context),
                  ),
                  _showSpinner
                      ? Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.width12(context) * 10,
                            right: SizeConfig.width12(context) * 10,
                          ),
                          child: const CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: RoundedButton(
                            buttonColor: Theme.of(context).primaryColor,
                            onPressed: () => signin(),
                            title: 'Signin',
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Don\'t have an account? '),
                      TextButton(
                        style: const ButtonStyle(
                            splashFactory: NoSplash
                                .splashFactory //removing onClick splash color
                            ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegistrationScreen(),
                            ),
                          );
                        },
                        child: const Text("SignUp"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signin() async {
    FocusManager.instance.primaryFocus?.unfocus();
    AuthController authController = AuthController();
    UserCredential? userCredential;
    setState(() {
      log("i got set to true");
      _showSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        userCredential = await authController.signIn(
          emailController.text,
          _passController.text,
        );
        if (userCredential != null) {
          log("SignIn successful");
          Fluttertoast.showToast(msg: "SignIn successful");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const BottomAppBarScreen(),
            ),
            (route) => false,
          );
        }
      }
    } on IncorrectPasswordOrUserNotFound catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    } on NoInternetException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log(e.message);
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
