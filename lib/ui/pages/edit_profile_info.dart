import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:community_sos/app/di/di.dart';
import 'package:community_sos/app/services/trusted_list_service.dart';
import 'package:community_sos/app/trusted_list.dart';
import 'package:community_sos/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditProfileInfo extends StatefulWidget {
  static const String route = "/edit_profile";
  @override
  _EditProfileInfoState createState() => _EditProfileInfoState();
}

class _EditProfileInfoState extends State<EditProfileInfo> {
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  Contact authUser;
  @override
  void initState() {
    super.initState();
    getProfileData();
  }

  getProfileData() async {
    setState(() {
      authUser = getIt<TrustedListService>().getAuthUser();
    });

    _phoneNumberController.text = authUser.phone;
    _descController.text = authUser.desc;
    _nameController.text = authUser.name;
  }

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: Text(
            "Edit Profile Info",
            style: TextStyle(
                fontFamily: "RobotoMedium",
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                fontSize: 21),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

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
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500)),
                  ),
                ),
              ),

              Container(
                height: 65,
                margin: EdgeInsets.only(right: 10, left: 10,top: 10),
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
                    controller: _phoneNumberController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp('[ ]'))
                    ],
                    keyboardType: TextInputType.phone,
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
                    getIt<TrustedListService>().updateAuthUser(
                        name: _nameController.text,
                        phone: _phoneNumberController.text,
                        desc: _descController.text
                    );
                    Navigator.pushNamedAndRemoveUntil(context, HomePage.route, (_) => false);
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
                          Icons.code,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 1),
                          child: Text(
                            "ပြင်ဆင်ပြီးပါပြီ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: _getTitleSize(mediaQueryData),
                                fontFamily: "Pyidaungsu"),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
