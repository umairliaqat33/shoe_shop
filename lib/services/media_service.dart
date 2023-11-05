import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shoe_shop/repositories/firestore_repository.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/utils/strings.dart';

class MediaService {
  static Future<DateTime?> datePicker(
    bool isDateOfBirth,
    BuildContext context,
  ) {
    return showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: isDateOfBirth ? DateTime(1900) : DateTime.now(),
            lastDate: isDateOfBirth ? DateTime.now() : DateTime(2030))
        .then(
      (pickedDate) {
        if (pickedDate != null) {
          return pickedDate;
        } else if (pickedDate == null) {
          return null;
        }
        return null;
      },
    );
  }

  static Future<String?> uploadFile(
    PlatformFile? platformFile,
  ) async {
    if (platformFile == null) return null;
    String path = "";
    User? user = FirestoreRepository.checkUser();
    path = 'files/${user!.uid}/${DateTime.now().millisecond}';
    final file = File(platformFile.path!);
    final ref = FirebaseStorage.instance.ref().child(path);
    final TaskSnapshot taskSnapshot = await ref.putFile(file);
    return await taskSnapshot.ref.getDownloadURL();
  }

  //ignore: body_might_complete_normally_nullable
  static Future<PlatformFile?> selectFile() async {
    PermissionStatus permissionStatus = await Permission.storage.request();
    try {
      if (permissionStatus == PermissionStatus.granted) {
        PlatformFile platformFile;
        final result = await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false,
        );
        if (result == null) return null;
        platformFile = result.files.first;
        log(platformFile.path.toString());
        log(platformFile.toString());
        return platformFile;
      }
    } catch (e) {
      if (permissionStatus == PermissionStatus.denied) {
        throw StoragePermissionDenied(
          "Storage permission denied",
        );
      } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
        throw StoragePermissionDeniedPermanently(
          "Storage permission denied permanently",
        );
      } else {
        throw UnknownException("${AppStrings.wentWrong} ${log.toString()}");
      }
    }
  }
}
