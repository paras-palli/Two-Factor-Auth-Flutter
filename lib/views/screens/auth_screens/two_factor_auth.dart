import 'package:chat_app_template/generated/assets.dart';
import 'package:chat_app_template/views/screens/auth_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2fa/flutter_2fa.dart';

class AuthFactor2 extends StatelessWidget {
  const AuthFactor2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    Assets.imageAuth,
                    width: 200,
                    height: 200,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      '2 factor authentication \napp multi factor authentication',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      textAlign: TextAlign.center,
                      'Email id : aryangajakosh@gmail.com',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.blueAccent),
                        ),
                        onPressed: () => Flutter2FA().activate(
                          context: context,
                          appName:
                              "2 factor authentication app multi factor authentication",
                          email: "aryangajakosh@gmail.com",
                        ),
                        child: const Text(
                          'Activate 2FA',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                  const SizedBox(height: 30),
                  SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => Flutter2FA().verify(
                          context: context,
                          page: LoginScreen(),
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        ),
                        child: const Text(
                          'Login with 2FA',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
