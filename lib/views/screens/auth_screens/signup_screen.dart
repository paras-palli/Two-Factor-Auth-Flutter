import 'package:chat_app_template/services/input_decoration.dart';
import 'package:chat_app_template/services/route_helper.dart';
import 'package:chat_app_template/views/base/common_button.dart';
import 'package:chat_app_template/views/base/custom_image.dart';
import 'package:chat_app_template/views/screens/chat_screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registrationScreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = "";
  String password = "";
  String name = "";
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Flexible(
              child: CustomImage(path: Assets.imageAuth),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                name = value;
              },
              decoration: ChatDecorations.kTextfieldDecoration.copyWith(
                hintText: 'Enter your name',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                email = value;
              },
              decoration: ChatDecorations.kTextfieldDecoration.copyWith(
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: ChatDecorations.kTextfieldDecoration.copyWith(
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(
              height: 24.0,
            ),
            CustomButton(
              onTap: () async {
                setState(() {
                  showSpinner = true;
                });

                // Register the User...
                try {
                  await _auth.createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );

                  var sharedPreferences = Get.find<SharedPreferences>();
                  sharedPreferences.setString('name', name.trim());

                  Navigator.pushAndRemoveUntil(
                    context,
                    getCustomRoute(child: ChatScreen()),
                    (route) => false,
                  );

                  setState(() {
                    showSpinner = false;
                  });
                } catch (e) {
                  print(e);
                }

                setState(() {
                  showSpinner = false;
                });
              },
              isLoading: showSpinner,
              title: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
