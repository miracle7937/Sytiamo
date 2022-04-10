import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/authentication_controller.dart';
import 'package:sytiamo/feature/main_app/dash_board.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/images.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with AdsView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    AuthenticationController authController =
        Provider.of<AuthenticationController>(context)..setView = this;

    return SYScaffold(
        scaffoldKey: _scaffoldKey,
        state: AppState(pageState: authController.pageState),
        padding: EdgeInsets.all(25),
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Image.asset(
                            SYImages.logo,
                            fit: BoxFit.contain,
                          ),
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.height * 0.2,
                        ),
                      ),
                      Text(
                        "Agent Login",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                SYTitleForm(
                  setValue: authController.authModel.email,
                  title: "Email",
                  onChange: (v) {
                    authController.setEmail = v;
                  },
                ),
                SYTitleForm(
                  setValue: authController.authModel.password,
                  title: "Password",
                  forPassword: true,
                  onChange: (v) => authController.setPassword = v,
                ),
                SizedBox(
                  height: 20,
                ),
                SYButton(
                  disAble: !authController.isButtonValid,
                  title: "Login",
                  callback: () {
                    authController.loginUser();
                  },
                )
              ],
            ),
          );
        });
  }

  @override
  void onError(String error) {
    showSnackbar(
      error,
      context,
      key: _scaffoldKey,
    );
  }

  @override
  void onSuccess(message) async {
    await showSnackbar(
      message,
      context,
      key: _scaffoldKey,
    );
    await Future.delayed(Duration(seconds: 1));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => DashBoard()));
  }
}
