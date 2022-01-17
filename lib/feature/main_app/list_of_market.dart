import 'package:flutter/material.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/utils/colors.dart';

class MarketListScreen extends StatelessWidget {
  final List<LocationModel> marketList;
  const MarketListScreen({Key key, this.marketList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SYScaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        iconTheme: IconThemeData(color: whiteColor),
        title: Text("List of Assign Markets"),
      ),
      builder: (_) {
        return ListView(
          children: marketList
              .map((market) => ListTile(
                    title: Text(market.name),
                  ))
              .toList(),
        );
      },
    );
  }
}
