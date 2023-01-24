import 'package:flutter/cupertino.dart';

import '../../utils/page_state_enum.dart';
import '../../utils/string_helper.dart';
import '../model/responseModel/all_bank_response.dart';
import '../repository/enrollment_repository.dart';

class BankVerificationController extends ChangeNotifier {
  BanksDetailView _banksDetailView;
  PageState pageState = PageState.loading;
  List<BanksData> data;
  String accountNumber;
  String accountName;
  BanksData selectedBankData;

  setAccount(account) {
    accountNumber = account;
  }

  setBank(v) {
    selectedBankData = v;
    notifyListeners();
  }

  setView(v) {
    _banksDetailView = v;
  }

  getAllBank() async {
    if (data == null) {
      try {
        pageState = PageState.loading;
        AllBanksResponse _allBanksResponse = await EnrollmentRepo().getBanks();
        if (_allBanksResponse.status == true) {
          data = _allBanksResponse.banks.data;
        }
        if (_allBanksResponse == null) {
          _banksDetailView.onError("Get all banks failed");
        }
        pageState = PageState.loaded;
        notifyListeners();
      } catch (e) {
        _banksDetailView.onError(e.toString());
        pageState = PageState.loaded;
        notifyListeners();
      }
    }
  }

  bankAccountVerification() {
    if (isNotEmpty(selectedBankData?.code) && isNotEmpty(accountNumber)) {
      accountName = null;
      pageState = PageState.loading;
      notifyListeners();
      var map = <String, dynamic>{};
      map["account_number"] = accountNumber;
      map["bank_code"] = selectedBankData?.code;
      EnrollmentRepo.verifyBankAccount(map).then((value) {
        if (value.status == true) {
          _banksDetailView.onSuccess();
          accountName = value.accountName;
        } else {
          _banksDetailView.onError(value.message ?? "");
        }
        pageState = PageState.loaded;
        notifyListeners();
      }).catchError((onError) {
        pageState = PageState.loaded;
        notifyListeners();
        _banksDetailView.onError(onError.data["message"]);
      });
    } else {
      _banksDetailView.onError("Ensure no empty field(s) ");
    }
  }

  updateUserAccount(String userIdToBeUpdate) async {
    print(accountName);
    if (isNotEmpty(selectedBankData?.code) && isNotEmpty(accountNumber)) {
      pageState = PageState.loading;
      notifyListeners();
      var map = <String, dynamic>{};
      map["account_number"] = accountNumber;
      map["bank_name"] = selectedBankData?.name;
      map["acc_name"] = accountName;
      map["id"] = userIdToBeUpdate;
      EnrollmentRepo.updateBankAccount(map).then((value) {
        if (value.status == true) {
          _banksDetailView.onUpdateAccount("User account updated");
        } else {
          _banksDetailView.onError(value.message ?? "");
        }
        pageState = PageState.loaded;
        notifyListeners();
      }).catchError((onError) {
        pageState = PageState.loaded;
        notifyListeners();
        _banksDetailView.onError(onError.toString());
      });
    } else {
      _banksDetailView.onError("Ensure no empty field(s) ");
    }
  }

  clear() {
    accountNumber = null;
    accountName = null;
    selectedBankData = null;
  }
}

abstract class BanksDetailView {
  onSuccess();
  onUpdateAccount(String message);
  onError(String message);
}

enum BankEnum { registration, updateUserDetail }
