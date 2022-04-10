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
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';
import 'package:sytiamo/utils/navigator_helper.dart';

class TicketScreen extends StatefulWidget {
  const TicketScreen({Key key}) : super(key: key);

  @override
  _TicketScreenState createState() => _TicketScreenState();
}

class _TicketScreenState extends State<TicketScreen> with AdsView {
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
    settingsController = Provider.of<SettingsController>(context)
      ..setView = this;
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
            iconTheme: IconThemeData(color: whiteColor),
            backgroundColor: mainColor,
            title: Text(
              "Ticket",
            ),
          ),
          builder: (context) {
            return SingleChildScrollView(
              child: Column(
                children: [
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
                  settingsController.selectedLocationModel != null
                      ? InkWell(
                          onTap: () {
                            moveSearchPage(context);
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
                  SYTitleForm(
                    setValue: settingsController.title,
                    title: "subject",
                    onChange: (v) => settingsController.setTitle = v,
                  ),
                  SYTitleForm(
                    setValue: settingsController.message,
                    maxLines: 5,
                    onChange: (v) => settingsController.setMessage = v,
                    formHeight: MediaQuery.of(context).size.height * 0.3,
                    title: "message",
                  ),
                  SYButton(
                    title: "Summit",
                    callback: () => settingsController.summitTicket(),
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
    settingsController.clearData();
    await showSnackbar(
      message,
      context,
      key: _scaffoldKey,
    );

    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
  }
}
