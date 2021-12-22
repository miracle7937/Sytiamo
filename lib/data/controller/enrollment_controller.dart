import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/data/model/setModel/enrollment_model.dart';
import 'package:sytiamo/data/repository/enrollment_repository.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/image_conpression.dart';
import 'package:sytiamo/utils/page_state_enum.dart';
import 'package:sytiamo/utils/string_helper.dart';

class EnrollmentController with ChangeNotifier {
  AdsView adsView;
  PersonalVeriView personalVeriView;
  GuarantorVeriView guarantorVeriView;

  EnrollmentModel enrollmentModel = EnrollmentModel();
  LocationModel selectedLocationModel;
  PageState pageState = PageState.loaded;
  File selectedImage, guarantorImageOrFile;
  List<String> errorForm = [];
  set setView(view) {
    adsView = view;
  }

  set setPersonalVerify(view) {
    personalVeriView = view;
  }

  set setGuarantorVeri(view) {
    guarantorVeriView = view;
  }

  set firstName(v) {
    enrollmentModel.firstName = v;
    enrollmentModel.status = "1";
    enrollmentModel.userType = "customer";
  }

  set middleName(v) {
    enrollmentModel.middleName = v;
  }

  set lastName(v) {
    enrollmentModel.lastName = v;
  }

  set gender(v) {
    enrollmentModel.gender = v;
    notifyListeners();
  }

  set dob(v) {
    enrollmentModel.dob = v;
  }

  set phoneNumber(v) {
    enrollmentModel.phone = v;
  }

  set homeAddress(v) {
    enrollmentModel.address = v;
  }

  set homeBusStop(v) {
    enrollmentModel.houseBusStop = v;
  }

  set shopAddress(v) {
    enrollmentModel.shopAddress = v;
  }

  set shopBusStop(v) {
    enrollmentModel.shopBusStop = v;
  }

  set bankAccount(v) {
    enrollmentModel.accountNo = v;
  }

  set setBVN(v) {
    enrollmentModel.bvn = v;
  }

  set location(LocationModel v) {
    selectedLocationModel = v;
    enrollmentModel.branchId = v.id.toString();

    notifyListeners();
  }

//garantor
  set guarantor1(v) {
    enrollmentModel.gname = v;
  }

  set guarantorAddress1(v) {
    enrollmentModel.gaddress = v;
  }

  set guarantorBusStop1(v) {
    enrollmentModel.guarantorBusStop1 = v;
  }

  set guarantorPhoneNumber1(v) {
    enrollmentModel.gphone = v;
  }

  set guarantor2(v) {
    enrollmentModel.gname2 = v;
  }

  set guarantorAddress2(v) {
    enrollmentModel.gaddress2 = v;
  }

  set guarantorPhoneNumber2(v) {
    enrollmentModel.gphone2 = v;
  }

  set guarantorBusStop2(v) {
    enrollmentModel.guarantorBusStop2 = v;
  }

  Future getImage(ImageSource imageSource, {forUser = true}) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final fileImage = await _picker.getImage(source: imageSource);
      var file = File(fileImage.path);
      if (forUser) {
        selectedImage = file;
        notifyListeners();

        enrollmentModel.profilePicture = await compressFile(file);
        print(enrollmentModel.profilePicture);
      } else {
        guarantorImageOrFile = file;
        notifyListeners();
        enrollmentModel.gpicture = await compressFile(file);
      }

      // enrollmentModel.profilePicture = file;

    } catch (e) {
      print(e);
    }
  }

  create() {
    thirdPage();
    errorForm.removeWhere((element) => element == null);
    if (errorForm.isNotEmpty) {
      guarantorVeriView.onError(listOfStringToFormattedString(errorForm));
      return;
    }
    var rng = new Random();
    enrollmentModel.email =
        "${enrollmentModel.firstName ?? ""}+${enrollmentModel.middleName ?? ""}+${enrollmentModel.lastName ?? ""}+${rng.nextInt(1000)}@email.com";
    pageState = PageState.loading;
    notifyListeners();
    print(enrollmentModel.toJson());
    EnrollmentRepo().createCustomer(enrollmentModel).then((value) {
      if (value["status"] == true) {
        guarantorVeriView.onSuccess("User enrollment  successful");
      } else {
        guarantorVeriView.onError("Enrollment request fails");
      }
      pageState = PageState.loaded;
      notifyListeners();
    }).catchError((v) {
      guarantorVeriView.onError("error occurs");
      pageState = PageState.loaded;
      notifyListeners();
    });
  }

  validateFirstPage() {
    firstPage();
    errorForm.removeWhere((element) => element == null);
    if (errorForm.isNotEmpty) {
      personalVeriView.onError(listOfStringToFormattedString(errorForm));
    } else {
      print(errorForm);
      personalVeriView.onSuccess("");
    }
  }

  validateSecondPage() {
    print(enrollmentModel.profilePicture);
    print(errorForm);
    secondPage();
    errorForm.removeWhere((element) => element == null);
    if (errorForm.isNotEmpty) {
      adsView.onError(listOfStringToFormattedString(errorForm));
    } else {
      adsView.onSuccess("");
    }
  }

  firstPage() {
    errorForm.clear();
    errorForm.addAll([
      enrollmentModel.firstName == null
          ? "First Name field can not  be Empty"
          : null,
      enrollmentModel.middleName == null
          ? "Middle Name field can not  be Empty"
          : null,
      enrollmentModel.gender == null
          ? "Gender field should not be Empty"
          : null,
      enrollmentModel.dob == null ? "Date of birth can not be Empty " : null,
      enrollmentModel.phone == null
          ? "Phone Number field can not be Empty "
          : null,
      enrollmentModel.address == null
          ? "Address field can not be Empty "
          : null,
      enrollmentModel.shopAddress == null
          ? "Address field can not be Empty "
          : null,
      enrollmentModel.branchId == null
          ? "Market field can not be Empty "
          : null,
    ]);
  }

  thirdPage() {
    errorForm.clear();
    errorForm.addAll([
      enrollmentModel.gname == null
          ? "First Guarantor field can not  be Empty"
          : null,
      enrollmentModel.gphone == null
          ? "Phone number field can not  be Empty"
          : null,
      enrollmentModel.gaddress == null
          ? "Guarantor address field should not be Empty"
          : null,
    ]);
  }

  secondPage() {
    errorForm.clear();
    errorForm.addAll([
      enrollmentModel.profilePicture == null
          ? "Take an image of the customer"
          : null,
    ]);
  }

  clearFirstPageAll() {
    selectedImage = null;
    guarantorImageOrFile = null;
    enrollmentModel = EnrollmentModel();
  }
}
