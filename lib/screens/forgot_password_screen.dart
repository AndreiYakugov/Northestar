import 'package:flutter/material.dart';
import 'package:northstar_app/components/app_default_button.dart';
import 'package:northstar_app/screens/sign_in_screen.dart';
import 'package:northstar_app/utils/app_colors.dart';
import 'package:northstar_app/utils/app_contstants.dart';

import '../ApiPackage/ApiClient.dart';
import '../utils/helper_methods.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          forgotPasswordText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Column(
                  children: [
                    const Image(
                      image: AssetImage('assets/logo.png'),
                      width: 350,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                forgotPasswordText,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Please enter your username. You will receive a link to your email on file to create a new password.',
                textAlign: TextAlign.center,
                style:
                TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
              ),
              const SizedBox(height: 40),
              TextFormField(
                controller: userNameController,
                cursorColor: Colors.white.withOpacity(0.7),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromRGBO(73, 81, 98, 1),
                  hintText: usernameHintTxt,
                  hintStyle: TextStyle(color: AppColors.hintColor, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 16,
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                validator: (value) => value!.isEmpty ? 'Username cannot be blank' : null,
              ),
              const SizedBox(height: 20),
              AppDefaultButton(
                onPress: _handleForgotPassword,
                buttonText: sendBtnTxt,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _handleForgotPassword() async {
    if (_formKey.currentState!.validate()) {
      showLoadingDialog(context);
      dynamic res = await ApiClient().forgot(userNameController.text);
      Navigator.pop(context);

      if (res["success"]) {
        FocusScope.of(context).unfocus();
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: ${res["message"]}'),
          backgroundColor: Colors.red.shade300,
        ));
      }
    }
  }
}
