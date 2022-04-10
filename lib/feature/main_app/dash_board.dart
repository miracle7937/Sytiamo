import 'package:flutter/material.dart';
import 'package:sytiamo/custom_widget/sy_scaffold.dart';
import 'package:sytiamo/data/local/prefs.dart';
import 'package:sytiamo/data/model/responseModel/location_response.dart';
import 'package:sytiamo/feature/auth/user_search_screen.dart';
import 'package:sytiamo/feature/main_app/enrollment/personal_verification.dart';
import 'package:sytiamo/feature/main_app/list_of_market.dart';
import 'package:sytiamo/feature/main_app/loan_collection/collect_screen.dart';
import 'package:sytiamo/feature/main_app/loan_request/loan_request_screen.dart';
import 'package:sytiamo/feature/main_app/report/report_screen.dart';
import 'package:sytiamo/feature/main_app/ticket_screen.dart';
import 'package:sytiamo/utils/colors.dart';
import 'package:sytiamo/utils/greetings.dart';
import 'package:sytiamo/utils/images.dart';

class DashBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SYScaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: mainColor,
            child: Text(
              "Ticket",
              style: TextStyle(fontSize: 10),
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => TicketScreen()));
            },
          ),
          padding: EdgeInsets.symmetric(horizontal: 20),
          builder: (context) {
            return Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              greetingMessage(),
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Spacer(),
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //             builder: (_) =>
                            //                 NotificationListScreen()));
                            //   },
                            //   child: Stack(
                            //     children: [
                            //       Icon(
                            //         Icons.notifications,
                            //         size: 35,
                            //       ),
                            //       Container(
                            //         decoration: BoxDecoration(
                            //             color: Colors.red,
                            //             shape: BoxShape.circle),
                            //         child: Padding(
                            //           padding: EdgeInsets.all(5),
                            //           child: Text(
                            //             "2",
                            //             style: TextStyle(color: Colors.white),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                FutureBuilder<String>(
                                    future: Pref.getUserName(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data.isNotEmpty) {
                                        return Text(
                                          snapshot.data,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    }),
                              ],
                            ),
                            Spacer(),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.width * 0.23,
                                width: MediaQuery.of(context).size.width * 0.23,
                                child: Image.asset(SYImages.user))
                          ],
                        ),
                        FutureBuilder<List<LocationModel>>(
                            future: Pref.getAgentLocations(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData &&
                                  snapshot.data.isNotEmpty) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => MarketListScreen(
                                                  marketList: snapshot.data,
                                                )));
                                  },
                                  child: Wrap(
                                    children: List.generate(
                                        snapshot.data.length > 3
                                            ? 3
                                            : snapshot.data.length,
                                        (index) => Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    snapshot.data[index].name
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            )),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }),
                      ],
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.15), blurRadius: 5)
                      ]),
                ),
                SizedBox(
                  height: 20,
                ),
                Spacer(flex: 1),
                Row(
                  children: [
                    Text(
                      "Activity",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Spacer()
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CardView(
                      title: "Enrollment",
                      image: SYImages.enrollment,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PersonalVerification()));
                      },
                    ),
                    Spacer(),
                    CardView(
                      title: "Loan Request",
                      image: SYImages.requestLoanIcon,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => LoanRequestScreen()));
                      },
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    CardView(
                      title: "Report",
                      image: SYImages.loanReport,
                      onTap: () {
                        print("hello");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportScreen()));
                      },
                    ),
                    Spacer(),
                    CardView(
                      title: "Loan Collection",
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CollectionScreen()));
                      },
                      image: SYImages.collectLoan,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    CardView(
                      title: "Customer List",
                      image: SYImages.search,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserSearchScreen(
                                      showLocationForm: true,
                                    )));
                      },
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            );
          }),
    );
  }
}

class CardView extends StatelessWidget {
  final String title, image;
  final VoidCallback onTap;

  const CardView({Key key, this.title, this.image, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.height * 0.18,
        decoration: BoxDecoration(
            // border: Border.all(
            //   width: 0.5,
            //   color: Colors.grey.withOpacity(0.4),
            // ),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.15), blurRadius: 5)
            ]),
      ),
    );
  }
}
