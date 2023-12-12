import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:shoe_shop/config/size_config.dart';
import 'package:shoe_shop/controllers/auth_controller.dart';
import 'package:shoe_shop/models/user_model/user_model.dart';
import 'package:shoe_shop/utils/assets.dart';
import 'package:shoe_shop/utils/colors.dart';
import 'package:shoe_shop/views/screens/authentication_screens/login_screen.dart';
import 'package:shoe_shop/views/screens/profile_screen/components/tile_widget.dart';
import 'package:shoe_shop/views/widgets/alerts/delete_account_alert.dart';
import 'package:shoe_shop/views/widgets/alerts/logout_alert.dart';

class SettingsScreen extends StatelessWidget {
  final UserModel? userModel;
  const SettingsScreen({
    super.key,
    required this.userModel,
  });

  @override
  Widget build(BuildContext context) {
    log("Height: ${SizeConfig.height(context)}");

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBarColor,
          iconTheme: const IconThemeData(
            color: whiteColor,
          ),
          title: const Text(
            "Settings",
            style: TextStyle(
              color: whiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TileWidget(
              text: "Delete Account",
              trailingImg: Assets.arrowForwardHead,
              onTap: () {
                deleteAccountAlert(
                  context: context,
                  description:
                      "If you delete your account it will not retrieve are you sure?",
                  image: Assets.deleteAccountAlert,
                  heading: "Deleting Account",
                  onCancelTap: () {
                    Navigator.of(context).pop();
                  },
                  onDeleteTap: () {
                    AuthController authController = AuthController();
                    authController.deleteUserAccountAndData();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                      (route) => false,
                    );
                    Fluttertoast.showToast(msg: "Account Deletion Successful");
                  },
                );
              },
              titleTextColor: appTextColor,
              leadingImg: null,
            ),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.height12(context)),
              child: TextButton(
                  onPressed: () {
                    logoutAlertDialogBox(
                      context: context,
                      description: "You can login anytime again",
                      heading: "Are you sure you want to logout?",
                      onCancelTap: () {
                        Navigator.of(context).pop();
                      },
                      onLogoutTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                        Fluttertoast.showToast(msg: "Logout Successful");
                      },
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: SizeConfig.font14(context),
                        color: redColor,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
