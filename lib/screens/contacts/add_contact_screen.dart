import 'package:flutter/material.dart';
import 'package:northstar_app/Models/prosignup.dart';
import 'package:northstar_app/components/app_avatar.dart';
import 'package:northstar_app/components/app_text_field.dart';
import 'package:regexed_validator/regexed_validator.dart';

import '../../ApiPackage/ApiClient.dart';
import '../../utils/helper_methods.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final Prosignup signupForm = Prosignup(firstName: "", lastName: "", phoneNumber: "", email: "", sadrline1: "", sadrline2: "", city: "", state: "");
  final pattern = RegExp(r'[^a-zA-Z0-9]');
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController sadrline1Controller = TextEditingController();
  TextEditingController sadrline2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Contact"),
          actions: [
            TextButton(
                onPressed: _handleSubmit,
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AppAvatar(
                    size: 120,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    child: Column(
                      children: [
                        AppTextField(
                          controller: firstNameController,
                          hintText: "First Name",
                          isNext: true,
                          prefix: const Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: lastNameController,
                          hintText: "Last Name",
                          isNext: true,
                          prefix: Icon(
                            Icons.person,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: phoneNumberController,
                          hintText: "Phone Number",
                          isNext: true,
                          prefix: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: emailController,
                          hintText: "User Email",
                          isNext: true,
                          prefix: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: sadrline1Controller,
                          hintText: "Shipping Address Line 1",
                          isNext: true,
                          prefix: Icon(
                            Icons.local_shipping,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: sadrline2Controller,
                          hintText: "Shipping Address Line 2",
                          isNext: true,
                          prefix: Icon(
                            Icons.local_shipping,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: cityController,
                          hintText: "City",
                          isNext: true,
                          prefix: Icon(
                            Icons.location_city,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        AppTextField(
                          controller: stateController,
                          hintText: "State",
                          isNext: false,
                          prefix: Icon(
                            Icons.location_city,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      showLoadingDialog(context);

      signupForm.firstName = firstNameController.text;
      signupForm.lastName = lastNameController.text;
      signupForm.phoneNumber = phoneNumberController.text;
      signupForm.email = emailController.text;
      signupForm.sadrline1 = sadrline1Controller.text;
      signupForm.sadrline2 = sadrline2Controller.text;
      signupForm.city = cityController.text;
      signupForm.state = stateController.text;

      if (signupForm.firstName.isEmpty || signupForm.lastName.isEmpty ||
      signupForm.phoneNumber.isEmpty || signupForm.email.isEmpty || signupForm.sadrline1.isEmpty || signupForm.sadrline2.isEmpty ||
          signupForm.city.isEmpty || signupForm.state.isEmpty) {
        showToast("Please Input All Fields");
      } else {
        if (!validator.email(signupForm.email)) {
          showToast("Please input valid email address");
        } else if (!validator.phone(signupForm.phoneNumber)) {
          showToast("Please input valid phone number");
        }else {
          dynamic res = await ApiClient().prosignup(signupForm);
          Navigator.pop(context);

          if (res["success"]) {
            Navigator.of(context).pop();
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
