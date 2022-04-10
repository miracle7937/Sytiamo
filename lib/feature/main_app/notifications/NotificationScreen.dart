import 'package:flutter/cupertino.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';

class NotificationListScreen extends StatefulWidget {
  const NotificationListScreen({Key key}) : super(key: key);

  @override
  _NotificationListScreenState createState() => _NotificationListScreenState();
}

class _NotificationListScreenState extends State<NotificationListScreen> {
  @override
  Widget build(BuildContext context) {
    return SYScaffold(
      builder: (_) => ListView(
        children: [],
      ),
    );
  }
}
