// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/constants/text_field_decoration.dart';
import 'package:shoe_shop/controllers/auth_controller.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/authentication_screens/registration_screen.dart';
import 'package:shoe_shop/views/home_screen/home_screen.dart';
import 'package:shoe_shop/views/widgets/round_button.dart';
import 'package:shoe_shop/views/widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final AuthProvider _authProvider = AuthProvider();
  bool _showSpinner = false;
  bool _textVisible = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(
            top: 100,
            left: 16,
            right: 16,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 150.0,
                    child: Image.asset('assets/logo.png'),
                  ),
                  const SizedBox(
                    height: 48.0,
                  ),
                  TextFormFieldWidget(
                    controller: emailController,
                    icon: Icons.email,
                    validator: (value) => Utils.emailValidator(value),
                    hintText: "Enter you email",
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormField(
                    validator: (value) => Utils.passwordValidator(value),
                    textInputAction: TextInputAction.done,
                    obscureText: _textVisible,
                    controller: passController,
                    decoration:
                        TextFieldDecoration.kPasswordFieldDecoration.copyWith(
                      hintText: 'Enter Your Password',
                      icon: const Icon(Icons.vpn_key),
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
                  const SizedBox(
                    height: 24.0,
                  ),
                  _showSpinner
                      ? Container(
                          margin: const EdgeInsets.only(
                            left: 120,
                            right: 120,
                          ),
                          child: const CircularProgressIndicator(),
                        )
                      : SizedBox(
                          width: double.infinity,
                          child: RoundedButton(
                            color: Theme.of(context).primaryColor,
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
          passController.text,
        );
        if (userCredential != null) {
          log("SignIn successful");
          Fluttertoast.showToast(msg: "SignIn successful");
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
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
