import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sytiamo/data/model/responseModel/customer_search_response.dart';
import 'package:sytiamo/feature/auth/user_search_screen.dart';

Future<CustomerModel> moveSearchPage(BuildContext context) async {
  CustomerModel customerModel = await Navigator.push(
      context, MaterialPageRoute(builder: (context) => UserSearchScreen()));
  return customerModel;
}
