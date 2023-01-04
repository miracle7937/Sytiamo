import 'package:flutter/cupertino.dart';
import 'package:sytiamo/data/local/prefs.dart';
import 'package:sytiamo/data/model/responseModel/breakdown_loan_model.dart';
import 'package:sytiamo/data/model/responseModel/loan_collcet_model.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/data/repository/loan_request_repository.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/page_state_enum.dart';
import 'package:sytiamo/utils/string_helper.dart';

class LoanCollectionController extends ChangeNotifier {
  AdsView adsView;
  OnSubmitPayment onSubmitPayment;
  List<String> errorForm = [];

  PageState pageState = PageState.loaded;
  List<CollectionData> get collectionList => _collectionList;
  List<CollectionData> _collectionList;
  List<SingleLoanData> get singleLoanData => _singleLoanData ?? [];
  List<SingleLoanData> _singleLoanData;

  List<Repayment> get repayment => _repayments;
  List<Repayment> _repayments;

  LocationModel get locationModel => _locationModel;
  LocationModel _locationModel;
  String amountToBePaid, agentPassword;
  set setView(view) {
    adsView = view;
  }

  set setOnPaymentView(view) {
    onSubmitPayment = view;
  }

  getRunningLoan({LocationModel locationModel}) async {
    _locationModel = locationModel;
    int userId = await Pref.geUserID();
    var map = {
      "branch_id": _locationModel.id.toString(),
      "created_user_id": userId
    };
    //remove created user id for every one hat is an agent to see
    pageState = PageState.loading;
    notifyListeners();
    RequestLoanRepo().getLoanRunningUser(map).then((value) {
      if (value.status == true) {
        _collectionList = value.data;
        adsView.onSuccess("Loan request created successfully");
      } else {
        adsView.onError("error occurred");
      }
      pageState = PageState.loaded;
      notifyListeners();
    });

    // .catchError((v) {
    // print(v);
    // pageState = PageState.loaded;
    // notifyListeners();
    // adsView.onError("error occurred");
    // });
  }

  paidLoan(id) async {
    int userId = await Pref.geUserID();
    String name = await Pref.getUserName();
    var map = {"status": "4", "updated_by_id": userId, "name": name};

    pageState = PageState.loading;
    notifyListeners();
    RequestLoanRepo().payedBreakDow(map, id).then((value) {
      if (value["status "] == true) {
        adsView.onSuccess("Loan paid successfully");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();
      adsView.onError("An error occurred");
    });
  }

  getLoanBreakDown(id) {
    if (_repayments == null) {
      var map = {"loan_id": id.toString()};
      pageState = PageState.loading;
      RequestLoanRepo().getLoanBreakDown(map).then((BreakDownLoanModel value) {
        if (value.status == true) {
          _repayments = value.data.repayment;
          _singleLoanData = value.data.loandetails;
        } else {
          adsView.onError("An error occurred");
        }
        pageState = PageState.loaded;
        notifyListeners();
      }).catchError((v) {
        pageState = PageState.loaded;
        notifyListeners();
        adsView.onError("An error occurred");
      });
    }
  }

  refresh(id) {
    var map = {"loan_id": id.toString()};
    pageState = PageState.loading;
    notifyListeners();
    RequestLoanRepo().getLoanBreakDown(map).then((value) {
      if (value.status == true) {
        _repayments = value.data.repayment;
        _singleLoanData = value.data.loandetails;
      } else {
        adsView.onError("An error occurred");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();
      adsView.onError("An error occurred");
    });
  }

  set setAmount(v) {
    print(v);
    amountToBePaid = v;
  }

  set setPassword(v) {
    agentPassword = v;
  }

  agentRepayment({CollectionData collectionData}) async {
    int userId = await Pref.geUserID();
    var map = {
      "branch_id": _locationModel.id,
      "agent_id": userId,
      "loan_id": collectionData.loanId,
      "borrower_id": collectionData.borrowerId,
      "amount": amountToBePaid,
      "agent_password": agentPassword,
      "loan_product_id": collectionData.loanProductId,
    };
    print(map);
    paymentVerification();
    errorForm.removeWhere((element) => element == null);
    if (errorForm.isNotEmpty) {
      onSubmitPayment.onError(listOfStringToFormattedString(errorForm));
      return;
    }
    pageState = PageState.loading;
    notifyListeners();

    RequestLoanRepo().agentPayed(map).then((value) {
      if (value.status == true) {
        onSubmitPayment.onSuccess(value.message);
      } else {
        onSubmitPayment.onError(value.message);
      }

      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      pageState = PageState.loaded;
      notifyListeners();

      onSubmitPayment.onError("An error occurred");
    });
  }

  paymentVerification() {
    errorForm.clear();
    errorForm.addAll([
      (amountToBePaid == null || amountToBePaid.isEmpty)
          ? "Enter a valid amount"
          : null,
      agentPassword == null ? "Enter a valid password" : null,
    ]);
  }

  clearData() {
    amountToBePaid = null;
    agentPassword = null;
  }

  clear() {
    _repayments = null;
  }
}

abstract class OnSubmitPayment {
  onSuccess(String message);
  onError(String error);
}
