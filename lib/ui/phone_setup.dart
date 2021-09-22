import 'package:community_sos/app/di/di.dart';
import 'package:community_sos/app/modules/sharedpref/shared_preference_helper.dart';
import 'package:community_sos/app/services/trusted_list_service.dart';
import 'package:community_sos/app/trusted_list.dart';
import 'package:community_sos/constant/key_constant.dart';
import 'package:community_sos/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/services.dart';


import 'package:random_string/random_string.dart';

class PhoneSetup extends StatefulWidget {
  static const String route = "/phone_setup_page";

  @override
  _PhoneSetupState createState() => _PhoneSetupState();
}

class _PhoneSetupState extends State<PhoneSetup> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Setup Community SOS',style: TextStyle(fontFamily: "RobotoMedium"),),
        leading: InkWell(
            onTap: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => MyProfile()));
            },
            child: Icon(
              Icons.settings,
              size: 27,
            )),
      ),
      body: SingleChildScrollView(
      child: Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: _imageSize(mediaQueryData),
            margin: EdgeInsets.only(right: 10, left: 10, top: 35, bottom: 30),
            child: Center(
              child:
              Image.asset('assets/images/undraw_black_lives_matter.png'),
            ),
          ),
          Container(
            padding: EdgeInsets.all(15),
            child: Text(
              "သင်ယခုလက်ရှိအသုံးပြုနေသော ဖုန်းနံပါတ်ကိုထည့်သွင်းပါ",
              style: TextStyle(
                  fontSize: _getTitleSize(mediaQueryData),
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[700],
                  fontFamily: "MyanmarSansPro"),

            ),
          ),

          Container(
            height: 65,
            margin: EdgeInsets.only(right: 10, left: 10, top: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0, // has the effect of softening the shadow
                    offset: Offset(
                      0.1, // horizontal, move right 10
                      0.1, // vertical, move down 10
                    ),
                  ),
                ]),
            child: Center(
              child: TextFormField(
                inputFormatters: [
                  BlacklistingTextInputFormatter(RegExp('[ ]')),
                ],
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return "ဖုန်းနံပါတ်ရိုက်ထည့်ရန်လိုအပ်နေပါသည်";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Colors.grey.shade800,
                    ),
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
                    hintText: "09111111111 ဟုရိုက်ပါ",
                    errorStyle: TextStyle(height: 0, fontSize: 15),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintStyle: TextStyle(
                        fontFamily: "MyanmarSansPro",
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          Container(
            height: 65,
            margin: EdgeInsets.only(right: 10, left: 10, top: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0, // has the effect of softening the shadow
                    offset: Offset(
                      0.1, // horizontal, move right 10
                      0.1, // vertical, move down 10
                    ),
                  ),
                ]),
            child: Center(
              child: TextFormField(
                controller: _nameController,
                keyboardType: TextInputType.text,
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty) {
                    return "အမည်ရိုက်ထည့်ရန် လိုအပ်နေပါသည်";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.account_box_rounded,
                      color: Colors.grey.shade800,
                    ),
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
                    hintText: "အမည်အတိုကောက်",
                    errorStyle: TextStyle(height: 0, fontSize: 15),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintStyle: TextStyle(
                        fontFamily: "MyanmarSansPro",
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),


          Container(
            margin: EdgeInsets.only(right: 10, left: 10, top: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0, // has the effect of softening the shadow
                    offset: Offset(
                      0.1, // horizontal, move right 10
                      0.1, // vertical, move down 10
                    ),
                  ),
                ]),
            child: Center(
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
                    hintText: "လိပ်စာ (သို့) အမည် .... ",
                    errorStyle: TextStyle(height: 0, fontSize: 15),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.transparent)),
                    hintStyle: TextStyle(
                        fontFamily: "MyanmarSansPro",
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
          BouncingWidget(
            duration: Duration(milliseconds: 100),
            scaleFactor: 1.5,
            onPressed: () {
              if (_key.currentState.validate()) {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                print(_phoneNumberController.text);
                _saveInfo(_phoneNumberController.text, _descController.text,_nameController.text);
                Navigator.pushReplacementNamed(context, HomePage.route);
              }
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
                      Icons.code,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 1),
                      child: Text(
                        "အတည်ပြုမည်",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: _getTitleSize(mediaQueryData),
                          fontFamily: "MyanmarSansPro",),
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    )));
  }

  _saveInfo(String phone, desc,name) async {
    SharedPreferenceHelper prefs = getIt<SharedPreferenceHelper>();
    final Contact contact =
        Contact(name:name,phone: phone, desc: desc, key: randomAlphaNumeric(10));

    getIt<TrustedListService>().saveAuthUser(contact: contact);
    prefs.putString(KeyConstant.firstTimeAppUse, KeyConstant.alreadyUse);
  }

  double _imageSize(MediaQueryData mediaQueryData) {
    if (mediaQueryData.size.width < 500) {
      return 150;
    } else if (mediaQueryData.size.width < 600) {
      return 200;
    } else {
      return 230;
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
}
