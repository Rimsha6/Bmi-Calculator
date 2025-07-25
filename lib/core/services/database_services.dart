import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/app_user.dart';

class DatabaseServices {
  final firebaseFireStore = FirebaseFirestore.instance;

  /// Add user >>>>>>>>>>>>>>>>
  registerUser(AppUser appUser) {
    print("AppUser ID is:>> ${appUser.appUserId}");
    try {
      firebaseFireStore
          .collection("AppUser")
          .doc(appUser.appUserId)
          .set(appUser.toJson());
    } catch (e) {
      print('Exception $e');
    }
  }

  /// Get user >>>>>>>>>
  Future<AppUser> getUser(String id) async {
    try {
      final snapshot = await firebaseFireStore
          .collection('AppUser')
          .doc(id)
          .get();

      if (!snapshot.exists || snapshot.data() == null) {
        throw Exception('User data not found in Firestore.');
      }

      return AppUser.fromJson(snapshot.data()!, snapshot.id);
    } catch (e) {
      print('Exception @DatabaseService/getUser: $e');
      rethrow;
    }
  }

  updateUserProfile(AppUser appUser) async {
    try {
      firebaseFireStore.collection('AppUser')
          .doc(appUser.appUserId)
          .update(appUser.toJson());
      print("fetching");
    } catch (e) {
      print('Exception@UpdateUserProfile=>$e');
    }
  }

  Future<void> updateUserData(String userId,
      double? weight,
      double? height,
      String? gender,) async {
    try {
      await firebaseFireStore
          .collection('AppUser')
          .doc(userId)
          .update({
        'gender': gender,
        'weight': weight,
        'height': height,
      });
      print("User data updated successfully");
    } catch (e) {
      print('Exception@updateUserData => $e');
    }
  }
}