import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_dropdown.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/enrollment_controller.dart';
import 'package:sytiamo/data/controller/settings_controller.dart';
import 'package:sytiamo/data/local/prefs.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/feature/main_app/enrollment/Image_verification_screen.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';

class PersonalVerification extends StatefulWidget {
  @override
  _PersonalVerificationState createState() => _PersonalVerificationState();
}

class _PersonalVerificationState extends State<PersonalVerification>
    with PersonalVeriView {
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
    EnrollmentController enrollController =
        Provider.of<EnrollmentController>(context)..setPersonalVerify = this;
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    return WillPopScope(
      onWillPop: () async {
        enrollController.clearFirstPageAll();
        return Future.value(true);
      },
      child: SYScaffold(
          scaffoldKey: _scaffoldKey,
          appBar: SYAppBar(
            backgroundColor: mainColor,
            iconTheme: IconThemeData(color: whiteColor),
            title: Text(
              "Enrollment",
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
                    "Personal Verification",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SYTitleForm(
                    onChange: (v) => enrollController.firstName = v,
                    title: "First Name",
                  ),
                  SYTitleForm(
                    onChange: (v) => enrollController.middleName = v,
                    title: "Middle Name",
                  ),
                  SYTitleForm(
                    onChange: (v) => enrollController.lastName = v,
                    title: "Last Name",
                  ),
                  SYDropDown<String>(
                    hintDescription: "Gender",
                    value: enrollController.enrollmentModel.gender,
                    onChange: (v) {
                      enrollController.gender = v;
                    },
                    // hint: Text("Identity Method"),
                    items: ["Male", "Female"]
                        .map(
                          (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                              )),
                        )
                        .toList(),
                  ),
                  CXDateForm(
                    title: "Date of Birth",
                    onChange: (v) {
                      enrollController.dob = v;
                    },
                  ),
                  SYTitleForm(
                    title: "Phone Number",
                    setValue: "+234",
                    keyboardType: TextInputType.phone,
                    onChange: (v) {
                      enrollController.phoneNumber = v;
                    },
                  ),
                  SYTitleForm(
                    title: "Home Address",
                    onChange: (v) {
                      enrollController.homeAddress = v;
                    },
                  ),
                  SYTitleForm(
                    title: "Home nearest bus stop",
                    onChange: (v) {
                      enrollController.homeBusStop = v;
                    },
                  ),
                  SYTitleForm(
                    onChange: (v) {
                      enrollController.shopAddress = v;
                    },
                    title: "Shop Address",
                  ),
                  SYTitleForm(
                    title: "Shop nearest bus stop",
                    onChange: (v) {
                      enrollController.shopBusStop = v;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SYDropdownButton<LocationModel>(
                      itemsListTitle: "Market Location",
                      iconSize: 22,
                      hint: Text(
                        "",
                      ),
                      isExpanded: true,
                      underline: Divider(),
                      value: enrollController.selectedLocationModel,
                      searchMatcher: (item, text) {
                        return item.name.toLowerCase().contains(text);
                      },
                      onChanged: (v) {
                        print(v);
                        enrollController.location = v;
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
                          .toList()),
                  SYTitleForm(
                    onChange: (v) {
                      enrollController.bankAccount = v;
                    },
                    title: "Bank Account (Optional)",
                  ),
                  SYTitleForm(
                    onChange: (v) {
                      enrollController.setBVN = v;
                    },
                    title: "BVN (Optional)",
                    keyboardType: TextInputType.phone,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SYButton(
                    title: "Next Step",
                    callback: () {
                      enrollController.validateFirstPage();
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            );
          }),
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
  void onSuccess(message) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ImageVerificationScreen()));
  }
}
