import 'package:cryptocurrency/view_models/forget_password_view_model.dart';
import 'package:cryptocurrency/view_models/helpers/alert_dialog_helper.dart';
import 'package:cryptocurrency/view_models/helpers/snackbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../customized_widgets/text_from_widget.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Provider<ForgetPasswordScreenViewModel>(
      create: (context) => ForgetPasswordScreenViewModel(),
      builder: (context, child) => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: MyTextFromField(
                  controller:
                      Provider.of<ForgetPasswordScreenViewModel>(context)
                          .emailContoller,
                  hintText: "Email",
                  icon: Icons.email,
                  errorMessage: "Please enter your e-mail"),
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await Provider.of<ForgetPasswordScreenViewModel>(
                                context,
                                listen: false)
                            .sendPasswordResetEmail();
                    switch(authState){
                      case AuthState.successful:
                        return AlertDialogHelper.showMyDialog(
                          context: context,
                          alertDialogTitle: "Uyari",
                          alertDialogContent:
                              "We sent password reset email. Please click to link and change password",
                          onPressed: () {
                            Navigator.of(context)..pop()..pop();
                          });
                      case AuthState.userNotFound:
                        return SnackBarHelper.showSnackBar(
                            message: "User Not Found", context: context);
                      case AuthState.unkownError:
                        return SnackBarHelper.showSnackBar(
                            message: "Unknown Error", context: context);
                    }
                  }
                },
                child: Text("Reset Password"))
          ],
        ),
      ),
    );
  }
}
