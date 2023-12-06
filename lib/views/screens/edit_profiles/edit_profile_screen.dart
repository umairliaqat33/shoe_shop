// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:developer';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';
import 'package:shoe_shop/models/user_model/user_model.dart';
import 'package:shoe_shop/services/media_service.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/views/screens/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:shoe_shop/views/widgets/image_picker_widgets/image_picker_big_widget.dart';
import 'package:shoe_shop/views/widgets/buttons/round_button.dart';
import 'package:shoe_shop/views/widgets/text_fields/text_field_widget.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel userData;
  const EditProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _businessNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  PlatformFile? _profilePlatformFile;
  final _formKey = GlobalKey<FormState>();
  String? _imageLink;
  bool _btnSpinner = false;

  @override
  void initState() {
    super.initState();
    setDataInFields();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.height12(context),
          left: (SizeConfig.width8(context) * 2),
          right: (SizeConfig.width8(context) * 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImagePickerBigWidget(
                        heading: 'Profile Photo',
                        description:
                            'add a close-up image of yourself max size is 2 MB',
                        onPressed: () async => _selectProfileImage(),
                        platformFile: _profilePlatformFile,
                        imgUrl: _imageLink,
                      ),
                      SizedBox(
                        height: SizeConfig.height12(context),
                      ),
                      TextFormFieldWidget(
                        hintText: "Business name",
                        controller: _businessNameController,
                        validator: (value) {
                          if (_businessNameController.text.isEmpty) {
                            return "Full name required";
                          }
                          return null;
                        },
                        label: 'Business Name',
                      ),
                      SizedBox(
                        height: SizeConfig.height12(context),
                      ),
                      TextFormFieldWidget(
                        fieldEnabled: false,
                        label: "Email",
                        hintText: "Email",
                        controller: _emailController,
                        validator: (value) {
                          if (_businessNameController.text.isEmpty) {
                            return "Email required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: SizeConfig.height12(context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _btnSpinner
                ? const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: EdgeInsets.only(
                        top: (SizeConfig.height20(context)),
                        // left: (SizeConfig.width8(context) * 2),
                        // right: (SizeConfig.width8(context) * 2),
                        bottom: (SizeConfig.width8(context) * 2)),
                    child: SizedBox(
                      width: double.infinity,
                      child: RoundedButton(
                        buttonColor: Theme.of(context).primaryColor,
                        onPressed: () => _updateData(),
                        title: 'Save',
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectProfileImage() async {
    try {
      _profilePlatformFile = await MediaService.selectFile();
      if (_profilePlatformFile != null) {
        log("Big Image Clicked");
        log(_profilePlatformFile!.name);
      } else {
        log("no file selected");
        return;
      }
      setState(() {});
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> _updateData() async {
    setState(() {
      _btnSpinner = true;
    });
    FirestoreController firestoreController = FirestoreController();
    try {
      if (_formKey.currentState!.validate()) {
        FocusManager.instance.primaryFocus?.unfocus();
        String? profilePicture =
            await MediaService.uploadFile(_profilePlatformFile);
        firestoreController.updateUserDats(
          UserModel(
            email: _emailController.text,
            businessName: _businessNameController.text,
            uid: widget.userData.uid,
            profileImage: profilePicture,
          ),
        );
        Fluttertoast.showToast(msg: "Data have been updated in database");
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const BottomAppBarScreen(
              screenIndex: 2,
            ),
          ),
          (route) => false,
        );
      }
    } on UnknownException catch (e) {
      Fluttertoast.showToast(msg: e.message);
      log("Data updating failed");
      Fluttertoast.showToast(msg: 'Data updating failed');
    }
    setState(() {
      _btnSpinner = false;
    });
  }

  void setDataInFields() {
    _businessNameController.text = widget.userData.businessName;
    _emailController.text = widget.userData.email;
    _imageLink = widget.userData.profileImage;
    setState(() {});
  }
}
