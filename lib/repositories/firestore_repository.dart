import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:shoe_shop/models/shoe_article_model/article_model.dart';
import 'package:shoe_shop/models/shoe_article_sold_model/shoe_article_sold_model.dart';
import 'package:shoe_shop/models/user_model/user_model.dart';
import 'package:shoe_shop/utils/collection_names.dart';
import 'package:shoe_shop/utils/exceptions.dart';
import 'package:shoe_shop/utils/strings.dart';

class FirestoreRepository {
  final User? _user = FirebaseAuth.instance.currentUser;
  void uploadUserInfo(UserModel userModel) async {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(userModel.uid)
          .set(
            userModel.toJson(),
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

  void uploadArticle(
    ArticleModel articleModel,
  ) async {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(_user!.uid)
          .collection(CollectionsNames.articleCollection)
          .doc(articleModel.articleNumber)
          .set(
            articleModel.toJson(),
          );
    } on FirebaseAuthException catch (e) {
      if (e.code == AppStrings.noInternet) {
        log(e.toString());
        throw SocketException("${e.code}${e.message}");
      } else {
        log(e.toString());
        throw UnknownException(
            "${AppStrings.wentWrong} ${e.code} ${e.message}");
      }
    }
  }

  Stream<List<ArticleModel?>> getArticleStreamList() {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .collection(CollectionsNames.articleCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ArticleModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  Stream<List<ArticleModel?>> getFilteredArticleStreamList(
    String searchValue,
  ) {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .collection(CollectionsNames.articleCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ArticleModel.fromJson(
                  doc.data(),
                ),
              )
              .where(
                (element) => element.articleNumber.contains(searchValue),
              )
              .toList(),
        );
  }

  void deleteArticle(String id) {
    CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .collection(CollectionsNames.articleCollection)
        .doc(id)
        .delete();
  }

  Future<UserModel> getUserData() async {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .get()
        .then(
          (value) => UserModel.fromJson(value.data()!),
        );
  }

  void updateArticleData(ArticleModel shoeArticleModel, String docId) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(_user!.uid)
          .collection(CollectionsNames.articleCollection)
          .doc(docId)
          .update(
            shoeArticleModel.toJson(),
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

  static User? checkUser() {
    User? user = CollectionsNames.firebaseAuth.currentUser;
    return user;
  }

  void updateUserData(UserModel userModel) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(_user!.uid)
          .update(
            userModel.toJson(),
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

  void deleteUserData() {
    CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .delete();
  }

  void uploadSaleData(
    ShoeArticleSoldModel soldShoeArticleModel,
  ) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(_user!.uid)
          .collection(CollectionsNames.soldArticleCollection)
          .doc(soldShoeArticleModel.soldArticleModel.articleNumber)
          .set(
            soldShoeArticleModel.toJson(),
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

  void updateSaleData(
    ShoeArticleSoldModel soldShoeArticleModel,
  ) {
    try {
      CollectionsNames.firestoreCollection
          .collection(CollectionsNames.usersCollection)
          .doc(_user!.uid)
          .collection(CollectionsNames.soldArticleCollection)
          .doc(soldShoeArticleModel.soldArticleModel.articleNumber)
          .update(
            soldShoeArticleModel.toJson(),
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

  void deleteSaleData(String id) {
    CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .collection(CollectionsNames.soldArticleCollection)
        .doc(id)
        .delete();
  }

  Stream<List<ShoeArticleSoldModel>?> getSoldArticleStreamList() {
    return CollectionsNames.firestoreCollection
        .collection(CollectionsNames.usersCollection)
        .doc(_user!.uid)
        .collection(CollectionsNames.soldArticleCollection)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => ShoeArticleSoldModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }
}
