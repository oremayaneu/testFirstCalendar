import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> deleteAccount(String email) async {
  // FirestoreからUIDを検索
  String? uid;
  await FirebaseFirestore.instance
      .collection('users')
      .where('email', isEqualTo: email)
      .get()
      .then((querySnapshot) {
    if (querySnapshot.docs.isNotEmpty) {
      uid = querySnapshot.docs.first.id; // ユーザーのUIDを取得
    }
  });

  // UIDが見つかった場合、ユーザー情報を削除
  if (uid != null) {
    // Firestoreからユーザー情報を削除
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .delete()
        .then((value) => print('User Deleted from Firestore'))
        .catchError(
            (error) => print('Failed to delete user from Firestore: $error'));

    // FirebaseAuthからユーザー情報を削除
    try {
      // 現在のユーザーを取得
      User? currentUser = FirebaseAuth.instance.currentUser;

      // メールアドレスが一致する場合にのみ削除を実行
      if (currentUser != null && currentUser.email == email) {
        await currentUser.delete();
        print('Firebase Auth user deleted');
      } else {
        print('No matching user found for that email');
      }
    } catch (error) {
      print('Failed to delete Firebase Auth user: $error');
    }
  } else {
    print('No user found for that email');
  }
}
