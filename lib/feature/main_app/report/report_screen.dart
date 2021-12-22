import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/reportController.dart';
import 'package:sytiamo/feature/detail_screen.dart';
import 'package:sytiamo/feature/main_app/loan_collection/collect_screen.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key key}) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> with AdsView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    ReportCollectionController reportCollectionController =
        Provider.of<ReportCollectionController>(context)..setView = this;
    return SYScaffold(
        state: AppState(pageState: reportCollectionController.pageState),
        scaffoldKey: _scaffoldKey,
        padding: EdgeInsets.symmetric(horizontal: 15),
        appBar: SYAppBar(
          backgroundColor: mainColor,
          iconTheme: IconThemeData(color: whiteColor),
          title: Text(
            "Report",
          ),
        ),
        builder: (context) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CXDateForm(
                      title: "Start Date",
                      changeFormat: false,
                      onChange: (v) {
                        reportCollectionController.startDate = v;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                      child: CXDateForm(
                    changeFormat: false,
                    title: "End Date",
                    onChange: (v) {
                      reportCollectionController.endDate = v;
                    },
                  )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SYButton(
                title: "Search",
                callback: () {
                  reportCollectionController.generateReport();
                },
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount:
                        reportCollectionController.collectionList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: LoanCollectionCard(
                          callback: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => DetailScreen(
                                          borrower: reportCollectionController
                                              .collectionList[index].borrower,
                                        )));
                          },
                          collectionData:
                              reportCollectionController.collectionList[index],
                        ),
                      );
                    }),
              )
            ],
          );
        });
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
  void onSuccess(message) async {}
}
