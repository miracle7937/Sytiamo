import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_dropdown.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/settings_controller.dart';
import 'package:sytiamo/data/local/prefs.dart';
import 'package:sytiamo/data/model/responseModel/loan_product_response.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';
import 'package:sytiamo/utils/navigator_helper.dart';

class LoanRequestScreen extends StatefulWidget {
  @override
  _LoanRequestScreenState createState() => _LoanRequestScreenState();
}

class _LoanRequestScreenState extends State<LoanRequestScreen> with AdsView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SettingsController settingsController;
  List<LocationModel> locations;
  getLocation() async {
    locations = await Pref.getAgentLocations();
    setState(() {});
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    settingsController = Provider.of<SettingsController>(
      context,
    )..setView = this;

    return WillPopScope(
      onWillPop: () async {
        settingsController.clearData();
        print("clear");
        return Future.value(true);
      },
      child: SYScaffold(
          scaffoldKey: _scaffoldKey,
          state: AppState(pageState: settingsController.pageState),
          appBar: SYAppBar(
            backgroundColor: mainColor,
            iconTheme: IconThemeData(color: whiteColor),
            title: Text(
              "Loan Request",
            ),
          ),
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Request for Loan",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SYDropdownButton<LocationModel>(
                    itemsListTitle: "Market Location",
                    iconSize: 22,
                    value: settingsController.selectedLocationModel,
                    hint: Text(
                      "",
                    ),
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    searchMatcher: (item, text) {
                      return item.name.toLowerCase().contains(text);
                    },
                    onChanged: (v) {
                      print(v.name);
                      print(v.id);
                      settingsController.onSelectLocation(v);
                    },
                    // hint: Text("Identity Method"),
                    items: (locations ?? [])
                        .map(
                          (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name,
                              )),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  settingsController.selectedLocationModel != null
                      ? InkWell(
                          onTap: () {
                            moveSearchPage(context,
                                    marketID: settingsController
                                        .selectedLocationModel.id
                                        .toString())
                                .then((value) {
                              print(value);
                            });
                          },
                          child: SYTitleForm(
                            hintStyle: TextStyle(color: Colors.black),
                            hintText:
                                "${settingsController.selectedCustomer?.firstName ?? ''}  ${settingsController.selectedCustomer?.middleName ?? ''}",
                            enable: false,
                            title: "Customer",
                            keyboardType: TextInputType.number,
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  SYDropdownButton<LoanModel>(
                    itemsListTitle: "Loan Type",
                    iconSize: 22,
                    value: settingsController.selectedLoanModel,
                    hint: Text(
                      "",
                    ),
                    isExpanded: true,
                    underline: Container(
                      height: 2,
                      color: Colors.black,
                    ),
                    searchMatcher: (item, text) {
                      return item.name.toLowerCase().contains(text);
                    },
                    onChanged: (v) {
                      settingsController.setLoanType(v);
                    },
                    // hint: Text("Identity Method"),
                    items: settingsController.loanProduct?.data != null
                        ? settingsController.loanProduct.data
                            .map(
                              (e) => DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                    children: [
                                      Text("${e.name}"),
                                    ],
                                  )),
                            )
                            .toList()
                        : [],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  settingsController.selectedLoanModel != null
                      ? SYDropDown<Map<int, int>>(
                          hintDescription: "Loan Duration",
                          value: settingsController.durationValue,
                          onChange: (v) {
                            settingsController.onSelectLoanDuration(v);
                          },

                          // hint: Text("Identity Method"),
                          items: settingsController.durationsToSelect
                              .map(
                                (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      "${e.values.first} weeks",
                                    )),
                              )
                              .toList())
                      : Container(),
                  SizedBox(
                    height: 10,
                  ),
                  SYTitleForm(
                    hintStyle: TextStyle(color: Colors.black),
                    hintText: settingsController.loanAmount != null
                        ? "NGN ${settingsController.loanAmount}"
                        : "",
                    enable: false,
                    title: "Amount(NGN)",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Total with Interest",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    settingsController.amountToPay != null
                        ? "NGN ${settingsController.amountToPay}"
                        : '00.00',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SYButton(
                    disAble: !settingsController.requestLoanButtonValidation(),
                    title: "Summit",
                    callback: () {
                      settingsController.saveLoanRequest();
                    },
                  ),
                  SizedBox(
                    height: 20,
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
    await showSnackbar(
      message,
      context,
      key: _scaffoldKey,
    );
    settingsController.clearData();
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
}
