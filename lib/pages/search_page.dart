import 'package:firstcalendar/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstcalendar/controller/caledarshare_controller.dart';
import 'package:firstcalendar/utils/colors.dart';
import 'package:get/get.dart';

class UserSearchScreen extends StatefulWidget {
  final String calendarID;
  final String childName;
  UserSearchScreen(
      {super.key, required this.calendarID, required this.childName});
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  // ignore: unused_field
  List<DocumentSnapshot> _searchResults = [];

  void _searchUser() async {
    String searchQuery = _searchController.text.trim();
    if (searchQuery.isNotEmpty) {
      QuerySnapshot searchQueryResult = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: searchQuery)
          .get();

      setState(() {
        _searchResults = searchQueryResult.docs;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.put(UserController());
    return Scaffold(
        backgroundColor: webBackgroundColor,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: userController.searchController,
                decoration: InputDecoration(
                  labelText: 'ユーザーを検索する',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: userController.searchUser, // 検索メソッドの呼び出し
                  ),
                ),
              ),
            ),
            Expanded(
              child: Obx(() => userController.isSearching.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: userController.searchResults.length,
                      itemBuilder: (context, index) {
                        final user = userController.searchResults[index];
                        return Container(
                          // コンテナ設定、ユーザー情報表示...
                          color: Colors.white,
                          child: Row(
                            children: [
                              const SizedBox(width: 8.0),
                              CircleAvatar(
                                backgroundImage: NetworkImage(user.photoUrl),
                              ),
                              const SizedBox(width: 8.0),
                              Text(user.username),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  Get.defaultDialog(
                                    title: 'カレンダー共有',
                                    content: Column(
                                      children: [
                                        Text(
                                            '${widget.childName}を${user.username}にカレンダーを共有しますか？'),
                                        ElevatedButton(
                                          onPressed: () {
                                            calendarshare(
                                                calendarID: widget.calendarID,
                                                toUID: user.uid);
                                            Get.back();
                                          },
                                          child: const Text('共有する'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: const Text('共有する'),
                              ),
                            ],
                          ),
                        );
                      },
                    )),
            ),
          ],
        ));
  }
}
