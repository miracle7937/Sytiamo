import 'package:flutter/cupertino.dart';
import 'package:sytiamo/data/http.dart';
import 'package:sytiamo/data/local/prefs.dart';
import 'package:sytiamo/data/model/responseModel/customer_search_response.dart';
import 'package:sytiamo/data/model/responseModel/loan_product_response.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/data/model/setModel/loan_creation_model.dart';
import 'package:sytiamo/data/repository/loan_request_repository.dart';
import 'package:sytiamo/data/repository/setting_repo.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/page_state_enum.dart';
import 'package:sytiamo/utils/string_helper.dart';

class SettingsController extends ChangeNotifier {
  AdsView adsView;
  UserSearchView userSearchView;
  LoanCreationModel loanCreationModel = LoanCreationModel();
  List<String> errorForm = [];
  List<CustomerModel> get listOfCustomer => _queryListOfCustomer;
  List<CustomerModel> _listOfCustomer;
  List<CustomerModel> _queryListOfCustomer;

  CustomerModel get selectedCustomer => _selectedCustomer;
  CustomerModel _selectedCustomer;

  String loanAmount, amountToPay;

  LoanModel get selectedLoanModel => _selectedLoanModel;
  LoanModel _selectedLoanModel;

  LoanProduct get loanProduct => _loanProduct;
  LoanProduct _loanProduct;

  LocationResponse get locationResponse => _locationResponse;
  LocationResponse _locationResponse;

  PageState pageState = PageState.loaded;

  LocationModel get selectedLocationModel => _selectedLocationModel;
  LocationModel _selectedLocationModel;

  List<LocationModel> get locations => _locations;
  List<LocationModel> _locations;

  String title, message;
  //{index, week}
  List<Map<int, int>> durationsToSelect = [
    {1: 4},
    {2: 8},
    {3: 12},
    {4: 16}
  ];
  Map<int, int> durationValue;

  // set selectedCustomer(v) {
  //   _selectedCustomer = v;
  //   // notifyListeners();
  // }

  selectedCustomerPage(v) {
    _selectedCustomer = v;
    notifyListeners();
  }

  set setView(view) {
    adsView = view;
  }

  set setUserSearchView(view) {
    userSearchView = view;
  }

  onSelectLocation(v) {
    _selectedLocationModel = v;
    notifyListeners();
  }

  onSelectLocationQueryPage(LocationModel v) {
    _selectedLocationModel = v;
    searchUserBuMarketID(locationId: v.id);
  }

