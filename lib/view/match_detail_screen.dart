import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:satsportz/view/playing_eleven.dart';
import 'package:satsportz/view/squad_screen.dart';

import '../controller/api_service.dart';
import '../utils/pallete.dart';

class MatchDetailsScreen extends StatefulWidget {
  @override
  _MatchDetailsScreenState createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  var _matchDetails;

  @override
  void initState() {
    super.initState();
    fetch();
  }

  fetch() async {
    return _matchDetails = await APIService.fetchMatchDetails(
      'https://demo.sportz.io/nzin01312019187360.json',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFAFAFA),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 0.0,
          title: Text(
            "SCORE BOARD",
            style: kTitleText,
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<dynamic>(
          future: fetch(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error loading match details'));
            } else {
              final match = snapshot.data!;

              var matchStatus = match["Matchdetail"]["Status"];

              var matchEquation = match["Matchdetail"]["Equation"];

              var matchLeague = match["Matchdetail"]["Match"]["League"];

              var matchnumber = match["Matchdetail"]["Match"]["Number"];

              var matchdate = match["Matchdetail"]["Match"]["Date"];

              var matchvenue = match["Matchdetail"]["Venue"]["Name"];

              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PlayingEleven()
                            //SquadScreen()
                            ),
                      );
                    },
                    child: Expanded(
                      flex: 2,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 18.0, vertical: 24.0),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    // "Sun, 27 Aug",
                                    '$matchdate',
                                    style: kNormalText,
                                  ),
                                  Text(
                                    //"Wankhade, Mumbai.",

                                    '${matchvenue}',
                                    style: kNormalText,
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Center(
                                            child: Container(
                                                height: 8.h,
                                                width: 20.w,
                                                child: LayoutBuilder(builder:
                                                    (BuildContext context,
                                                        BoxConstraints
                                                            constraints) {
                                                  return Image.asset(
                                                    'assets/nzc.jpeg',
                                                    width: constraints
                                                        .maxWidth, // Adjust image width
                                                    height: constraints
                                                        .maxHeight, // Adjust image height
                                                    fit: BoxFit
                                                        .fill, // Adjust image fit
                                                  );
                                                })
                                                // SvgPicture.asset(
                                                //     "assets/Nzflag.svg"),
                                                ),
                                          ),
                                          Text(
                                            "NZ",
                                            //'${match}',
                                            style: kNormalBoldText,
                                          )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          // Text("152/8"), Text("(20)")
                                          Text(
                                            '${matchStatus}',
                                            style: kNormalText,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 8.w,
                                      ),
                                      Column(
                                        children: [
                                          Center(
                                            child: Container(
                                                height: 8.h,
                                                width: 20.w,
                                                child: LayoutBuilder(builder:
                                                    (BuildContext context,
                                                        BoxConstraints
                                                            constraints) {
                                                  return Image.asset(
                                                    'assets/bcci.jpeg',
                                                    width: constraints
                                                        .maxWidth, // Adjust image width
                                                    height: constraints
                                                        .maxHeight, // Adjust image height
                                                    fit: BoxFit
                                                        .fill, // Adjust image fit
                                                  );
                                                })
                                                // SvgPicture.asset(
                                                //     "assets/Nzflag.svg"),
                                                ),
                                          ),
                                          //Text("IND FLAG"),
                                          Text(
                                            "IND",
                                            //'${match}',
                                            style: kNormalBoldText,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    '$matchEquation ',
                                    style: kNormalBoldText,
                                  ),
                                  Text(
                                    '$matchLeague $matchnumber ',
                                    style: kNormalText,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4373D9),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                        ),
                        child: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Image.asset(
                            'assets/indvsnzz.jpeg',
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            fit: BoxFit.cover,
                          );
                        })),
                  )
                ],
              );
            }
          },
        ));
  }
}
