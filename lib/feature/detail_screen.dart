import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/settings_controller.dart';
import 'package:sytiamo/data/model/responseModel/loan_collcet_model.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';

class DetailScreen extends StatefulWidget {
  final Borrower borrower;
  const DetailScreen({Key key, this.borrower}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with AdsView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context)..setView = this;
    print(widget.borrower.status);
    return SYScaffold(
        state: AppState(pageState: settingsController.pageState),
        scaffoldKey: _scaffoldKey,
        appBar: SYAppBar(
          backgroundColor: mainColor,
          iconTheme: IconThemeData(color: whiteColor),
          title: Text("Review Information"),
        ),
        builder: (context) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Personal Information",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        singleRow(
                          firstTitle: "First Name",
                          firstValue: widget.borrower.firstName ?? "",
                          secondTitle: "Middle Name",
                          secondValue: widget.borrower.middleName ?? "",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        singleRow(
                          firstTitle: "Last Name",
                          firstValue: widget.borrower.lastName ?? "",
                          secondTitle: "Gender",
                          secondValue: widget.borrower.gender ?? "",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        singleRow(
                            firstTitle: "Phone Number",
                            firstValue: widget.borrower.phone ?? "",
                            secondTitle: "Date of Birth",
                            secondValue: widget.borrower.dob ?? ""),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Home Address",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(widget.borrower.address ?? "",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Shop Address",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey)),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(widget.borrower.shopAddress ?? "",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Row(
                        //   children: [
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text("Location",
                        //             style: TextStyle(
                        //                 fontSize: 12,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: Colors.grey)),
                        //         Text("Lekki market",
                        //             style: TextStyle(
                        //                 fontSize: 12,
                        //                 fontWeight: FontWeight.w600,
                        //                 color: Colors.black))
                        //       ],
                        //     ),
                        //   ],
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        // (widget.borrower.status == "1")
                        //     ? SYButton(
                        //         title: "Repayment SMS",
                        //         callback: () {
                        //           showIVActionBottomSheet(context,
                        //               message:
                        //                   "Are you sure want to send ${widget.borrower.firstName} reminder SMS? ",
                        //               title: "Send SMS Reminder", callback: () {
                        //             Navigator.pop(context);
                        //             settingsController
                        //                 .sendSMSMessage(widget.borrower.phone);
                        //           });
                        //         },
                        //       )
                        //     : Container()
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15), blurRadius: 5)
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Guarantor Information",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("First Guarantor",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                        _tileView(
                            title: "Full Name", value: widget.borrower.gname),
                        _tileView(
                            title: "Phone Number",
                            value: widget.borrower.gphone),
                        _tileView(
                            title: "Home Address",
                            value: widget.borrower.gaddress),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text("Second Guarantor",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                        _tileView(
                            title: "Full Name", value: widget.borrower.gname2),
                        _tileView(
                            title: "Phone Number",
                            value: widget.borrower.gphone2),
                        _tileView(
                            title: "Home Address",
                            value: widget.borrower.gaddress2),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15), blurRadius: 5)
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                // Text("Repayment SMS",
                //     style: TextStyle(
                //         fontSize: 12,
                //         fontWeight: FontWeight.bold,
                //         color: Colors.grey)),
                SizedBox(
                  height: 10,
                ),
                // (widget.borrower.status == "1")
                //     ? Row(
                //         children: [
                //           Expanded(
                //               child: SYButton(
                //             title: "First Guarantor",
                //             callback: () {
                //               showIVActionBottomSheet(context,
                //                   message:
                //                       "Are you sure want to send ${widget.borrower.gname} reminder SMS? ",
                //                   title: "Send SMS Reminder", callback: () {
                //                 Navigator.pop(context);
                //                 settingsController
                //                     .sendSMSMessage(widget.borrower.gphone);
                //               });
                //             },
                //           )),
                //           SizedBox(
                //             width: 10,
                //           ),
                //           Expanded(
                //               child: SYButton(
                //             title: "Second Guarantor",
                //             callback: () {
                //               showIVActionBottomSheet(context,
                //                   message:
                //                       "Are you sure want to send ${widget.borrower.gname2} reminder SMS? ",
                //                   title: "Send SMS Reminder", callback: () {
                //                 Navigator.pop(context);
                //                 settingsController
                //                     .sendSMSMessage(widget.borrower.gphone);
                //               });
                //             },
                //           ))
                //         ],
                //       )
                //     : Container(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  _tileView({String title, String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey)),
              SizedBox(
                height: 5,
              ),
              Text(value,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.black))
            ],
          ),
        ],
      ),
    );
  }

  singleRow({firstTitle, firstValue, secondTitle, secondValue}) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(firstTitle,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            SizedBox(
              height: 8,
            ),
            Text(firstValue,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black))
          ],
        ),
        Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(secondTitle,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
            SizedBox(
              height: 8,
            ),
            Text(secondValue,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black))
          ],
        )
      ],
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
  }
}
