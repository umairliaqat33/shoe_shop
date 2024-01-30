import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/models/shoe_article_sold_model/shoe_article_sold_model.dart';
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

  void uploadArticle(
    ArticleModel articleModel,
  ) async {
    try {
      _firestoreRepository.uploadArticle(
        articleModel,
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

  Stream<List<ArticleModel?>> getArticleStreamList() {
    return _firestoreRepository.getArticleStreamList();
  }

  Stream<List<ArticleModel?>> getSearchResultArticleStreamList(
      String searchValue) {
    return _firestoreRepository.getFilteredArticleStreamList(searchValue);
  }

  void deleteArticle(String id) {
    _firestoreRepository.deleteArticle(id);
  }

  Future<UserModel> getUserData() {
    return _firestoreRepository.getUserData();
  }

  void updateShoeArticle(
    ArticleModel shoeArticleModel,
    String docId,
  ) async {
    try {
      _firestoreRepository.updateArticleData(
        shoeArticleModel,
        docId,
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

  void updateUserDats(
    UserModel userModel,
  ) async {
    try {
      _firestoreRepository.updateUserData(
        userModel,
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

  void uploadArticleSaleData(
    ShoeArticleSoldModel soldShoeArticleModel,
  ) async {
    try {
      _firestoreRepository.uploadSaleData(soldShoeArticleModel);
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        throw SocketException("${e.code}${e.message}");
      } else {
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }
}
