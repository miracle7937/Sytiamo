import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/bottom_sheet.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/data/controller/loan_collection_controller.dart';
import 'package:sytiamo/data/model/responseModel/breakdown_loan_model.dart';
import 'package:sytiamo/data/model/responseModel/loan_collcet_model.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/feature/main_app/loan_collection/repayment_screen.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';
import 'package:sytiamo/utils/money_formatter.dart';

class LoanCollectionBreakdown extends StatefulWidget {
  final CollectionData collectionData;
  final LocationModel locationModel;

  const LoanCollectionBreakdown(
      {Key key, this.collectionData, this.locationModel})
      : super(key: key);

  @override
  _LoanCollectionBreakdownState createState() =>
      _LoanCollectionBreakdownState();
}

class _LoanCollectionBreakdownState extends State<LoanCollectionBreakdown>
    with AdsView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  LoanCollectionController loanCollectionController;

  @override
  void dispose() {
    super.dispose();
    loanCollectionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    loanCollectionController = Provider.of<LoanCollectionController>(context)
      ..setView = this
      ..getLoanBreakDown(widget.collectionData.loanId);

    SingleLoanData singleLoanData =
        loanCollectionController.singleLoanData.isNotEmpty
            ? loanCollectionController.singleLoanData.first
            : null;
    return SYScaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RepaymentScreen(
                          collectionData: widget.collectionData,
                        )));
          },
        ),
        scaffoldKey: _scaffoldKey,
        state: AppState(pageState: loanCollectionController.pageState),
        appBar: SYAppBar(
          backgroundColor: mainColor,
          iconTheme: IconThemeData(color: whiteColor),
          title: Text(
            "Loan Breakdown",
          ),
          actions: [],
        ),
        builder: (
          context,
        ) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Text("Pull down to reload page"),
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
                            singleRow(
                                firstTitle: "Name",
                                firstValue:
                                    "${singleLoanData.borrower?.firstName ?? ""} ${singleLoanData.borrower.lastName ?? ""}",
                                secondValue:
                                    "NGN ${moneyFormatter(singleLoanData.appliedAmount)}",
                                secondTitle: "Amount"),
                            Spacer(),
                            statusWidget(
                                totalAmount: singleLoanData.appliedAmount,
                                paidAmount: singleLoanData.totalPaid),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            singleRow(
                                firstTitle: "Total Paid",
                                firstValue:
                                    "${moneyFormatter(singleLoanData.totalPaid) ?? ""}",
                                secondValue:
                                    "NGN ${moneyFormatter((double.tryParse(singleLoanData.appliedAmount) - double.tryParse(singleLoanData.totalPaid)).toString())}",
                                secondTitle: "Amount Remaining"),
                          ],
                        )
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 5)
                      ])),
              SizedBox(
                height: 30,
              ),
              Text("Payment Schedule"),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  loanCollectionController
                      .refresh(widget.collectionData.loanId);
                },
                child: ListView.builder(
                    itemCount: loanCollectionController.repayment?.length ?? 0,
                    itemBuilder: (context, i) => cardView(context,
                        repayments: loanCollectionController.repayment[i])),
              ))
            ],
          );
        });
  }

  statusWidget({totalAmount, paidAmount}) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: totalAmount != paidAmount ? Colors.orange : Colors.green,
          boxShadow: [
            BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 5)
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          totalAmount != paidAmount ? "Pending" : "Completed",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  cardView(
    BuildContext context, {
    Repayment repayments,
  }) {
    var dateTime = DateTime.parse(
      repayments.createdAt,
    );

    var dateTime2 = "${dateTime.day}-${dateTime.month}-${dateTime.year}";

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15),
            child: Row(
              children: [
                singleRow(
                    firstTitle: "Date",
                    firstValue: dateTime2,
                    secondValue: "NGN ${moneyFormatter(repayments.totalPaid)}",
                    secondTitle: "Amount"),
                Spacer(),
                repayments.status == "4" ? payedWidget() : pendingWidget()
              ],
            ),
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.1), blurRadius: 5)
              ])),
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
        SizedBox(
          width: 20,
        ),
        // Spacer(),
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

  Widget payedWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Center(
            child: Text(
          "Paid",
          style: TextStyle(color: Colors.white),
        )),
      ),
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }

  Widget pendingWidget({VoidCallback callback}) {
    return InkWell(
      onTap: callback,
      child: Row(
        children: [
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
                  child: Text(
                "Pending",
                style: TextStyle(color: Colors.white),
              )),
            ),
            decoration: BoxDecoration(
              color: pendingColor,
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Center(
                  child: Text(
                "Pay",
                style: TextStyle(color: Colors.white),
              )),
            ),
            decoration: BoxDecoration(
              color: greyColor,
            ),
          )
        ],
      ),
    );
  }

  @override
  void onError(String error) async {
    print(error);
    showStatusBottomSheet(context, success: false, message: error);
  }

  @override
  void onSuccess(message) async {
    await showStatusBottomSheet(context, message: message);
    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
    loanCollectionController.getRunningLoan(
        locationModel: widget.locationModel);
  }
}
