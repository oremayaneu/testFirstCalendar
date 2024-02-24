import 'package:flutter/material.dart';
import 'package:firstcalendar/models/notifyListner.dart';
import 'package:provider/provider.dart';

class SearchResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<SearchModel>(
      builder: (context, model, child) {
        return model.searchList.isEmpty
            ? const Text('ユーザーは見当たりません')
            : SingleChildScrollView(
                child: Column(
                  children: List.generate(model.searchList.length, (index) {
                    return Container(
                      child: Text(model.searchList[index]['username']),
                    );
                  }),
                ),
              );
      },
    );
  }
}
