import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/data/controller/authentication_controller.dart';
import 'package:sytiamo/data/controller/enrollment_controller.dart';
import 'package:sytiamo/data/controller/loan_collection_controller.dart';
import 'package:sytiamo/data/controller/reportController.dart';
import 'package:sytiamo/data/controller/request_loan_controller.dart';
import 'package:sytiamo/feature/auth/login_screen.dart';

import 'data/controller/settings_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationController()),
        ChangeNotifierProvider(create: (_) => SettingsController()),
        ChangeNotifierProvider(create: (_) => EnrollmentController()),
        ChangeNotifierProvider(create: (_) => RequestLoanController()),
        ChangeNotifierProvider(create: (_) => LoanCollectionController()),
        ChangeNotifierProvider(create: (_) => ReportCollectionController()),
      ],
      child: MaterialApp(
        title: 'Sytiamo',
        theme: ThemeData(
          fontFamily: "Futura",
          appBarTheme: AppBarTheme(color: Colors.white, textTheme: TextTheme()),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SettingsController settingCont = Provider.of<SettingsController>(context)
      ..init();

    return SYScaffold(
        state: AppState(pageState: settingCont.pageState),
        padding: EdgeInsets.all(0),
        builder: (
          context,
        ) {
          return LoginScreen();
        });
  }
}
