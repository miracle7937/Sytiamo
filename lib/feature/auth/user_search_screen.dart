import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/bottom_sheet.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_dropdown.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/settings_controller.dart';
import 'package:sytiamo/data/local/prefs.dart';
import 'package:sytiamo/data/model/responseModel/customer_search_response.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/data/model/selectorModel.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';
import 'package:sytiamo/utils/images.dart';

class UserSearchScreen extends StatefulWidget {
  final String branchID;
  final showLocationForm;

  const UserSearchScreen(
      {Key key, this.branchID, this.showLocationForm = false})
      : super(key: key);
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen>
    with UserSearchView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SettingsController settingsController;
  @override
  void deactivate() {
    settingsController.clearData();
    super.deactivate();
  }

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
    var controller = TextEditingController();
    settingsController = Provider.of<SettingsController>(context)
      ..setUserSearchView = this;
    if (settingsController.listOfCustomer == null) {
      settingsController.searchUserBuMarketID();
    }
    return SYScaffold(
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
          widget.showLocationForm
              ? SYDropdownButton<LocationModel>(
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
                    settingsController.onSelectLocationQueryPage(v);
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
                )
              : Container(),
          SYForm(
            onChange: (v) {
              settingsController.queryUser(v);
            },
            // controller: controller,
            fillColor: whiteColor,
            inputTextColor: Colors.black,
            suffixIcon: GestureDetector(
              onTap: () {
                settingsController.queryUser(controller.text);
              },
              child: Icon(Icons.search),
            ),
          ),
          (settingsController.listOfCustomer != null ||
                  (settingsController.listOfCustomer ?? []).isNotEmpty)
              ? Expanded(
                  child: ListView.builder(
                      itemCount: settingsController.listOfCustomer?.length ?? 0,
                      itemBuilder: (context, index) {
                        CustomerModel model =
                            settingsController.listOfCustomer[index];

                        String fullName = (model.firstName ?? "") +
                            " " +
                            (model.middleName ?? "");

                        print("Miracle ${widget.branchID} ");
                        print("Ebuka ${model.branchId.toString()} ");
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
                              List<SelectorModel> selector = [];
                              selector.add(
                                  SelectorModel(key: "Name:", value: fullName));
                              selector.add(SelectorModel(
                                  key: "Phone Number:", value: model.phone));
                              selector.add(SelectorModel(
                                  key: "address: ", value: model.address));
                              selector.add(SelectorModel(
                                  key: "shop address:",
                                  value: model.shopAddress));

                              selector.add(SelectorModel(
                                  key: "Guarantor Name:", value: model.gname));
                              selector.add(SelectorModel(
                                  key: "Guarantor address:",
                                  value: model.gaddress));
                              selector.add(SelectorModel(
                                  key: "Guarantor phone number:",
                                  value: model.gphone));
                              showIVListActionBottomSheet(context,
                                  data: selector, callback: () {
                                settingsController.selectedCustomerPage(
                                    settingsController.listOfCustomer[index]);

                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                            },
                            trailing: Text(
                              model.phone ?? "",
                            ),
                            subtitle: Text(model.shopAddress ?? ""),
                            title: Text(
                              fullName,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
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
