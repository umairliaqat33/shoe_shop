// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/utils/constants.dart';
import 'package:shoe_shop/utils/utils.dart';
import 'package:shoe_shop/views/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({
    super.key,
    required this.email,
  });
  final String email;

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  bool _showSpinner = false;
  final _formKey = GlobalKey<FormState>();

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
            "Contact us",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.width15(context) + 1,
            left: SizeConfig.width15(context) + 1,
            right: SizeConfig.width15(context) + 1,
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "*Please send us a message and we will get back to you soon.*",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeConfig.font16(context),
                      color: redColor,
                    ),
                  ),
                  Text(
                    "*We will be using your mail box to send this message.*",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: SizeConfig.font16(context),
                      color: redColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.height8(context),
                  ),
                  TextFormFieldWidget(
                    controller: _subjectController,
                    validator: (value) => Utils.subjectValidator(value),
                    label: "Subjext",
                    hintText: "Your reason for message",
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.text,
                  ),
                  SizedBox(
                    height: SizeConfig.height8(context),
                  ),
                  TextFormFieldWidget(
                    controller: _phoneNumberController,
                    validator: (value) => Utils.phoneNumberValidator(value),
                    label: "Phone Number",
                    hintText: "+92---- or 031234....",
                    inputAction: TextInputAction.next,
                    inputType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: SizeConfig.height8(context),
                  ),
                  TextFormFieldWidget(
                    controller: _messageController,
                    validator: (value) => Utils.messageValidator(value),
                    label: "Message",
                    hintText: "Please enter a descriptive message.",
                    inputAction: TextInputAction.done,
                    inputType: TextInputType.text,
                    maxlines: 5,
                  ),
                  SizedBox(
                    height: SizeConfig.height15(context),
                  ),
                  _showSpinner
                      ? Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.width12(context) * 10,
                            right: SizeConfig.width12(context) * 10,
                          ),
                          child: const CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(
                            bottom: SizeConfig.height10(context),
                          ),
                          width: double.infinity,
                          child: RoundedButton(
                            buttonColor: primaryColor,
                            onPressed: () => _sendMessage(),
                            title: 'Send Message',
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

  Future<void> _sendMessage() async {
    setState(() {
      _showSpinner = true;
    });
    try {
      if (_formKey.currentState!.validate()) {
        final Email email = Email(
          body: _messageController.text,
          subject: _subjectController.text,
          recipients: [developerEmail],
          isHTML: false,
        );

        await FlutterEmailSender.send(email);
        Fluttertoast.showToast(
            msg: "Message sent we will get back to you soon");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BottomNavigationBarScreen(),
          ),
          (route) => false,
        );
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "Something went wrong please try again");
    }
    setState(() {
      _showSpinner = false;
    });
  }
}
