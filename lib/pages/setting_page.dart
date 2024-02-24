import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firstcalendar/pages/calendar_share.dart';
import 'package:firstcalendar/pages/make_calendar.dart';
import 'package:firstcalendar/pages/profile_edit_page.dart';
import 'package:firstcalendar/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Get.to(() => ProfileEditPage(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    ));
              },
              child: const Text('設定'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => CalendarShare(
                      uid: FirebaseAuth.instance.currentUser!.uid,
                    ));
              },
              child: const Text('カレンダー共有'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.to(() => const MakeCalendar());
              },
              child: const Text('カレンダー新規作成'),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
