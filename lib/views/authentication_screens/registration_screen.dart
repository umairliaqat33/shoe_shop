// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/constants/text_field_decoration.dart';
import 'package:shoe_shop/controllers/auth_controller.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/user_model/user_model.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/authentication_screens/login_screen.dart';
import 'package:shoe_shop/views/home_screen/home_screen.dart';
import 'package:shoe_shop/views/widgets/round_button.dart';
import 'package:shoe_shop/views/widgets/text_field_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _userNameController = TextEditingController();
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
                    controller: _userNameController,
                    icon: Icons.person,
                    validator: (value) => Utils.userNameValidator(value),
                    hintText: "Enter you user name",
                    inputType: TextInputType.name,
                    inputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  TextFormFieldWidget(
                    controller: _emailController,
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
                    controller: _passController,
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
                            onPressed: () => signup(),
                            title: 'Signup',
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
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("Signin"),
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

  void signup() async {
    FocusManager.instance.primaryFocus?.unfocus();
    AuthController authController = AuthController();
    FirestoreController firestoreController = FirestoreController();
    UserCredential? userCredential;

    setState(() {
      _showSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        log("going to register");
        userCredential = await authController.signUp(
          _emailController.text,
          _passController.text,
        );
        firestoreController.uploadUserInformation(
          UserModel(
            email: _emailController.text,
            userName: _userNameController.text,
            uid: userCredential!.user?.uid,
          ),
        );
        log("Signup Successful");
        Fluttertoast.showToast(msg: 'Signup Successful');
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      }
    } on EmailAlreadyExistException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Signup failed");
      Fluttertoast.showToast(msg: 'Signup Failed');
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Signup failed");
      Fluttertoast.showToast(msg: 'Signup Failed');
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
