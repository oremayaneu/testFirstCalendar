import 'package:cloud_firestore/cloud_firestore.dart';

//カレンダーに共有しているユーザーを追加
calendarshare({String? calendarID, String? toUID}) async {
  try {
    var calendarDocumentSnapshot = await FirebaseFirestore.instance
        .collection('calendars')
        .doc(calendarID)
        .get();

// DocumentSnapshotの存在チェックを行う
    if (!calendarDocumentSnapshot.exists) {
      return;
    }

// data()がnullを返さないように、nullチェックを行う
    final calendarData = calendarDocumentSnapshot.data();
    if (calendarData != null &&
        calendarData['watchingUserUid'].contains(toUID)) {
      print('既に追加しています。');
      // 必要であればここでGetSnackbarを使用してユーザーに通知
      return;
    } else {
      print('追加します。');

      // calendar自体の閲覧者のユーザーを追加
      await FirebaseFirestore.instance
          .collection('calendars')
          .doc(calendarID)
          .update({
        'watchingUserUid': FieldValue.arrayUnion([toUID])
      });
      //toUIDに対して、calendarIDを追加
      await FirebaseFirestore.instance
          .collection('users')
          .doc(toUID)
          .collection('WatchingCalendarList')
          .doc()
          .set({
        'calendarid': calendarID,
      });
    }
  } catch (e) {
    print('calendarshareでエラーが発生しました。$e');
  }
}

//カレンダーに共有しているユーザーを削除
calendarunshare({String? calendarID, String? toUID}) async {
  try {
    var calendarDocument = await FirebaseFirestore.instance
        .collection('calendars')
        .doc(calendarID)
        .get();

    //既に削除している場合はGetSnackbarで表示
    if (calendarDocument.data()!['watchingUserUid'].contains(toUID)) {
      //calendar自体の閲覧者のユーザーを削除
      await FirebaseFirestore.instance
          .collection('calendars')
          .doc(calendarID)
          .update({
        'watchingUserUid': FieldValue.arrayRemove([toUID])
      });

      //toUIDに対して、calendarIDを削除
      await FirebaseFirestore.instance
          .collection('users')
          .doc(toUID)
          .collection('WatchingCalendarList')
          .where('calendarid', isEqualTo: calendarID)
          .get()
          .then((snapshot) {
        snapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      });
    } else {
      print('既に削除しています。');
      return;
    }
  } catch (e) {
    print('calendarunshareでエラーが発生しました。$e');
  }
}

//共有されたカレンダーを削除

Deletesharedcalendar({String? calendarID, String? yourUID}) {
  try {
    //カレンダーの閲覧者から削除
    FirebaseFirestore.instance.collection('calendars').doc(calendarID).update({
      'watchingUserUid': FieldValue.arrayRemove([yourUID])
    });

    //自身のカレンダー一覧から削除
    FirebaseFirestore.instance
        .collection('users')
        .doc(yourUID)
        .collection('WatchingCalendarList')
        .where('calendarid', isEqualTo: calendarID)
        .get()
        .then((snapshot) {
      snapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  } catch (e) {
    print('Deletesharedcalendarでエラーが発生しました。$e');
  }
}
