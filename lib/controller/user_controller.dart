import 'package:firstcalendar/models/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController extends GetxController {
  var isLoading = false.obs;
  var searchResults = <User>[].obs;
  var isSearching = false.obs;
  final TextEditingController searchController = TextEditingController();

  // Firestoreインスタンス
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Firestoreからユーザーを検索するメソッド
  void searchUser() async {
    String searchText = searchController.text.trim();
    if (searchText.isEmpty) return;
    isSearching(true);
    try {
      final querySnapshot = await firestore
          .collection('users') // 'users'はあなたのユーザーコレクション名に合わせてください
          .where('email', isEqualTo: searchText)
          .get();

      var users = querySnapshot.docs.map((doc) => User.fromSnap(doc)).toList();

      searchResults.assignAll(users);
    } finally {
      isSearching(false);
    }
  }

  // メールアドレスに基づいてユーザーを検索
  // void searchUserByEmail(String email) async {
  //   isLoading(true);
  //   try {
  //     final querySnapshot = await firestore
  //         .collection('users') // 'users'はあなたのユーザーコレクション名に合わせてください
  //         .where('email', isEqualTo: email)
  //         .get();

  //     var users = querySnapshot.docs.map((doc) => User.fromSnap(doc)).toList();

  //     searchResults.assignAll(users);
  //   } catch (e) {
  //     // エラーハンドリング
  //     print(e); // 開発中はエラーを確認
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  void calendarShare({required String calendarID, required String toUID}) {
    // カレンダー共有のロジックを実装
    // Firestoreまたは他のメカニズムを使用して、共有処理を実行します
  }
}
