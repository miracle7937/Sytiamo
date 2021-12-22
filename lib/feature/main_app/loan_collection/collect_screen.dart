import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_dropdown.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/loan_collection_controller.dart';
import 'package:sytiamo/data/local/prefs.dart';
import 'package:sytiamo/data/model/responseModel/loan_collcet_model.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/feature/main_app/loan_collection/loan_collection_breakdown.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> with AdsView {
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

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    LoanCollectionController loanCollectionController =
        Provider.of<LoanCollectionController>(context)..setView = this;
    return SYScaffold(
        state: AppState(pageState: loanCollectionController.pageState),
        scaffoldKey: _scaffoldKey,
        padding: EdgeInsets.symmetric(horizontal: 15),
        appBar: SYAppBar(
          backgroundColor: mainColor,
          iconTheme: IconThemeData(color: whiteColor),
          title: Text(
            "Loan Collection",
          ),
        ),
        builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SYDropdownButton<LocationModel>(
                  itemsListTitle: "Market Location",
                  iconSize: 22,
                  value: loanCollectionController.locationModel,
                  hint: Text(
                    "",
                  ),
                  isExpanded: true,
                  underline: Divider(),
                  // value: enrollController.selectedLocationModel,
                  searchMatcher: (item, text) {
                    return item.name.toLowerCase().contains(text);
                  },
                  onChanged: (v) {
                    loanCollectionController.getRunningLoan(locationModel: v);
                    // print(v);
                    // enrollController.location = v;
                  },
                  items: (locations ?? [])
                      .map(
                        (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.name,
                            )),
                      )
                      .toList()),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount:
                        loanCollectionController.collectionList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LoanCollectionBreakdown(
                                          locationModel:
                                              loanCollectionController
                                                  .locationModel,
                                          collectionData:
                                              loanCollectionController
                                                  .collectionList[index],
                                        )));
                          },
                          child: LoanCollectionCard(
                            collectionData:
                                loanCollectionController.collectionList[index],
                          ),
                        ),
                      );
                    }),
              ),
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

class LoanCollectionCard extends StatelessWidget {
  final CollectionData collectionData;
  final VoidCallback callback;
  LoanCollectionCard({Key key, this.collectionData, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String firstName = collectionData.borrower?.firstName ?? "";
    String middleName = collectionData.borrower?.middleName ?? "";
    String lastName = collectionData.borrower?.lastName ?? "";
    return InkWell(
      onTap: callback,
      child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$firstName $middleName $lastName",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "NGN ${collectionData.appliedAmount}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(collectionData.releaseDate.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    showStatus(collectionData.status),
                  ],
                ),
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

  Widget payedWidget() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Center(
            child: Text(
          "Completed",
          style: TextStyle(color: Colors.white),
        )),
      ),
      decoration: BoxDecoration(
        color: Colors.green,
      ),
    );
  }

  Widget statusWidget(String v, {Color color}) {
    return Row(
      children: [
        Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
                child: Text(
              v,
              style: TextStyle(color: Colors.white),
            )),
          ),
          decoration: BoxDecoration(
            color: color,
          ),
        ),
      ],
    );
  }

  showStatus(String status) {
    if (status == "0") {
      return statusWidget(map[status], color: pendingColor);
    } else if (status == "1") {
      return statusWidget(map[status], color: Colors.blue);
    } else if (status == "2") {
      return statusWidget(map[status], color: Colors.green);
    } else if (status == "3") {
      return statusWidget(map[status], color: Colors.red);
    } else if (status == "4") {
      return statusWidget(map[status], color: Colors.orangeAccent);
    }
  }

  final map = {
    "0": "Pending",
    "1": "Approved",
    "2": "Completed",
    "3": "Cancelled",
    "4": "Paid"
  };
}

// condition user have paid will not be showed
//

// status
// 0 pending
//1 created
//2 approvided
// 3 completed
//4 paid

/*
*
* @if($loan->status == 0)
                                {!! xss_clean(show_status(_lang('Pending'), 'warning')) !!}
                            @elseif($loan->status == 1)
                                {!! xss_clean(show_status(_lang('Approved'), 'success')) !!}
                            @elseif($loan->status == 2)
                                {!! xss_clean(show_status(_lang('Completed'), 'info')) !!}
                            @elseif($loan->status == 3)
                                {!! xss_clean(show_status(_lang('Cancelled'), 'danger')) !!}
                            @elseif($loan->status == 4)
                                {!! xss_clean(show_status(_lang('Paid'), 'success')) !!}
                            @end*/
