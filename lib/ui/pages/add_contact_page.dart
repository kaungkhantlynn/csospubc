import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:community_sos/app/di/di.dart';
import 'package:community_sos/app/services/trusted_list_service.dart';
import 'package:community_sos/app/trusted_list.dart';
import 'package:community_sos/app/utils/helpers.dart';
import 'package:community_sos/ui/pages/contact_list_page.dart';
import 'package:community_sos/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

class AddContactPage extends StatefulWidget {

  static const String route = "/add_contact_page";

  final Contact contact;

  const AddContactPage({Key key,@required this.contact}) : super(key: key);

  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  @override
  Widget build(BuildContext context) {

    MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:  Container(
          child: Text("Add Contact",style: TextStyle(color: Colors.white,fontFamily: "RobotoMedium",fontWeight: FontWeight.w600,letterSpacing: 1.5,fontSize: 21),),
        ),

      ),
      body: Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text("${widget.contact.phone}", style: TextStyle(
                 fontSize: 20.0,
                 fontFamily: "RobotoMedium",
             )),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text("${widget.contact.name}", style: TextStyle(
                 fontFamily: "RobotoMedium",
                 fontSize: 22.0
             )),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text("${widget.contact.desc}", style: TextStyle(
               fontSize: 20.0
             )),
           ),
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.end,
               children: [
                 BouncingWidget(
                   duration: Duration(milliseconds: 100),
                   scaleFactor: 1.5,
                   onPressed: () {
                     getIt<TrustedListService>().addContactToTrustedList(contact: widget.contact);
                     Navigator.pushNamedAndRemoveUntil(context, ContactListPage.route, ModalRoute.withName(HomePage.route));
                   },
                   child:  Container(
                     margin: EdgeInsets.all(10),
                     padding: EdgeInsets.only(left: 12,right: 12),
                     height: 60,
                     decoration: BoxDecoration(
                       color: Colors.deepOrange,
                       shape: BoxShape.rectangle,
                       borderRadius: BorderRadius.all(Radius.circular(8.0)),
                       boxShadow: [
                         BoxShadow(
                           color: Colors.grey.shade200,
                           blurRadius: 1.0, // has the effect of softening the shadow
                           spreadRadius: 1.0, // has the effect of extending the shadow
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
                           padding: EdgeInsets.only(right: 1,),
                           child: Icon(Icons.add,color:Colors.white,size: 32,),
                         ),
                         Container(
                             padding: EdgeInsets.only(left: 1),
                             child: Text("လူယုံထည့်မည်",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: Helpers.getTitleSize(mediaQueryData),fontFamily: "MyanmarSansPro"),)
                         )
                       ],
                     ),
                   ),
                 ),
               ],
             ),
           ),
         ],
       ),
      ),
    );
  }
}
