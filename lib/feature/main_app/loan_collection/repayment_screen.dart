import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/loan_collection_controller.dart';
import 'package:sytiamo/data/model/responseModel/loan_collcet_model.dart';
import 'package:sytiamo/utils/colors.dart';

class RepaymentScreen extends StatefulWidget {
  final CollectionData collectionData;
  const RepaymentScreen({Key key, this.collectionData}) : super(key: key);

  @override
  _RepaymentScreenState createState() => _RepaymentScreenState();
}

class _RepaymentScreenState extends State<RepaymentScreen>
    with OnSubmitPayment {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LoanCollectionController loanCollectionController;
  @override
  Widget build(BuildContext context) {
    loanCollectionController = Provider.of<LoanCollectionController>(context)
      ..setOnPaymentView = this;
    return WillPopScope(
      onWillPop: () async {
        loanCollectionController.clearData();
        return Future.value(true);
      },
      child: SYScaffold(
          scaffoldKey: _scaffoldKey,
          state: AppState(pageState: loanCollectionController.pageState),
          appBar: SYAppBar(
            backgroundColor: mainColor,
            iconTheme: IconThemeData(color: whiteColor),
            title: Text("Loan Repayment"),
          ),
          builder: (
            context,
          ) {
            return SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  SYTitleForm(
                    keyboardType: TextInputType.number,
                    title: "Enter amount payed",
                    fillColor: Colors.white,
                    onChange: (v) => loanCollectionController.setAmount = v,
                  ),
                  SYTitleForm(
                    title: "Agent password",
                    forPassword: true,
                    onChange: (v) => loanCollectionController.setPassword = v,
                    fillColor: Colors.white,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SYButton(
                    textStyle: TextStyle(fontSize: 16, color: Colors.white),
                    title: "Summit",
                    callback: () {
                      loanCollectionController.agentRepayment(
                          collectionData: widget.collectionData);
                      // showIVActionBottomSheet(context,
                      //     message: "Are you sure the money has been paid? ",
                      //     title: "Confirm Payment", callback: () {
                      //
                      // });
                    },
                  )
                ],
              ),
            );
          }),
    );
  }

  @override
  void onError(String error) async {
    await showSnackbar(
      error,
      context,
      key: _scaffoldKey,
    );
  }

  @override
  void onSuccess(message) async {
    loanCollectionController.clearData();
    await showSnackbar(
      message,
      context,
      key: _scaffoldKey,
    );
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
}
