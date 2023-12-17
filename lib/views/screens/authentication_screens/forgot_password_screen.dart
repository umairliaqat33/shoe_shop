import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/auth_controller.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/screens/authentication_screens/login_screen.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          iconTheme: const IconThemeData(
            color: whiteColor,
          ),
          title: const Text(
            "Forgot Password",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: (SizeConfig.width8(context) * 2),
            right: (SizeConfig.width8(context) * 2),
          ),
          child: SizedBox(
            height: SizeConfig.height(context) - 30,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: SizeConfig.height20(context) * 2,
                  ),
                  TextFormFieldWidget(
                    controller: _emailController,
                    validator: (value) => Utils.emailValidator(value),
                    hintText: "johndoe@gmail.com",
                    label: "Email",
                  ),
                  SizedBox(
                    height: SizeConfig.height12(context),
                  ),
                  Text(
                    "We will be sending link to email above. Click on the button below to reset your password",
                    style: TextStyle(
                      fontSize: SizeConfig.font12(context),
                      fontWeight: FontWeight.w400,
                      color: greyColor,
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Padding(
                    padding:
                        EdgeInsets.only(bottom: SizeConfig.height8(context)),
                    child: _showSpinner
                        ? Container(
                            margin: EdgeInsets.only(
                              left: SizeConfig.width12(context) * 10,
                              right: SizeConfig.width12(context) * 10,
                            ),
                            child: const CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : SizedBox(
                            width: double.infinity,
                            child: RoundedButton(
                              buttonColor: primaryColor,
                              onPressed: () => _forgotPassword(),
                              title: 'DONE',
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _forgotPassword() async {
    setState(() {
      _showSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        AuthController authController = AuthController();
        authController.resetPassword(_emailController.text);
        Fluttertoast.showToast(msg: "Email sent, please check your mail box.");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
          (route) => false,
        );
      }
    } on UserNotFoundException catch (e) {
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
