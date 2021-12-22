import 'package:flutter/material.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/feature/main_app/enrollment/guarrantor_verification.dart';
import 'package:sytiamo/utils/colors.dart';

class IdentityVerification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SYScaffold(
        appBar: SYAppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: whiteColor),
          title: Text(
            "Enrollment",
          ),
        ),
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Verification",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              SYDropDown<String>(
                hintDescription: "Select Mode of Verification",
                // value: ,
                onChange: (v) {
                  print(v);
                },
                // hint: Text("Identity Method"),
                items: ["BVN", "NIN"]
                    .map(
                      (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                          )),
                    )
                    .toList(),
              ),
              SizedBox(
                height: 20,
              ),
              SYTitleForm(
                title: "Enter BVN Number",
                forPassword: true,
              ),
              SizedBox(
                height: 20,
              ),
              SYButton(
                title: "VERIFY",
                callback: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => GuarantorVerification()));
                },
              )
            ],
          );
        });
  }
}
