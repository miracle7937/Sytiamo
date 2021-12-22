import 'package:flutter/material.dart';
import 'package:sytiamo/data/local/prefs.dart';
import 'package:sytiamo/data/model/responseModel/loan_collcet_model.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/data/repository/loan_request_repository.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/page_state_enum.dart';

class ReportCollectionController extends ChangeNotifier {
  AdsView adsView;
  PageState pageState = PageState.loaded;
  List<CollectionData> get collectionList => _collectionList;
  List<CollectionData> _collectionList;

  LocationModel get locationModel => _locationModel;
  LocationModel _locationModel;
  String startDate, endDate;

  set setView(view) {
    adsView = view;
  }

  set setStartDate(v) {
    startDate = v;
  }

  set setEndData(v) {
    endDate = v;
  }

  generateReport() async {
    _locationModel = locationModel;
    int userId = await Pref.geUserID();
    print(userId);
    var map = {
      "created_user_id": userId,
      "datefrom": startDate,
      "dateto": endDate
    };
    if (startDate == null || endDate == null) {
      adsView.onError("Select dates search range");
      return;
    }
    print(map);
    // var map = {"branch_id": locationModel.id.toString(), "created_user_id": userId.toString()};
    pageState = PageState.loading;
    notifyListeners();
    RequestLoanRepo().generateReport(map).then((value) {
      if (value.status == true) {
        _collectionList = value.data;
        adsView.onSuccess("Loan request created successfully");
      } else {
        adsView.onError("error occurred");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      print(v);
      pageState = PageState.loaded;
      notifyListeners();
      adsView.onError("error occurred");
    });
  }
}