  queryUser(String value) {
    if (value.trim().isNotEmpty) {
      _queryListOfCustomer = _listOfCustomer
          .where((element) =>
              element.firstName
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()) ||
              element.middleName
                  .toString()
                  .toLowerCase()
                  .contains(value.toLowerCase()))
          .toList();
    } else {
      _queryListOfCustomer = _listOfCustomer;
    }
    notifyListeners();
  }

  searchUserBuMarketID({var locationId}) {
    // Map map = {"location_id": 50};
    Map map = {"location_id": locationId ?? (selectedLocationModel?.id ?? 1)};
    print("summit");
    pageState = PageState.loading;
    if (locationId != null) {
      notifyListeners();
    }
    SettingRepo().searchUserByMarketID(map).then((value) {
      if (value.status == true) {
        _listOfCustomer = value.data;
        _queryListOfCustomer = value.data;
      } else {
        userSearchView.onError("Error occurred");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();
      userSearchView.onError("an error occurred");
    });
  }

  sendSMSMessage(String phoneNumber) {
    Map map = {"phone": phoneNumber};
    pageState = PageState.loading;
    notifyListeners();
    SettingRepo().smsMessage(map).then((value) {
      if (value.status == true) {
        adsView.onSuccess("message send successfully");
      } else {
        adsView.onSuccess("message not successfully");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();
      adsView.onError("An error occurred");
    });
  }

  getLocation() async {
    _locations = await Pref.getAgentLocations();
    notifyListeners();
  }

  init() async {
    try {
      if (_loanProduct == null && _locationResponse == null) {
        pageState = PageState.loading;

        final results = await Future.wait([
          SettingRepo().getLoanProduct(),
          SettingRepo().getLocation(),
        ]);
        _loanProduct = results[0];
        _locationResponse = results[1];
        pageState = PageState.loaded;
        notifyListeners();
      }
    } catch (e) {
      pageState = PageState.loaded;
      notifyListeners();
    }
  }

  setLoanType(LoanModel loanModel) {
    _selectedLoanModel = loanModel;
    durationValue = null;
    amountToPay = null;
    loanAmount = null;
    notifyListeners();
  }

  onSelectLoanDuration(Map<int, int> values) {
    print(values.keys.first);
    int multiplier =
        values.keys.first; //use to key multiplier of the loan base on duration
    durationValue = values;
    loanCreationModel.duration = values.values.first.toString();
    loanAmount = _selectedLoanModel.maximumAmount;
    double loanAm = double.tryParse(_selectedLoanModel.maximumAmount);
    double interest = double.tryParse(_selectedLoanModel.interestRate);
    amountToPay = (loanAm + (((interest * multiplier) * loanAm) / 100))
        .toStringAsFixed(0);
    print(_selectedLoanModel.id);
    notifyListeners();
  }

  searchCustomer(String name) {
    pageState = PageState.loading;
    notifyListeners();
    SettingRepo().customer(name).then((value) {
      if (value.status == true) {
        _listOfCustomer = value.data;
      } else {
        adsView.onError("Error occurred");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();
      adsView.onError("an error occurred");
    });
  }

  bool requestLoanButtonValidation() {
    if (amountToPay != null &&
        selectedLoanModel.id != null &&
        _selectedCustomer != null &&
        durationValue != null) {
      return true;
    } else {
      return false;
    }
    notifyListeners();
  }

  saveLoanRequest() async {
    int userId = await Pref.geUserID();
    pageState = PageState.loading;
    notifyListeners();
    loanCreationModel.borrowerId = _selectedCustomer.id.toString();
    loanCreationModel.createdById = userId.toString();
    loanCreationModel.latePaymentPenalties = "0";
    loanCreationModel.appliedAmount = loanAmount;
    loanCreationModel.loanProductId = selectedLoanModel.id.toString();
    loanCreationModel.totalPayable = amountToPay;
    loanCreationModel.branchID = _selectedLocationModel.id.toString();
    print(loanCreationModel.toJson());
    RequestLoanRepo().post(loanCreationModel).then((value) {
      if (value.status == true) {
        adsView.onSuccess("Loan request created successfully");
      } else {
        adsView.onError(value.data.toString());
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((e) {
      pageState = PageState.loaded;
      notifyListeners();
      if (e is HttpException) {
        adsView.onError(e.data["message"]);
      } else {
        adsView.onError("error occurred");
      }
    });
  }

  set setTitle(v) {
    title = v;
  }

  set setMessage(v) {
    message = v;
  }

  summitTicket() async {
    int userId = await Pref.geUserID();
    var map = {
      "subject": title,
      "message": message,
      "status": "1",
      "created_user_id": userId.toString(),
      "user_id": _selectedCustomer.id.toString()
    };
    pageState = PageState.loading;
    notifyListeners();
    print(map);
    ticketValidation();
    errorForm.removeWhere((element) => element == null);
    if (errorForm.isNotEmpty) {
      adsView.onError(listOfStringToFormattedString(errorForm));
      return;
    }
    SettingRepo().summitTicket(map).then((value) {
      if (value.status == true) {
        adsView.onSuccess("Ticket created successfully");
      } else {
        adsView.onError("Ticket was not created");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();
      if (v is HttpException) {
        adsView.onError(v.data["message"]);
      } else {
        adsView.onError("error occurred");
      }
    });
  }

  ticketValidation() {
    errorForm.clear();
    errorForm.addAll([
      title == null ? "Add title to the ticket" : null,
      message == null ? "Ticket message should not be empty" : null,
      selectedCustomer.id == null ? "Select the customer " : null,
    ]);
  }

  clearData() {
    amountToPay = null;
    _selectedLoanModel = null;
    // _selectedLocationModel = null;
    loanAmount = null;
    // _selectedCustomer = null;
    _listOfCustomer = null;
    _queryListOfCustomer = null;
  }
}
