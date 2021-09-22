import 'package:flutter/material.dart';

class ProsAndCons extends StatefulWidget {
  @override
  _ProsAndConsState createState() => _ProsAndConsState();
}

class _ProsAndConsState extends State<ProsAndCons> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: Text(
            "ဆောင်ရန် ရှောင်ရန်",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                fontSize: 21,
                fontFamily: "MyanmarSansPro"),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            Container(
              padding: EdgeInsets.all(15),
              margin: EdgeInsets.only(bottom: 20),
              child: Text(
                'အရေးအကြောင်း ကိစ္စတစ်ခုဖြစ်သည့်အခါ Message ပို့ပြီး မိမိယုံကြည်ရသူများထံမှ အကူအညီရစေရန် ရည်ရွယ်၍ ရေးသားထားပါသည်။',
                style: TextStyle(
                    fontSize: _getTitleSize(mediaQueryData),
                    fontWeight: FontWeight.w700,
                    color: Colors.grey.shade700,
                    fontFamily: "RobotoMedium"
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(

                "*  အချင်းချင်း နောက်ပြောင်ခြင်းအတွက် အသုံးမပြုကြပါရန် မေတ္တာရပ်ခံအပ်ပါသည်",
                style: TextStyle(
                    fontSize: _getDescSize(mediaQueryData),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                    fontFamily: "MyanmarSansPro"),

              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                "* Message ပို့ပြီး ဆက်သွယ်သည့်အတွက် Message ပို့ခ ကုန်ကျစရိတ်ရှိမည်ဖြစ်ကြောင်း အသိပေးအပ်ပါသည်",
                style: TextStyle(
                    fontSize: _getDescSize(mediaQueryData),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                    fontFamily: "MyanmarSansPro"),

              ),
            ),

            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                "* မိမိ QR Code အား ယုံကြည်ရသူအချင်းချင်း ဖလှယ်ရန်အတွက်သာ အသုံးပြုပါ",
                style: TextStyle(
                    fontSize: _getDescSize(mediaQueryData),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                    fontFamily: "MyanmarSansPro"),

              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                "* မိမိ QR Code အား Social Network ပေါ်တွင် တင်၍ ဝေမျှခြင်းများ မပြုလုပ်သင့်ပါ၊ QR Code ကို လျှို့ဝှက်စွာ သိမ်းဆည်းထားပါရန်",
                style: TextStyle(
                    fontSize: _getDescSize(mediaQueryData),
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                    fontFamily: "MyanmarSansPro"),

              ),
            ),

          ],
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


