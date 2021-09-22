import 'package:community_sos/app/di/di.dart';
import 'package:community_sos/app/services/trusted_list_service.dart';
import 'package:community_sos/app/trusted_list.dart';
import 'package:community_sos/ui/pages/contact_list_page.dart';
import 'package:community_sos/ui/pages/my_profile.dart';
import 'package:community_sos/ui/pages/pros_and_cons.dart';
import 'package:community_sos/ui/pages/scan_page.dart';
import 'package:flutter/material.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:line_icons/line_icons.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:telephony/telephony.dart';

class HomePage extends StatefulWidget {
  static const String route = "/home_page";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final telephony = Telephony.instance;
  TrustedList trustedList;
  Contact authUser;
  String message = "This is a test message!";
  List<String> recipents;
  TextEditingController _descController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  @override
  void initState() {
    setState(() {
      trustedList = getIt<TrustedListService>().getTrustedList();
      recipents = trustedList.contacts.map((e) => e.phone).toList();
      getProfileData();
    });
    super.initState();
  }

  final SmsSendStatusListener listener = (SendStatus status) {
    if (status == SendStatus.SENT){
      EasyLoading.dismiss();
    }
  };

  getProfileData() async {
    setState(() {
      authUser = getIt<TrustedListService>().getAuthUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Community SOS' ,style: TextStyle( fontFamily: "RobotoMedium",),),
        leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfile()));
            },
            child: Icon(
              Icons.account_circle,
              size: 27,
            )),

        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProsAndCons()));
                },
                child: Icon(
                  LineIcons.question,
                  size: 27,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BouncingWidget(
                    duration: Duration(milliseconds: 100),
                    scaleFactor: 1.5,
                    onPressed: () {
                      print("onPressed");
                      Navigator.pushNamed(context, ContactListPage.route);
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.only(left: 12, right: 12),
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade200,
                            blurRadius:
                                1.0, // has the effect of softening the shadow
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
                              Icons.list,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(left: 1),
                              child: Text(
                                "အားလုံး",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: _getTitleSize(mediaQueryData),
                                    fontFamily: "MyanmarSansPro"),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child:   BouncingWidget(
                        duration: Duration(milliseconds: 100),
                        scaleFactor: 1.5,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ScanPage()),
                          );
                        },
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.only(left: 12, right: 12),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade200,
                                blurRadius:
                                1.0, // has the effect of softening the shadow
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(
                                  right: 1,
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 1),
                                  child: Text(
                                    "လူယုံထည့်မည်",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: _getTitleSize(mediaQueryData),
                                        fontFamily: "MyanmarSansPro"),
                                  ))
                            ],
                          ),
                        ),
                      ),
                  )
                ],
              ),
            ),
            Container(
              height: _imageSize(mediaQueryData),
              margin: EdgeInsets.only(right: 10, left: 10, top: 35),
              child: Center(
                child:
                    Image.asset('assets/images/undraw_black_lives_matter.png'),
              ),
            ),
            BouncingWidget(
              duration: Duration(milliseconds: 100),
              scaleFactor: 1.5,
              onPressed: () {
                if (trustedList.contacts.length > 0) {
                  EasyLoading.showProgress(0.3, status: 'Sending ...');
                  // SmsSender sender = new SmsSender();
                  String message = authUser.key + "," + authUser.name + authUser.desc;
                  trustedList.contacts.forEach((contact) {
                    telephony.sendSms(to: contact.phone, message: message,statusListener: listener);
                  });

                } else {
                  Fluttertoast.showToast(
                      msg: "လူယုံမထည့်ရသေးပါ",
                      backgroundColor: Colors.red,
                      textColor: Colors.white);
                }

                // sender.sendSms(new SmsMessage(address, 'Hello flutter!'));
                // sendSMS(message: authUser.desc, recipients: recipents);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 15),
                height: 95,
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
                        LineIcons.bullhorn,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 1),
                        child: Text(
                          "ကူညီကြပါ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: _getTitleSize(mediaQueryData),
                              fontFamily: "MyanmarSansPro"),
                        ))
                  ],
                ),
              ),
            ),

            BouncingWidget(
              duration: Duration(milliseconds: 100),
              scaleFactor: 1.5,
              onPressed: () {

                Alert(

                    context: context,
                    title: "",
                    content: Column(
                      children: <Widget>[
                          Form(
                             key: _key,
                              child: TextFormField(
                                inputFormatters: [LengthLimitingTextInputFormatter(150)],
                                controller: _descController,
                                keyboardType: TextInputType.text,
                                autocorrect: false,
                                validator: (value) {
                                  if (value.length == 0) {
                                    return "ကျေးဇူးပြု၍ တစ်ခုခု ရိုက်ထည့်ပေးပါ";
                                  }
                                  return null;
                                },
                                maxLength: 100,
                                maxLines: 2,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent, //this has no effect
                                      ),
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(color: Colors.transparent)),
                                    disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(color: Colors.transparent)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(color: Colors.transparent)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(color: Colors.transparent)),
                                    hintText: "ပို့မည့် စာတို ... ",
                                    errorStyle: TextStyle(height: 0, fontSize: 15),
                                    focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5.0),
                                        borderSide: BorderSide(color: Colors.transparent)),
                                    hintStyle: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w500)),
                              )
                          )
                      ],
                    ),
                    buttons: [
                      DialogButton(
                        onPressed: () {
                          if (_key.currentState.validate()) {
                            FocusScopeNode currentFocus = FocusScope.of(
                                context);

                            if (!currentFocus.hasPrimaryFocus) {
                              currentFocus.unfocus();
                            }

                            if (trustedList.contacts.length > 0) {
                              EasyLoading.showProgress(0.3, status: 'Sending ...');
                              // SmsSender sender = new SmsSender();
                              // String message = authUser.key + "," + authUser.name + authUser.desc;
                              trustedList.contacts.forEach((contact) {
                                telephony.sendSms(to: contact.phone, message: _descController.text,statusListener: listener);
                              });

                              Navigator.pop(context);

                            } else {
                              Fluttertoast.showToast(
                                  msg: "လူယုံမထည့်ရသေးပါ",
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white);
                            }
                          }


                          print(_descController.text);
                       },
                        child: Text(
                          "ပို့မည်",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ]).show();

              },
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10, bottom: 80),
                height: 95,
                decoration: BoxDecoration(
                  color: Colors.orange.shade400,
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
                        LineIcons.sms,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 1),
                        child: Text(
                          "စာတို ပို့မည်",
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // void _sendSMS(String message, List<String> recipents) async {
  //   SmsSender sender = new SmsSender();
  //   sender.sendSms(new SmsMessage(recipents, _body))
  // }

  double _getTitleSize(MediaQueryData mediaQueryData) {
    if (mediaQueryData.size.width < 500) {
      return 19.0;
    } else if (mediaQueryData.size.width < 600) {
      return 20.0;
    } else {
      return 22.0;
    }
  }

  double _imageSize(MediaQueryData mediaQueryData) {
    if (mediaQueryData.size.width < 500) {
      return 300;
    } else if (mediaQueryData.size.width < 600) {
      return 350;
    } else {
      return 380;
    }
  }
}
