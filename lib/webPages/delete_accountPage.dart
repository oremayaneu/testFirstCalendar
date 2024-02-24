import 'package:flutter/material.dart';
import 'package:firstcalendar/pages/first_page.dart';
import 'package:firstcalendar/pages/forgotpassword_page.dart';
import 'package:get/get.dart';
import 'package:firstcalendar/widget/text_field_input.dart';

import '../utils/colors.dart';

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String show_res = '';

  @override
  void dispose() {
    super.dispose();
    show_res = '';
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウントを削除する'),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: mobileBackgroundColor,
      body: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(height: 100),
          const Text(
            'アカウントを削除する',
            style: TextStyle(fontSize: 50, color: lettercolor),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 20, top: 10),
            child: SizedBox(
              child: Image.asset(
                'assets/images/login_logo_02.png',
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                const Text(
                  'アカウント削除の手順',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lettercolor),
                ),
                const SizedBox(height: 10),
                const Text(
                  'メールアドレスとパスワードを入力すると合致していた場合に削除できます。',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lettercolor),
                ),
                const Text(
                  'メールアドレス',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lettercolor),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // 角丸の程度を指定
                    color: Colors.white,
                  ),
                  child: TextFieldInput(
                    hintText: ' メールアドレス',
                    textInputType: TextInputType.emailAddress,
                    textEditingController: _emailController,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          Center(
            child: Column(
              children: [
                const Text(
                  'パスワード',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: lettercolor),
                ),
                const SizedBox(height: 10),
                Container(
                  width: 250, //
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // 角丸の程度を指定
                    color: Colors.white,
                  ),
                  child: TextFieldInput(
                    hintText: 'パスワード',
                    textInputType: TextInputType.text,
                    textEditingController: _passwordController,
                    isPass: true,
                  ),
                ),
                (show_res != '')
                    ? Column(
                        children: [
                          const SizedBox(height: 30),
                          Text(
                            show_res,
                            style: const TextStyle(color: Colors.red),
                          ),
                          const SizedBox(height: 10),
                        ],
                      )
                    : const SizedBox(height: 0),
              ],
            ),
          ),

          const SizedBox(height: 30), //入力欄の下のスペース

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ForgotPasswordPage();
                  },
                ),
              );
            },
            child: const Text(
              'パスワードをお忘れの場合',
              style: TextStyle(fontSize: 20, color: lettercolor),
            ),
          ),
          const SizedBox(height: 5),

          const SizedBox(height: 60),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: elevatecolor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                fixedSize: const Size(230, 60), // ボタンの縦横サイズを指定
              ),
              onPressed: () {
                //   loginUser();
              },
              child: _isLoading
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    )
                  : const Text(
                      '削除',
                      style: TextStyle(
                          fontSize: 30,
                          color: buttoncolor,
                          fontWeight: FontWeight.w100),
                    ),
            ),
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
