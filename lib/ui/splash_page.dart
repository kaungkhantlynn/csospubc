import 'dart:async';

import 'package:community_sos/app/di/di.dart';
import 'package:community_sos/app/modules/sharedpref/shared_preference_helper.dart';
import 'package:community_sos/constant/key_constant.dart';
import 'package:community_sos/ui/pages/home_page.dart';
import 'package:community_sos/ui/phone_setup.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static const String route = "/splash_page";

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isFirstTimeUsed = false;

  @override
  void initState() {
    super.initState();
    checkFirstTimeUse();

    var _duration = Duration(milliseconds: 2000);
    Timer(_duration, navigate);
  }

  checkFirstTimeUse() async {
    SharedPreferenceHelper prefs = getIt<SharedPreferenceHelper>();

    // To remove old data
    // prefs.clearAll();

    if (prefs.getString(KeyConstant.firstTimeAppUse) ==
        prefs.getString(KeyConstant.alreadyUse)) {
      setState(() {
        isFirstTimeUsed = true;
        print(isFirstTimeUsed.toString());
      });
    } else {
      setState(() {
        isFirstTimeUsed = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Image.asset(
              "assets/images/undraw_black_lives_matter.png",
              height: 100.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            "Community SOS",
            style: TextStyle(
              fontSize: 35.0,
              color: Colors.white,
              fontFamily: "RobotoMedium"
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  navigate() async {
    SharedPreferenceHelper prefs = getIt<SharedPreferenceHelper>();

    if (prefs.getString(KeyConstant.firstTimeAppUse) ==
        KeyConstant.alreadyUse) {
      Navigator.pushNamedAndRemoveUntil(context, HomePage.route, (_) => false);
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, PhoneSetup.route, (_) => false);
    }
  }
}
