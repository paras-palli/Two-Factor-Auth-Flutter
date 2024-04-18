import 'package:chat_app_template/services/input_decoration.dart';
import 'package:chat_app_template/services/route_helper.dart';
import 'package:chat_app_template/views/base/common_button.dart';
import 'package:chat_app_template/views/base/custom_image.dart';
import 'package:chat_app_template/views/screens/auth_screens/signup_screen.dart';
import 'package:chat_app_template/views/screens/chat_screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  void updateEmail() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    emailController.text = localStorage.getString('email') ?? '';
    setState(() {});
  }

  @override
  void initState() {
    updateEmail();
    super.initState();
  }

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
              controller: emailController,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: ChatDecorations.kTextfieldDecoration.copyWith(
                hintText: "Enter your email",
              ),
            ),
            const SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: passwordController,
              textAlign: TextAlign.center,
              obscureText: true,
              decoration: ChatDecorations.kTextfieldDecoration.copyWith(
                hintText: 'Enter your password.',
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
                try {
                  await _auth.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text,
                  );

                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                  localStorage.setString('email', emailController.text);
                  passwordController.clear();

                  Navigator.push(
                      context, getCustomRoute(child: const ChatScreen()));
                } catch (e) {
                  Fluttertoast.showToast(
                      msg: "User Name or Password is Incorrect");
                }

                setState(() {
                  showSpinner = false;
                });
              },
              isLoading: showSpinner,
              title: 'Log In',
            ),

            // Register New User...
            const SizedBox(height: 30),
            CustomButton(
              color: Colors.transparent,
              elevation: 0,
              onTap: () {
                Navigator.push(
                  context,
                  getCustomRoute(
                    child: RegistrationScreen(),
                  ),
                );
              },
              child: const Text("Register New User"),
            ),
          ],
        ),
      ),
    );
  }
}
