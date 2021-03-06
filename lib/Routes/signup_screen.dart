import 'package:flutter/material.dart';

import '../Backend/user_auth.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscurePassword = true;
  TextEditingController confirmPasswordController = TextEditingController();
  bool _isObscureConfirmPassword = true;
  bool error = false;
  late String errorMessage;

  @override
  Widget build(BuildContext context) {
    SnackBar createSnackBar(String message) {
      return SnackBar(
        backgroundColor: Colors.red,
        content: Text(message),
      );
    }

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
                        error = false;
                        if (emailController.text == '') {
                          setState(() {
                            error = true;
                            errorMessage = "Email can not be empty";
                          });
                        } else {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            setState(() {
                              error = true;
                              errorMessage = "Passwords don't match";
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(createSnackBar(errorMessage));
                            });
                          }
                        }
                        if (!error) {
                          await signup(emailController.text.trim(),
                                  passwordController.text)
                              .then((value) {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/completeSignup',
                                (Route<dynamic> route) => false);
                          });
                        }
                      } catch (e) {
                        print("Caught");

                        error = true;
                        List l = e.toString().split("]");
                        errorMessage = l[1];

                        ScaffoldMessenger.of(context)
                            .showSnackBar(createSnackBar(errorMessage));
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
