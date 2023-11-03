import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoe_shop/models/shoe_article_model/shoe_article_model.dart';
import 'package:shoe_shop/models/user_model/user_model.dart';
import 'package:shoe_shop/repositories/firestore_repository.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/utils/strings.dart';

class FirestoreController {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  void uploadUserInformation(UserModel userModel) {
    try {
      _firestoreRepository.uploadUserInfo(userModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  void uploadShoeArticle(
    ShoeArticleModel shoeArticleModel,
  ) async {
    try {
      _firestoreRepository.uploadArticle(
        shoeArticleModel,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<List<ShoeArticleModel?>> getArticleStreamList() {
    return _firestoreRepository.getArticleStreamList();
  }

  void deleteArticle(String id) {
    _firestoreRepository.deleteArticle(id);
  }

  Future<UserModel> getUserData() {
    return _firestoreRepository.getUserData();
  }
}
