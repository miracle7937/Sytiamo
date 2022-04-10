import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/bottom_sheet.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/enrollment_controller.dart';
import 'package:sytiamo/feature/main_app/dash_board.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';
import 'package:sytiamo/utils/images.dart';
import 'package:sytiamo/utils/navigations.dart';
import 'package:sytiamo/utils/string_helper.dart';

class GuarantorVerification extends StatefulWidget {
  @override
  _GuarantorVerificationState createState() => _GuarantorVerificationState();
}

class _GuarantorVerificationState extends State<GuarantorVerification>
    with GuarantorVeriView {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  EnrollmentController controller;
  @override
  Widget build(BuildContext context) {
    controller = Provider.of<EnrollmentController>(context)
      ..setGuarantorVeri = this;
    return SYScaffold(
        scaffoldKey: _scaffoldKey,
        state: AppState(pageState: controller.pageState),
        appBar: SYAppBar(
          iconTheme: IconThemeData(color: whiteColor),
          backgroundColor: mainColor,
          title: Text(
            "Enrollment",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
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
                  "Guarantor Information",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "First Guarantor",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 0.3,
                ),
                SizedBox(
                  height: 15,
                ),
                SYTitleForm(
                  setValue: controller.enrollmentModel.gname,
                  onChange: (v) => controller.guarantor1 = v,
                  title: "Name",
                ),
                SYTitleForm(
                  setValue: isNotEmpty(controller.enrollmentModel.gphone)
                      ? controller.enrollmentModel.gphone
                      : "+234",
                  keyboardType: TextInputType.phone,
                  onChange: (v) => controller.guarantorPhoneNumber1 = v,
                  title: "Phone Number",
                ),
                SYTitleForm(
                  setValue: controller.enrollmentModel.gaddress,
                  onChange: (v) => controller.guarantorAddress1 = v,
                  title: "Address",
                ),
                SYTitleForm(
                  setValue: controller.enrollmentModel.guarantorBusStop1,
                  onChange: (v) => controller.guarantorBusStop1 = v,
                  title: "Nearest bus stop",
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Guarantor Image or Identity Card",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  height: 0.3,
                ),
                // SizedBox(
                //   height: 15,
                // ),
                // SYTitleForm(
                //   onChange: (v) => controller.guarantor2 = v,
                //   title: "Name",
                // ),
                // SYTitleForm(
                //   setValue: "+234",
                //   keyboardType: TextInputType.phone,
                //   onChange: (v) => controller.guarantorPhoneNumber2 = v,
                //   title: "Phone Number",
                // ),
                // SYTitleForm(
                //   title: "Address",
                //   onChange: (v) => controller.guarantorAddress2 = v,
                // ),
                // SYTitleForm(
                //   onChange: (v) => controller.guarantorBusStop2 = v,
                //   title: "Nearest bus stop",
                // ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: mainColor),
                            borderRadius: BorderRadius.circular(15)),
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.34,
                            height: MediaQuery.of(context).size.width * 0.34,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: controller.guarantorImageOrFile != null
                                  ? Image.file(
                                      controller.guarantorImageOrFile,
                                      fit: BoxFit.fill,
                                    )
                                  : Image.asset(
                                      SYImages.document,
                                      fit: BoxFit.fill,
                                    ),
                            )),
                      ),
                      Transform.translate(
                          offset: Offset(
                              MediaQuery.of(context).size.width * 0.24,
                              -MediaQuery.of(context).size.width * 0.02),
                          child: InkWell(
                              onTap: () async {
                                await _pickImageDialog();
                              },
                              child: Image.asset(
                                SYImages.camera,
                              ))),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Note: Guarantors photo ID card  or  facial image is required",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 12),
                ),
                SizedBox(
                  height: 20,
                ),
                SYButton(
                  title: "Summit",
                  callback: () {
                    controller.create();
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          );
        });
  }

  _pickImageDialog() {
    showIVChangeAuthorizationBottomSheet(context,
        widget: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Image",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                onTap: () {
                  controller
                      .getImage(ImageSource.camera, forUser: false)
                      .whenComplete(() {
                    Navigator.pop(context);
                  });
                },
                title: Text(
                  "Camera",
                ),
              ),
              Divider(
                thickness: 1,
              ),
              ListTile(
                onTap: () {
                  controller
                      .getImage(ImageSource.gallery, forUser: false)
                      .whenComplete(() {
                    Navigator.pop(context);
                  });
                },
                title: Text(
                  "Gallery ",
                ),
              ),
            ],
          ),
        ));
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
    controller.clearFirstPageAll();
    await showSnackbar(
      message,
      context,
      key: _scaffoldKey,
    );
    await Future.delayed(Duration(seconds: 1));
    makeRoutePage(context: context, pageRef: DashBoard());
  }
}
