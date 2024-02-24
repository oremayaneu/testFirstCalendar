import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firstcalendar/firebase_options.dart';
import 'package:firstcalendar/models/notifyListner.dart';
import 'package:firstcalendar/pages/first_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:firstcalendar/pages/root_page.dart';
import 'package:firstcalendar/provider/usr_provider.dart';
import 'package:firstcalendar/responsive/auth_page.dart';
import 'package:firstcalendar/utils/colors.dart';
import 'package:firstcalendar/webPages/delete_accountPage.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // 縦向きのみ許可
    DeviceOrientation.portraitDown
  ]).then((_) {
    runApp(
      ChangeNotifierProvider(
        create: (context) => SearchModel(),
        child: const MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        )
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'はじめてカレンダー：β版',
          theme: ThemeData(
            textTheme:
                GoogleFonts.zenMaruGothicTextTheme(Theme.of(context).textTheme),
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 101, 174, 234)),
            useMaterial3: true,
          ),
          locale: const Locale('ja'),
          home: const FirstPage()
          /*  
        StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                if (snapshot.data!.email == 'auth@gmail.com') {
                  return const AuthPage();
                }

                return const MainPage();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return kIsWeb ? const DeleteAccountPage() : const FirstPage();
          },
        ),
     */
          //テストなう
          ),
    );
  }
}
