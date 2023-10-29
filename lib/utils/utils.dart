import 'package:shoe_shop/utils/constants.dart';

class Utils {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Email required";
    } else if (!RegExp(emailPatter).hasMatch(value)) {
      return "Enter a valid email";
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Password required";
    } else if (value.length < 8) {
      return "Minimum 8 character required in password";
    } else {
      return null;
    }
  }

  static String? userNameValidator(String? value) {
    if (value!.isEmpty) {
      return "User name required";
    } else {
      return null;
    }
  }

  static String? articleValidator(String? value) {
    if (value!.isEmpty) {
      return "User name required";
    } else {
      return null;
    }
  }
}
