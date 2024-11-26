import 'package:flutter/material.dart';
import 'package:northstar_app/components/app_default_button.dart';
import 'package:northstar_app/components/app_text_field.dart';
import 'package:northstar_app/screens/forgot_password_screen.dart';
import 'package:northstar_app/screens/home_screen.dart';
import 'package:northstar_app/screens/sign_up_screen.dart';
import 'package:northstar_app/utils/SharedPrefUtils.dart';
import 'package:northstar_app/utils/app_contstants.dart';

import '../ApiPackage/ApiClient.dart';
import '../Models/signin.dart';
import '../utils/helper_methods.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final SignIn signinForm = SignIn(username: "", password: "");
  bool rememberMe = false;
  bool showPassword = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/nothe_login.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      children: [
                        const Image(
                            image: AssetImage('assets/logo.png'),
                          width: 350,
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          welcomeText,
                          style: TextStyle(
                              fontSize: 28,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Please enter your NortheStar username and password to sign in and use the mobile application',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.7), fontSize: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    AppTextField(hintText: usernameHintTxt, isNext: true, controller: userNameController),
                    const SizedBox(height: 16),
                    AppTextField(
                      hintText: passwordHintTxt,
                      isNext: false,
                      hideText: !showPassword,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.lock,
                            color: Colors.white.withOpacity(0.7)),
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                      ),
                      controller: passwordController,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Checkbox(
                          side: const BorderSide(color: Colors.white),
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = !rememberMe;
                            });
                          },
                          checkColor: Colors.black87,
                          activeColor: Colors.white,
                        ),
                        const Text(rememberMeTxt,
                            style: TextStyle(
                              color: Colors.white,
                            )),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AppDefaultButton(
                        onPress: _handleSignIn,
                        buttonText: signInBtnTxt),
                    const SizedBox(height: 16),
                    AppDefaultButton(
                        onPress: () {
                          FocusScope.of(context).unfocus();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUpScreen()));
                        },
                        buttonText: signUpBtnTxt),
                    const SizedBox(height: 25),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => const ForgotPasswordScreen()));
                        },
                        child: const Text(
                          'FORGOT PASSWORD?',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _handleSignIn() async {
    if (_formKey.currentState!.validate()) {
      showLoadingDialog(context);

      signinForm.username = userNameController.text;
      signinForm.password = passwordController.text;

      dynamic res = await ApiClient().signin(signinForm);
      Navigator.pop(context);

      if (res["success"]) {
        SharedPrefUtils.saveStr("token", res["data"]["token"]);
        SharedPrefUtils.saveStr("fullname", '${res["data"]["user"]["first_name"]} ${res["data"]["user"]["last_name"]}');
        SharedPrefUtils.saveStr("username", res["data"]["user"]["username"]);
        SharedPrefUtils.saveStr("uuid", res["data"]["user"]["uuid"]);

        SharedPrefUtils.saveStr("usrname", rememberMe ? res["data"]["user"]["username"] : "");

        FocusScope.of(context).unfocus();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                HomeScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res["message"]}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }
}
