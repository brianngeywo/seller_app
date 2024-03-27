import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seller_app/constants.dart';
import 'package:seller_app/reusables.dart';
import 'package:seller_app/sign_up.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              const Text("Need an account?"),
              TextButton(
                onPressed: () => Navigator.of(context)
                    .pushReplacement(CupertinoPageRoute(builder: (context) => const SignUpScreen())),
                child: const Text("Sign up"),
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: constraints.maxHeight * 0.2),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Welcome to Baraton Soko",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    const Text(
                      "Login",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: emailController,
                      labelText: '   email',
                    ),
                    CustomTextField(
                      labelText: '   password',
                      controller: passwordController,
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
                      firebaseAuth
                            .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            )
                            .whenComplete(() => Navigator.of(context)
                                .pushReplacement(CupertinoPageRoute(builder: (context) => const SignUpScreen())));
                      },
                      actionText: 'Login',
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
