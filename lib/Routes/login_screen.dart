import 'package:flutter/material.dart';

import '../Backend/user_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscurePassword = true;

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
          child: Column(
            children: [
              Text(
                "Log in",
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
              ElevatedButton(
                onPressed: () async {
                  try {
                    await login(emailController.text.trim(),
                            passwordController.text.trim())
                        .then((value) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/', (Route<dynamic> route) => false);
                    });
                  } catch (e) {
                    List l = e.toString().split("]");
                    String errorMessage = l[1];

                    ScaffoldMessenger.of(context)
                        .showSnackBar(createSnackBar(errorMessage));
                  }
                },
                child: Text("Log in"),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/register');
                  },
                  child: Text("Register"))
            ],
          ),
        ),
      ),
    );
  }

  // void login() async {
  //   var email = emailController.text.trim();
  //   var password = passwordController.text.trim();
  //   UserCredential authResult;
  //   authResult = await authenticationInstance.signInWithEmailAndPassword(
  //     email: email,
  //     password: password,
  //   );
  // }
}
