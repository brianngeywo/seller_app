import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seller_app/backend/models/user_model.dart';
import 'package:seller_app/local_data.dart';
import 'package:seller_app/reusables.dart';
import 'package:seller_app/sign_in.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController firstNameController = TextEditingController();

  TextEditingController lastNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 60,
          backgroundColor: Colors.blue.shade900,
          centerTitle: true,
          title: const Text(
            "Baraton Soko",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Already have an account?"),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacement(CupertinoPageRoute(builder: (context) => const SignInScreen())),
                child: const Text("Login"),
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // SizedBox(height: constraints.maxHeight * 0.2),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Welcome to Baraton Soko",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Register",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: firstNameController,
                    labelText: "   first name",
                  ),
                  CustomTextField(
                    controller: lastNameController,
                    labelText: "   last name",
                  ),
                  CustomTextField(
                    controller: usernameController,
                    labelText: "   username",
                  ),
                  CustomTextField(
                    controller: phoneController,
                    labelText: "   phone number",
                  ),
                  CustomTextField(
                    controller: emailController,
                    labelText: "   email",
                  ),
                  CustomTextField(
                    controller: passwordController,
                    labelText: "   password",
                  ),
                  const SizedBox(height: 10),
                  CustomSubmitMaterialButton(
                    onpressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => const AlertDialog(
                                content: SizedBox(
                                  width: 60,
                                  height: 60,
                                  child: CircularProgressIndicator(),
                                ),
                              ));
                      final user = UserModel(
                          id: DateTime.now().toString(),
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          email: emailController.text,
                          username: usernameController.text,
                          phoneNumber: phoneController.text,
                          password: passwordController.text);
                      createUserUseCase.call(user).whenComplete(() => Navigator.of(context)
                          .pushReplacement(CupertinoPageRoute(builder: (context) => const SignUpScreen())));
                    },
                    actionText: 'Sign up',
                  ),
                ],
              ),
            );
          },
        ));
  }
}
