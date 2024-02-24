import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firstcalendar/controller/caledarshare_controller.dart';
import 'package:firstcalendar/pages/search_page.dart';
import 'package:firstcalendar/utils/colors.dart';

class CalendarShare extends StatefulWidget {
  final String uid;
  const CalendarShare({super.key, required this.uid});

  @override
  State<CalendarShare> createState() => _CalendarShareState();
}

class _CalendarShareState extends State<CalendarShare> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    try {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: webBackgroundColor,
        ),
        body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(widget.uid)
              .collection('EdittingCalendarList')
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return SingleChildScrollView(
              child: snapshot.data!.docs.isEmpty
                  ? Container(
                      height: size.height,
                      decoration: const BoxDecoration(
                        color: webBackgroundColor,
                      ),
                      child: Center(
                        child: Text(
                          'カレンダーがありません',
                          style: TextStyle(fontSize: size.height * 0.03),
                        ),
                      ),
                    )
                  : Column(
                      children:
                          List.generate(snapshot.data!.docs.length, (index) {
                      return FutureBuilder(
                          future: FirebaseFirestore.instance
                              .collection('calendars')
                              .doc((snapshot.data!.docs[index]
                                  .data()['calendarid']))
                              .get(),
                          builder: (context, futuresnapshot) {
                            if (futuresnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            return Column(
                              children: [
                                Center(
                                  child: Container(
                                      width: size.width * 0.9,
                                      height: size.height * 0.9,
                                      decoration: BoxDecoration(
                                          color: webBackgroundColor,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border:
                                              Border.all(color: primaryColor)),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Center(
                                            child: Text(
                                              futuresnapshot.data!
                                                  .data()!['chilename'],
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontSize: size.height * 0.03),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Center(
                                            child: Text(
                                              '閲覧者',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: size.height * 0.02),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          SizedBox(
                                            height: size.height * 0.3,
                                            child: ListView.builder(
                                                itemCount: futuresnapshot.data!
                                                    .data()!['watchingUserUid']
                                                    .length,
                                                itemBuilder: (context, index) {
                                                  return FutureBuilder(
                                                      future: FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(futuresnapshot
                                                                      .data!
                                                                      .data()![
                                                                  'watchingUserUid']
                                                              [index])
                                                          .get(),
                                                      builder: (context,
                                                          futuresnapshot2) {
                                                        if (futuresnapshot2
                                                                .connectionState ==
                                                            ConnectionState
                                                                .waiting) {
                                                          return const Center(
                                                              child:
                                                                  CircularProgressIndicator());
                                                        }
                                                        return Column(
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.02,
                                                            ),
                                                            //ここでユーザーのアイコンを表示
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.6,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12.0),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  const SizedBox(
                                                                      width:
                                                                          8.0),
                                                                  CircleAvatar(
                                                                    backgroundImage:
                                                                        NetworkImage(futuresnapshot2
                                                                            .data!
                                                                            .data()!['photoUrl']),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          8.0),
                                                                  Text(futuresnapshot2
                                                                          .data!
                                                                          .data()!['username'] ??
                                                                      ''),
                                                                  const Spacer(),
                                                                  ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      calendarunshare(
                                                                          calendarID: futuresnapshot
                                                                              .data!
                                                                              .id,
                                                                          toUID: futuresnapshot2
                                                                              .data!
                                                                              .id);
                                                                    },
                                                                    child: const Text(
                                                                        '削除する'),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          8.0),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      });
                                                }),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Center(
                                            child: Text(
                                              'このカレンダーを共有する',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: size.height * 0.02),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          ),
                                          Expanded(
                                              child: UserSearchScreen(
                                            childName: futuresnapshot.data!
                                                .data()!['chilename'],
                                            calendarID: (snapshot
                                                .data!.docs[index]
                                                .data()['calendarid']),
                                          ))
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                              ],
                            );
                          });
                    })),
            );
          },
        ),
      );
    } catch (e) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Text('エラーが発生しました'),
        ),
      );
    }
  }
}
