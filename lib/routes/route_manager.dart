import 'package:community_sos/ui/pages/contact_list_page.dart';
import 'package:community_sos/ui/pages/edit_profile_info.dart';
import 'package:community_sos/ui/pages/home_page.dart';
import 'package:community_sos/ui/pages/scan_page.dart';
import 'package:community_sos/ui/phone_setup.dart';
import 'package:community_sos/ui/splash_page.dart';
import 'package:flutter/widgets.dart';

class Routes {
  Routes._();

  static final routes = <String, WidgetBuilder>{
    SplashPage.route: (BuildContext context) => SplashPage(),
    PhoneSetup.route: (BuildContext context) => PhoneSetup(),
    HomePage.route: (BuildContext context) => HomePage(),
    ContactListPage.route: (BuildContext context) => ContactListPage(),
    ScanPage.route: (BuildContext context) => ScanPage(),
    EditProfileInfo.route: (BuildContext context) => EditProfileInfo()
  };
}
