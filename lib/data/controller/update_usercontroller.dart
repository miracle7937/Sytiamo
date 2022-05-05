import 'package:flutter/cupertino.dart';
import 'package:sytiamo/data/http.dart';
import 'package:sytiamo/data/repository/setting_repo.dart';
import 'package:sytiamo/utils/page_state_enum.dart';

class UpdateUserController with ChangeNotifier {
  String firstname, middleName, dob, bvn, nin;
  PageState pageState = PageState.loaded;
  UpdateUserView _updateUserView;

  setView(UpdateUserView updateUserView) {
    _updateUserView = updateUserView;
  }

  setFirstName(v) {
    firstname = v;
  }

  setMiddleName(v) {
    middleName = v;
  }

  setDob(v) {
    dob = v;
  }

  setBvn(v) {
    bvn = v;
  }

  setNin(v) {
    nin = v;
  }

  updateUser(id) {
    var map = {
      "dob": dob,
      "first_name": firstname,
      "last_name": middleName,
      "bvn": bvn,
      "nin": nin
    };
    pageState = PageState.loading;
    notifyListeners();
    SettingRepo().updateCustomer(map, id).then((value) {
      if (value["status"] == true) {
        _updateUserView.onSuccess();
      } else {
        _updateUserView.onError("fal to update customer");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((e) {
      pageState = PageState.loaded;
      notifyListeners();
      print(e.toString());
      if (e is HttpException) {
        _updateUserView.onError(e.data["message"]);
      } else {
        _updateUserView.onError("error occurred");
      }
    });
  }
}

abstract class UpdateUserView {
  onSuccess();
  onError(String message);
}
