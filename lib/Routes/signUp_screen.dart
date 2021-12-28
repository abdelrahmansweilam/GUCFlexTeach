// ignore_for_file: file_names

import '../Functions/user_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscurePassword = true;
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isObscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "GUC FlexTeach",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: 600,
        margin: EdgeInsets.only(top: 25, left: 10, right: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.red,
                  ),
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Email"),
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                        icon: Icon(_isObscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscurePassword = !_isObscurePassword;
                          });
                        }),
                  ),
                  controller: passwordController,
                  obscureText: _isObscurePassword,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    suffixIcon: IconButton(
                        icon: Icon(_isObscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscureConfirmPassword =
                                !_isObscureConfirmPassword;
                          });
                        }),
                  ),
                  controller: confirmPasswordController,
                  obscureText: _isObscureConfirmPassword,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await signup(emailController.text.trim(),
                                passwordController.text.trim())
                            .then((value) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              '/completeSignup',
                              (Route<dynamic> route) => false);
                        });
                      } catch (e) {
                        print(e.toString());
                      }
                    },
                    child: Text("Sign up")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
