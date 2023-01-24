import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/feature/main_app/enrollment/Image_verification_screen.dart';

import '../../../custom_widget/button.dart';
import '../../../custom_widget/forms.dart';
import '../../../custom_widget/sy_appBar.dart';
import '../../../custom_widget/sy_dropdown.dart';
import '../../../custom_widget/sy_scaffold.dart';
import '../../../custom_widget/sy_snackbar.dart';
import '../../../data/controller/bank_verification_controller.dart';
import '../../../data/controller/enrollment_controller.dart';
import '../../../data/model/responseModel/all_bank_response.dart';
import '../../../utils/colors.dart';
import '../../../utils/page_state_enum.dart';
import '../../../utils/string_helper.dart';

class BankVerification extends StatefulWidget {
  final BankEnum bankEnum;
  final String userIdToBeUpdate;
  const BankVerification({Key key, this.bankEnum, this.userIdToBeUpdate})
      : super(key: key);

  @override
  State<BankVerification> createState() => _BankVerificationState();
}

class _BankVerificationState extends State<BankVerification>
    with BanksDetailView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  BankVerificationController controller;

  @override
  dispose() {
    super.dispose();
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    // controller = Provider.of<EnrollmentController>(context)
    controller = Provider.of<BankVerificationController>(context)
      ..setView(this)
      ..getAllBank();
    EnrollmentController enrollController =
        Provider.of<EnrollmentController>(context);
    return SYScaffold(
      scaffoldKey: _scaffoldKey,
      // state: AppState(pageState: controller.pageState),
      appBar: SYAppBar(
        iconTheme: IconThemeData(color: whiteColor),
        backgroundColor: mainColor,
        title: Text(
          "Enrollment",
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      builder: (_) => Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "Bank Information",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          SYDropdownButton<BanksData>(
            itemsListTitle: "Select Bank",
            value: controller.selectedBankData,
            onChanged: (v) {
              controller.setBank(v);
            },
            underline: Divider(),
            // value: enrollController.selectedLocationModel,
            searchMatcher: (item, text) {
              return item.name.toLowerCase().contains(text.toLowerCase());
            },
            // hint: Text("Identity Method"),
            items: (controller.data ?? <BanksData>[])
                .map(
                  (e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e.name.trim(),
                      )),
                )
                .toList(),
          ),
          SizedBox(
            height: 10,
          ),
          SYTitleForm(
            keyboardType: TextInputType.number,
            onChange: (v) => controller.setAccount(v),
            title: "Enter Account Number",
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
          ),
          Row(
            children: [
              Text(
                (controller.accountName ?? ""),
                style: TextStyle(color: Colors.green),
              ),
              const Spacer(),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          SYButton(
            title: "Verify",
            callback: () {
              controller.bankAccountVerification();
            },
          ),
          SizedBox(
            height: 15,
          ),
          SYButton(
            disAble: !isNotEmpty(controller.accountName),
            loading: controller.pageState == PageState.loading,
            title:
                widget.bankEnum == BankEnum.registration ? "Proceed" : "Update",
            callback: () {
              if (widget.bankEnum == BankEnum.registration) {
                if (isNotEmpty(controller.accountName)) {
                  enrollController.setAccountName = controller.accountName;
                  enrollController.setAccountNumber = controller.accountNumber;
                  enrollController.setBankName =
                      controller.selectedBankData.name;
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => ImageVerificationScreen()));
                }
              } else {
                controller.updateUserAccount(widget.userIdToBeUpdate);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  onError(String message) async {
    await showSnackbar(
      message,
      context,
      key: _scaffoldKey,
    );
  }

  @override
  onSuccess() async {}

  @override
  onUpdateAccount(String message) async {
    await showSnackbar(
      message,
      context,
      key: _scaffoldKey,
    );
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }
}
