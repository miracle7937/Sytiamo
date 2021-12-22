import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/bottom_sheet.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/enrollment_controller.dart';
import 'package:sytiamo/feature/main_app/enrollment/guarrantor_verification.dart';
import 'package:sytiamo/utils/abstract_view.dart';
import 'package:sytiamo/utils/colors.dart';
import 'package:sytiamo/utils/images.dart';

class ImageVerificationScreen extends StatefulWidget {
  @override
  _ImageVerificationScreenState createState() =>
      _ImageVerificationScreenState();
}

class _ImageVerificationScreenState extends State<ImageVerificationScreen>
    with AdsView {
  EnrollmentController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    controller = Provider.of<EnrollmentController>(context)..setView = this;
    return SYScaffold(
        scaffoldKey: _scaffoldKey,
        appBar: SYAppBar(
          iconTheme: IconThemeData(color: whiteColor),
          backgroundColor: mainColor,
          title: Text(
            "Image Verification",
          ),
        ),
        builder: (context) {
          return Column(
            children: [
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
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.width * 0.5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: controller.selectedImage != null
                                ? Image.file(
                                    controller.selectedImage,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    SYImages.userPic,
                                    fit: BoxFit.fill,
                                  ),
                          )),
                    ),
                    Transform.translate(
                        offset: Offset(MediaQuery.of(context).size.width * 0.4,
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
              InkWell(
                onTap: () {
                  // getImage(ImageSource.gallery);
                  _pickImageDialog();
                },
                child: Text(
                  "Select a picture",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Spacer(),
              SYButton(
                title: "Next",
                callback: () {
                  controller.validateSecondPage();
                },
              ),
              Spacer(),
            ],
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
                  controller.getImage(ImageSource.camera).whenComplete(() {
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
                  controller.getImage(ImageSource.gallery).whenComplete(() {
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
      error.toString(),
      context,
      key: _scaffoldKey,
    );
  }

  @override
  void onSuccess(message) {
    print("hello");
    if (mounted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => GuarantorVerification()));
    }
  }
}
