import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:northstar_app/ApiPackage/ApiClient.dart';
import 'package:northstar_app/Models/signup.dart';
import 'package:northstar_app/components/app_text_field.dart';
import 'package:northstar_app/screens/sign_in_screen.dart';
import 'package:northstar_app/utils/app_contstants.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../utils/helper_methods.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController enrollerIDController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
            signUpTxt,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  // Logo
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

                  AppTextField(hintText: 'First Name', isNext: true, controller: firstNameController),
                  const SizedBox(height: 10),
                  AppTextField(hintText: 'Last Name', isNext: true, controller: lastNameController),
                  const SizedBox(height: 10),
                  AppTextField(hintText: 'Email', isNext: true, controller: emailController),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Stack(children: [
                          TextFormField(
                            enabled: false,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color.fromRGBO(73, 81, 98, 1),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 16,
                              ),
                            ),
                          ),
                          CountryCodePicker(
                            initialSelection: 'US',
                            textStyle: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          )
                        ]),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 7,
                        child: AppTextField(
                            hintText: '(201) 555-0123', isNext: true, controller: phoneNumberController),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  AppTextField(hintText: 'Enroller ID', isNext: true, controller: enrollerIDController),
                  const SizedBox(height: 10),
                  AppTextField(hintText: 'Username', isNext: true, controller: userNameController),
                  const SizedBox(height: 10),
                  AppTextField(
                    hintText: 'Password',
                    isNext: false,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.lock),
                      color: Colors.white.withOpacity(0.7),
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                    ),
                    hideText: !showPassword,
                    controller: passwordController,
                  ),

                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _handleSignup,
                    child: const Text('SUBMIT'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<void> _handleSignup() async {
      if (_formKey.currentState!.validate()) {
        showLoadingDialog(context);

        final signupForm = Signup(firstName: "", lastName: "", email: "", phoneNumber: "", enrollerID: "", userName: "", password: "");
        final pattern = RegExp(r'[^a-zA-Z0-9]');

        signupForm.firstName = firstNameController.text;
        signupForm.lastName = lastNameController.text;
        signupForm.email = emailController.text;
        signupForm.phoneNumber = phoneNumberController.text;
        signupForm.enrollerID = enrollerIDController.text;
        signupForm.userName = userNameController.text;
        signupForm.password = passwordController.text;

        if (signupForm.firstName.isEmpty || signupForm.lastName.isEmpty || signupForm.email.isEmpty ||
            signupForm.phoneNumber.isEmpty || signupForm.enrollerID.isEmpty || signupForm.userName.isEmpty ||
            signupForm.password.isEmpty) {
          showToast("Please Input All Fields");
        } else {
          if (!validator.email(signupForm.email)) {
            showToast("Please input valid email address");
          } else if (!validator.phone(signupForm.phoneNumber)) {
            showToast("Please input valid phone number");
          } else if (RegExp(r'^[0-9]').hasMatch(signupForm.userName.substring(0, 1))) {
            showToast("Please input username as alphanumeric");
          } else if (pattern.hasMatch(signupForm.userName)) {
            showToast("Please input username as alphanumeric");
          } else if (signupForm.userName.contains(" ")) {
            showToast("Please input username as alphanumeric");
          } else if (signupForm.userName.length > 20) {
            showToast("Please input username less than 20 characters");
          } else if (!isValidPassword(signupForm.password) || signupForm.password.length < 8) {
            showToast("Password should contain uppercase, lowercase, numeric, special characters and longer than 8 characters.");
          } else {
            dynamic res = await ApiClient().signup(signupForm);
            Navigator.pop(context);

            if (res["success"]) {
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
  }
}
