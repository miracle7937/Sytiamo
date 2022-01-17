import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/settings_controller.dart';
import 'package:sytiamo/data/model/responseModel/customer_search_response.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';
import 'package:sytiamo/utils/images.dart';

class UserSearchScreen extends StatefulWidget {
  final String branchID;

  const UserSearchScreen({Key key, this.branchID}) : super(key: key);
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> with AdsView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController();
    SettingsController settingsController =
        Provider.of<SettingsController>(context)..setView = this;
    return WillPopScope(
      onWillPop: () async {
        settingsController.clearData();
        print("clear");
        return Future.value(true);
      },
      child: SYScaffold(
        key: _scaffoldKey,
        state: AppState(
          pageState: settingsController.pageState,
        ),
        appBar: SYAppBar(
          backgroundColor: mainColor,
          iconTheme: IconThemeData(color: whiteColor),
          title: Text(
            "Search customer",
          ),
        ),
        builder: (context) => SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            SYForm(
              controller: controller,
              fillColor: whiteColor,
              inputTextColor: Colors.black,
              suffixIcon: GestureDetector(
                onTap: () {
                  settingsController.searchCustomer(controller.text);
                },
                child: Icon(Icons.search),
              ),
            ),
            SYButton(
              title: "Search",
              callback: () {
                settingsController.searchCustomer(controller.text);
              },
            ),
            (settingsController.listOfCustomer != null ||
                    (settingsController.listOfCustomer ?? []).isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                        itemCount:
                            settingsController.listOfCustomer?.length ?? 0,
                        itemBuilder: (context, index) {
                          CustomerModel model =
                              settingsController.listOfCustomer[index];

                          String fullName = (model.firstName ?? "") +
                              " " +
                              (model.middleName ?? "");

                          print("Miracle ${widget.branchID} ");
                          print("Ebuka ${model.branchId.toString()} ");
                          if (widget.branchID == null) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      blurRadius: 5)
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context,
                                      settingsController.listOfCustomer[index]);
                                },
                                trailing: Text(model.phone ?? ""),
                                subtitle: Text(model.shopAddress ?? ""),
                                title: Text(fullName),
                              ),
                            );
                          } else if (widget.branchID != null &&
                              widget.branchID == model.branchId.toString()) {
                            return Container(
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromRGBO(0, 0, 0, 0.15),
                                      blurRadius: 5)
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pop(context,
                                      settingsController.listOfCustomer[index]);
                                },
                                trailing: Text(model.phone ?? ""),
                                subtitle: Text(model.shopAddress ?? ""),
                                title: Text(fullName),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        }))
                : Expanded(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.width * 0.5,
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Image.asset(SYImages.userSearch),
                      )
                    ],
                  ))
          ],
        )),
      ),
    );
  }

  @override
  void onError(String error) async {
    await showSnackbar(
      error.toString(),
      context,
      key: _scaffoldKey,
    );
  }

  @override
  void onSuccess(message) async {
    // await showSnackbar(
    //   message,
    //   _scaffoldKey.currentContext,
    //   key: _scaffoldKey,
    // );
  }
}
