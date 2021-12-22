import 'package:flutter/material.dart';
import 'package:sytiamo/data/model/setModel/model.dart';
import 'package:sytiamo/data/repository/auth_repo.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/page_state_enum.dart';

class AuthenticationController extends ChangeNotifier {
  AdsView adsView;
  AuthModel authModel = AuthModel();
  PageState pageState = PageState.loaded;
  bool isButtonValid = false;
  set setView(view) {
    adsView = view;
  }

  set setPassword(String password) {
    authModel.password = password;
    isButtonValid = isValid();
    if (password.isNotEmpty) {
      notifyListeners();
    }
  }

  set setEmail(String email) {
    authModel.email = email;
    isButtonValid = isValid();
    if (email.isNotEmpty) {
      notifyListeners();
    }
  }

  loginUser() {
    pageState = PageState.loading;
    notifyListeners();
    AuthRepository().login(authModel).then((value) {
      if (value.user == null) {
        adsView.onError("This credential is unauthorised ");
      } else {
        adsView.onSuccess("User authentication is successful");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();
      adsView.onError(v.toString());
    });
  }

  bool isValid() {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(authModel.email ?? "");
    bool isPassWord = (authModel.password?.length ?? 0) > 4;

    if (emailValid == true && isPassWord == true) {
      return true;
    } else {
      return false;
    }
  }
}
