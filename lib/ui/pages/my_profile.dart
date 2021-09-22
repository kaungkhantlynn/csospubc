import 'dart:convert';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:community_sos/app/di/di.dart';
import 'package:community_sos/app/services/trusted_list_service.dart';
import 'package:community_sos/app/trusted_list.dart';
import 'package:community_sos/ui/pages/edit_profile_info.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  String qrData;

  Contact authUser;

  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() async {
    setState(() {
      authUser = getIt<TrustedListService>().getAuthUser();
      qrData = json.encode(authUser.toJson());
      print(qrData);
     });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: Text(
            "My Profile",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                fontSize: 21,
                fontFamily: "RobotoMedium"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.red,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "${authUser.phone}",
                      style: TextStyle(
                          fontSize: _getPhoneNumberSize(mediaQueryData),
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade800,
                          fontFamily: "RobotoMedium"
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                "${authUser.name}",
                style: TextStyle(
                    fontSize: _getTitleSize(mediaQueryData),
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade700,
                    fontFamily: "RobotoMedium"
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 10,right: 10),
              child: Text(
                "${authUser.desc}",
                style: TextStyle(
                    fontSize: _getDescSize(mediaQueryData),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                    fontFamily: "MyanmarSansPro"),

              ),
            ),
            Container(
                margin: EdgeInsets.all(10.5),
                width: mediaQueryData.size.width - 80,
                height: mediaQueryData.size.width - 80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade400,
                        blurRadius:
                            1.0, // has the effect of softening the shadow
                        spreadRadius:
                            1.0, // has the effect of extending the shadow
                        offset: Offset(1, 0.5)
                    )
                  ],
                ),
                child: Center(
                  child: QrImage(
                    data: qrData,
                    version: QrVersions.auto,
                    size: mediaQueryData.size.width - 60,
                    foregroundColor: Colors.black,
                  ),
                )),
            BouncingWidget(
              duration: Duration(milliseconds: 100),
              scaleFactor: 1.5,
              onPressed: () {
                Navigator.pushNamed(context, EditProfileInfo.route);
              },
              child: Container(
                margin: EdgeInsets.all(10),
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      blurRadius: 1.0, // has the effect of softening the shadow
                      spreadRadius:
                          1.0, // has the effect of extending the shadow
                      offset: Offset(
                        0, // horizontal, move right 10
                        0, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                        right: 1,
                      ),
                      child: Icon(
                        Icons.build,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 1),
                        child: Text(
                          "အချက်အလက်ပြန်ပြင်ရန်",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: _getTitleSize(mediaQueryData),
                              fontFamily: "MyanmarSansPro"),
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  double _getPhoneNumberSize(MediaQueryData mediaQueryData) {
    if (mediaQueryData.size.width < 500) {
      return 20.0;
    } else if (mediaQueryData.size.width < 600) {
      return 21.0;
    } else {
      return 23.0;
    }
  }

  double _getTitleSize(MediaQueryData mediaQueryData) {
    if (mediaQueryData.size.width < 500) {
      return 17.0;
    } else if (mediaQueryData.size.width < 600) {
      return 18.0;
    } else {
      return 20.0;
    }
  }

  double _getDescSize(MediaQueryData mediaQueryData) {
    if (mediaQueryData.size.width < 500) {
      return 18.0;
    } else if (mediaQueryData.size.width < 600) {
      return 19.0;
    } else {
      return 21.0;
    }
  }
}
