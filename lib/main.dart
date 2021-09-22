import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:community_sos/app/di/di.dart';
import 'package:community_sos/app/modules/sharedpref/shared_preference_helper.dart';
import 'package:community_sos/app/services/trusted_list_service.dart';
import 'package:community_sos/app/trusted_list.dart';
import 'package:flutter/material.dart';
import 'package:community_sos/routes/route_manager.dart';
import 'package:community_sos/ui/splash_page.dart';
import 'package:community_sos/app/di/di.dart' as di;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/utils/translate_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter_background/flutter_background.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

onBackgroundMessage(SmsMessage message) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  TrustedList trustedList;
  String trustedListJson = pref.get(SharedPreferenceHelper.keyTrustedList);
  // debugPrint("SOMETHING" + trustedListJson);

  if (trustedListJson != null) {
    trustedList = TrustedList.fromJson(json.decode(trustedListJson));

    debugPrint(message.body);

    String key = message.body.substring(0, message.body.indexOf(","));
    List<String> recipents = trustedList.contacts.map((e) => e.key).toList();
    // print("TRUSTED" + trustedList.contacts[0].desc);

    if (recipents.contains(key)) {
      debugPrint(key);
      FlutterRingtonePlayer.playRingtone();
      Future.delayed(const Duration(seconds: 30), () {
        // deleayed code here
        FlutterRingtonePlayer.stop();
      });
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final androidConfig = FlutterBackgroundAndroidConfig(
    notificationTitle: "Community SOS",
    notificationText: "Can be used without internet",
    notificationImportance: AndroidNotificationImportance.Default,
  );
  bool success = await FlutterBackground.initialize(androidConfig: androidConfig);
  bool hasPermissions = await FlutterBackground.hasPermissions;
  await FlutterBackground.enableBackgroundExecution();


  // SmsReceiver receiver = new SmsReceiver();
  // receiver.onSmsReceived.listen((SmsMessage msg) {
  //   Vibration.vibrate(duration: 500);
  // });

  // var initializationSettingsAndroid =
  //     AndroidInitializationSettings('app_logo.png');
  // var initializationSettingIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification:
  //         (int id, String title, String body, String payload) async {});
  // var initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid, iOS: initializationSettingIOS);

  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String payload) async {
  //   if (payload != null) {
  //     debugPrint('notification payload:' + payload);
  //   }
  // });

  await di.init();

  var delegate = await LocalizationDelegate.create(
      preferences: di.getIt<TranslatePreferences>(),
      fallbackLocale: 'en_US',
      supportedLocales: ['en_US', 'my']);

  configLoading();

  runApp(LocalizedApp(delegate, MyApp()));
}

// void printHello() {
//   final DateTime now = DateTime.now();
//   final int isolateId = Isolate.current.hashCode;
//   print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
// }

// void schelduleAlarm() {
//    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//      'alarm_notif',
//      'alarm_notif',
//      'Channel for SOS Alarm',
//      icon: 'app_logo',
//      sound: RawResourceAndroidNotificationSound(''))
// }

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.red
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message;
  final telephony = Telephony.instance;



  onMessage(SmsMessage message) async {
    setState(() {
      _message = message.body;
      print(_message);
      TrustedList trustedList = getIt<TrustedListService>().getTrustedList();
      print("TRUSTED_LENGTH" + trustedList.contacts.length.toString());
      print("TRUSTED" + trustedList.contacts[0].desc);
      String key = message.body.substring(0, message.body.indexOf(","));
      List<String> recipents = trustedList.contacts.map((e) => e.key).toList();
      print(key);
      if (recipents.contains(key)) {
        FlutterRingtonePlayer.playRingtone();
        Timer _timer;
        int _start = 10;
        const oneSec = const Duration(seconds: 1);
        _timer = Timer.periodic(oneSec, (Timer timer) {
          if (_start == 0) {
            FlutterRingtonePlayer.stop();
            timer.cancel();
          } else {
            setState(() {
              _start--;
            });
          }
        });
      }
    });
  }

  onSendStatus(SendStatus status) {
    setState(() {
      _message = status == SendStatus.SENT ? "sent" : "delivered";
    });
  }

// Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    final bool result = await telephony.requestPhoneAndSmsPermissions;

    if (result) {
      telephony.listenIncomingSms(
          onNewMessage: onMessage, onBackgroundMessage: onBackgroundMessage);
    }

    if (!mounted) return;
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    var localizationDelegate = LocalizedApp.of(context).delegate;

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MaterialApp(
        builder: EasyLoading.init(),
        title: "Community SOS",
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          localizationDelegate
        ],
        supportedLocales: localizationDelegate.supportedLocales,
        locale: localizationDelegate.currentLocale,
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routes: Routes.routes,
        initialRoute: SplashPage.route,
      ),
    );
  }
}
