// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/firestore_controller.dart';

import 'package:shoe_shop/models/user_model/user_model.dart';
import 'package:shoe_shop/utils/assets.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/edit_profiles/edit_profile_screen.dart';
import 'package:shoe_shop/views/screens/help_screen/help_screen.dart';
import 'package:shoe_shop/views/screens/profile_screen/components/info_card.dart';
import 'package:shoe_shop/views/screens/profile_screen/components/tile_widget.dart';
import 'package:shoe_shop/views/screens/settings_screen/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _userData;
  UserModel? _userModel;
  String? imageLink;
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Profile",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: whiteColor,
          ),
        ),
        actions: [_EditProfileButton(userData: _userData)],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.height12(context),
            ),
            child: Center(
              child: _userModel == null
                  ? const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : InfoCard(
                      name: name,
                      email: email,
                      imageLink: imageLink,
                    ),
            ),
          ),
          SizedBox(
            height: SizeConfig.height8(context) * 2,
          ),
          TileWidget(
            text: "Settings",
            trailingImg: Assets.arrowForwardHead,
            onTap: () async => _settingsScreen(),
            leadingImg: Assets.settingsIcon,
          ),
          TileWidget(
            text: "Help",
            trailingImg: Assets.arrowForwardHead,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => HelpScreen(
                    email: _userModel!.email,
                  ),
                ),
              );
            },
            leadingImg: Assets.helpIcon,
            titleTextColor: appTextColor,
          ),
        ],
      ),
    );
  }

  Future<void> _getData() async {
    try {
      FirestoreController firestoreController = FirestoreController();
      _userModel = await firestoreController.getUserData();
      if (_userModel != null) {
        imageLink = _userModel!.profileImage;
        name = _userModel!.businessName;
        email = _userModel!.email;
        _userData = _userModel;
        setState(() {});
        return;
      }
      // if (value == null) {
      //   userData = UserData<UserModel>;
      //   userData = _userModel;
      //   name = _userModel!.userName;
      //   email = _userModel!.email;
      //   setState(() {});
      //   return;
      // }
      // userData.data = value;
      // imageLink = _driverModel!.profileImageLink;
      // email = _driverModel!.email;
      // name = _driverModel!.name!;
      setState(() {});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> _settingsScreen() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          userModel: _userModel,
        ),
      ),
    );
  }
}

class _EditProfileButton extends StatelessWidget {
  const _EditProfileButton({
    required this.userData,
  });

  final userData;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EditProfileScreen(
              userData: userData,
            ),
          ),
        );
      },
      child: const Text(
        "Edit Profile",
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: whiteColor,
        ),
      ),
    );
  }
}
