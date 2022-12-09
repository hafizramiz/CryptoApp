import 'package:cryptocurrency/models/user_or_error_model.dart';
import 'package:cryptocurrency/view_models/helpers/alert_dialog_helper.dart';
import 'package:cryptocurrency/view_models/helpers/snackbar_helper.dart';
import 'package:cryptocurrency/view_models/sign_up_screen_view_model.dart';
import 'package:cryptocurrency/views/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignUpScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    return Provider<SignUpScreenViewModel>(
      create: (context) => SignUpScreenViewModel(),
      builder: (context, child) => Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Sign Up ",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text("Create Account"),
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your e-mail';
                      }
                      return null;
                    },
                    controller:
                        Provider.of<SignUpScreenViewModel>(context).emailController,
                    decoration: InputDecoration(
                        hintText: "E mail",
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      return null;
                    },
                    controller: Provider.of<SignUpScreenViewModel>(context)
                        .passwordController,
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }
                      else if(Provider.of<SignUpScreenViewModel>(context,listen: false)
                          .passwordController.text!=Provider.of<SignUpScreenViewModel>(context,listen: false)
                          .againPasswordController.text){
                        return "Sifreler eslesmiyor";
                      }
                      return null;
                    },
                    controller: Provider.of<SignUpScreenViewModel>(context).againPasswordController,
                    decoration: InputDecoration(
                        hintText: "Password Again",
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () async {
            if(_formKey.currentState!.validate()){
              /// View modeldeki metodu cagiriyorum
              UserOrError signUpResult =
              await Provider.of<SignUpScreenViewModel>(context,
                  listen: false)
                  .createAndVerifyEmailAndPassword();
              String? error = signUpResult.error;
              User? user = signUpResult.user;
              ///Hata oldugu durum
              if (user == null && error != null) {
                SnackBarHelper.showSnackBar(message: error, context: context);
                ///Hata olmadigi durum
              } else if (user != null && error == null) {
                AlertDialogHelper.showMyDialog(
                    context: context,
                    alertDialogTitle: "Uyari",
                    alertDialogContent:
                    "${user.email} isimli hesabiniza onaylama linki gonderildi. E mailinizi onayladiktan sonra tekrar giris yapsin",
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    });
              }
            }
            },
            child: Text("Sign Up"),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              TextButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              }, child: Text("Log in"))
            ],
          )
        ],
      )),
    );
  }
}
