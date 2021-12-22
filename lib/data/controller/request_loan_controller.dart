import 'package:sytiamo/data/controller/settings_controller.dart';
import 'package:sytiamo/data/model/setModel/loan_creation_model.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/page_state_enum.dart';

class RequestLoanController extends SettingsController {
  PageState pageState = PageState.loaded;
  LoanCreationModel loanCreationModel = LoanCreationModel();
  AdsView adsView;
  set setView(view) {
    adsView = view;
  }

  saveLoanRequest() {
    //pending status 0
    pageState = PageState.loading;
    notifyListeners();
    loanCreationModel.borrowerId = 1.toString();
    loanCreationModel.loanId = "22";
    loanCreationModel.latePaymentPenalties = "0";
    loanCreationModel.appliedAmount = amountToPay;
    // loanCreationModel.loanProductId = selectedLoanModel.id.toString();
    //print(loanCreationModel.toJson());
    print(amountToPay);
    // print(selectedLoanModel.toJson());
    // RequestLoanRepo().post(loanCreationModel).then((value) {
    //   pageState = PageState.loaded;
    //   notifyListeners();
    // }).catchError((v) {
    //   pageState = PageState.loaded;
    //   notifyListeners();
    // });
  }
}
