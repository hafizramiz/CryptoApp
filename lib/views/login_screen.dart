import 'package:cryptocurrency/models/user_or_error_model.dart';
import 'package:cryptocurrency/view_models/helpers/snackbar_helper.dart';
import 'package:cryptocurrency/view_models/login_screen_view_model.dart';
import 'package:cryptocurrency/views/forget_password_screen.dart';
import 'package:cryptocurrency/views/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../customized_widgets/text_from_widget.dart';
import 'bottom_nav_bar/bottom_nav_bar_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Provider(
      create: (context) => LoginScreenViewModel(),
      builder: (context, child) => Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Log in ",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text("Welcome to App"),
          Form(
            key: _formKey,
            child: Column(
              children: [
                MyTextFromField(
                  controller: Provider.of<LoginScreenViewModel>(context)
                      .emailController,
                  icon: Icons.person,
                  hintText: "E mail",
                  errorMessage: "Please enter your e-mail",
                ),
                MyTextFromField(
                  controller: Provider.of<LoginScreenViewModel>(context)
                      .passwordController,
                  errorMessage: "Please enter your password",
                  hintText: "Password",
                  icon: Icons.lock,
                ),
              ],
            ),
          ),
          TextButton(onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPasswordScreen()));
          }, child: Text("Forget password ?")),

          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                UserOrError signInResult =
                    await Provider.of<LoginScreenViewModel>(context,
                            listen: false)
                        .signInWithEmailAndPassword();
                User? user = signInResult.user;
                String? error = signInResult.error;
                if (user == null && error != null) {
                  SnackBarHelper.showSnackBar(message: error, context: context);
                } else if (user != null && error == null) {
                  if (user.emailVerified == false) {
                    await Provider.of<LoginScreenViewModel>(context,
                            listen: false)
                        .signOut();
                    SnackBarHelper.showSnackBar(
                        message: "Please verify your email adress",
                        context: context);
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => BottomNavBarScreen()));
                  }
                } else {
                  SnackBarHelper.showSnackBar(
                      message: "Unkown Error", context: context);
                }
              }
            },
            child: Text("Log In"),
          ),
          Text("or"),
          ElevatedButton(
            onPressed: () {
              ///
            },
            child: Text("Continue with Google"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Dont have an account?"),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text("Sign Up"))
            ],
          )
        ],
      )),
    );
  }
}
