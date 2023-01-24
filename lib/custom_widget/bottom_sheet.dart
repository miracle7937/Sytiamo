import 'package:flutter/material.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/data/controller/bank_verification_controller.dart';
import 'package:sytiamo/data/model/responseModel/customer_search_response.dart';
import 'package:sytiamo/data/model/selectorModel.dart';
import 'package:sytiamo/feature/main_app/update_customer.dart';
import 'package:sytiamo/utils/images.dart';

import '../feature/main_app/enrollment/bank_verification_screen.dart';
import '../utils/string_helper.dart';

_createExtensibleDialogWidget(
  Widget body, {
  BorderRadiusGeometry borderRadius,
  EdgeInsetsGeometry padding,
}) {
  return SafeArea(
    child: Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: borderRadius ??
              BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
        ),
        child: SingleChildScrollView(
          child: body,
        ),
      ),
    ),
  );
}

Future<void> showIVChangeAuthorizationBottomSheet(BuildContext context,
    {Widget widget}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return _createExtensibleDialogWidget(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: Container(
                height: 5,
                width: MediaQuery.of(context).size.width * 0.15,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(50)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            widget,
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: SizedBox(
                height: 15,
              ),
            )
          ],
        ),
        padding: const EdgeInsets.all(10),
      );
    },
  );
}

Future<void> showIVActionBottomSheet(BuildContext context,
    {String title, String message, VoidCallback callback}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return _createExtensibleDialogWidget(
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(child: Image.asset(SYImages.caution)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                    child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
              ),
              Center(
                  child: Text(
                message,
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 20,
              ),
              SYButton(
                title: "OK",
                callback: callback,
              ),
              SizedBox(
                height: 20,
              ),
              SYButton(
                title: "Cancel",
                color: Colors.grey,
                callback: () {
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SizedBox(
                  height: 15,
                ),
              )
            ],
          ),
        ),
        padding: const EdgeInsets.all(10),
      );
    },
  );
}

Future<void> showStatusBottomSheet(BuildContext context,
    {String message, VoidCallback callback, bool success = true}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return _createExtensibleDialogWidget(
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.width * 0.4,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Image.asset(
                          success ? SYImages.success : SYImages.error))),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                    child: Text(
                  success ? "Success" : "Error",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                )),
              ),
              Center(
                  child: Text(
                message,
                textAlign: TextAlign.center,
              )),
              SizedBox(
                height: 20,
              ),
              SYButton(
                title: "OK",
                callback: callback,
              ),
              SizedBox(
                height: 20,
              ),
              SYButton(
                title: "Cancel",
                color: Colors.grey,
                callback: () {
                  Navigator.of(context).pop();
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SizedBox(
                  height: 15,
                ),
              )
            ],
          ),
        ),
        padding: const EdgeInsets.all(10),
      );
    },
  );
}

Future<void> showIVListActionBottomSheet(BuildContext context,
    {String title,
    List<SelectorModel> data,
    VoidCallback callback,
    CustomerModel model}) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
    ),
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return _createExtensibleDialogWidget(
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Container(
                  height: 5,
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(50)),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Column(
                  children: data
                      .map((e) => Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(e.key.toString()),
                                Text(
                                  !isNotEmpty(e.value)
                                      ? "NA"
                                      : e.value.toString(),
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ))
                      .toList()),
              SizedBox(
                height: 20,
              ),
              SYButton(
                title: "OK",
                callback: callback,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: SYButton(
                      title: "Update Bank detail",
                      color: Colors.grey,
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => BankVerification(
                                      userIdToBeUpdate: model.id.toString(),
                                      bankEnum: BankEnum.updateUserDetail,
                                    )));
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: SYButton(
                      title: "Update Bio data",
                      color: Colors.grey,
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => UpdateCustomerScreen(
                                      model: model,
                                    )));
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: SizedBox(
                  height: 15,
                ),
              )
            ],
          ),
        ),
        padding: const EdgeInsets.all(10),
      );
    },
  );
}
