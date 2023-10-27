import 'package:shoe_shop/models/user_model/user_model.dart';
import 'package:shoe_shop/repositories/firestore_repository.dart';

class FirestoreController {
  final FirestoreRepository _firestoreRepository = FirestoreRepository();

  void uploadUserInformation(UserModel userModel) {
    _firestoreRepository.uploadUserInfo(userModel);
  }
}
