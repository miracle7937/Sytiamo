import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/button.dart';
import 'package:sytiamo/custom_widget/forms.dart';
import 'package:sytiamo/custom_widget/sy_appBar.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/custom_widget/sy_snackbar.dart';
import 'package:sytiamo/data/controller/update_usercontroller.dart';
import 'package:sytiamo/data/model/responseModel/customer_search_response.dart';
import 'package:sytiamo/utils/colors.dart';

class UpdateCustomerScreen extends StatefulWidget {
  final CustomerModel model;
  const UpdateCustomerScreen({Key key, this.model}) : super(key: key);

  @override
  State<UpdateCustomerScreen> createState() => _UpdateCustomerScreenState();
}

class _UpdateCustomerScreenState extends State<UpdateCustomerScreen>
    with UpdateUserView {
  UpdateUserController updateUserController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    updateUserController = Provider.of<UpdateUserController>(context)
      ..setView(this);
    initializeData();
    return SYScaffold(
      state: AppState(pageState: updateUserController.pageState),
      scaffoldKey: _scaffoldKey,
      appBar: SYAppBar(
        backgroundColor: mainColor,
        title: Text("Update User"),
      ),
      builder: (_) => ListView(
        children: [
          SizedBox(
            height: 15,
          ),
          SYTitleForm(
            setValue: widget.model.firstName,
            title: "First Name",
            onChange: (v) {
              updateUserController.setFirstName(v);
            },
          ),
          SYTitleForm(
            setValue: widget.model.middleName,
            title: "Last Name",
            onChange: (v) {
              updateUserController.setMiddleName(v);
            },
          ),
          CXDateForm(
            setValue: widget.model.dob,
            title: "Date of Birth",
            onChange: (v) {
              updateUserController.setDob(v);
            },
          ),
          SYTitleForm(
            setValue: widget.model.bvn,
            title: "BVN",
            onChange: (v) {
              updateUserController.setBvn(v);
            },
          ),
          SYTitleForm(
            setValue: widget.model.bvn,
            title: "NIN",
            onChange: (v) {
              updateUserController.setNin(v);
            },
          ),
          SYButton(
            title: "Summit",
            callback: () {
              updateUserController.updateUser(widget.model.id);
            },
          )
        ],
      ),
    );
  }

  initializeData() {
    updateUserController.firstname = widget.model.firstName;
    updateUserController.middleName = widget.model.middleName;
    updateUserController.dob = widget.model.dob;
    updateUserController.bvn = widget.model.bvn;
  }

  @override
  onError(String message) async {
    await showSnackbar(
      message,
      context,
      key: _scaffoldKey,
    );
  }

  @override
  onSuccess() async {
    await showSnackbar(
      "Customer successfully update",
      context,
      key: _scaffoldKey,
    );
    await Future.delayed(Duration(seconds: 3));
    Navigator.pop(context);
  }
}
