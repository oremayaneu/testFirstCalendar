import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstcalendar/utils/colors.dart';
import 'package:firstcalendar/webPages/deleteAccount_controller.dart';

class DeleteUserSearchScreen extends StatefulWidget {
  DeleteUserSearchScreen({
    super.key,
  });
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<DeleteUserSearchScreen> {
  bool isSearching = false;
  final TextEditingController _searchController = TextEditingController();
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
    return Scaffold(
      backgroundColor: webBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'ユーザーを検索する',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchUser,
                ),
              ),
            ),
          ),
          Expanded(
            child: isSearching
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                        child: Row(
                          children: [
                            const SizedBox(width: 8.0),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  _searchResults[index]['photoUrl']),
                            ),
                            const SizedBox(width: 8.0),
                            Text(_searchResults[index]['username']),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                deleteAccount(_searchResults[index]['email']);
                              },
                              child: const Text('共有する'),
                            ),
                            const SizedBox(width: 8.0),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
