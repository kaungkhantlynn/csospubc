import 'dart:math';

import 'package:community_sos/app/di/di.dart';
import 'package:community_sos/app/services/trusted_list_service.dart';
import 'package:community_sos/app/trusted_list.dart';
import 'package:community_sos/app/utils/helpers.dart';
import 'package:flutter/material.dart';

class ContactListPage extends StatefulWidget {
  static const String route = "/contact_page";

  @override
  _ContactListPageState createState() => _ContactListPageState();
}

class _ContactListPageState extends State<ContactListPage> {
  TrustedList trustedList;

  @override
  void initState() {
    setState(() {
      trustedList = getIt<TrustedListService>().getTrustedList();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          child: Text(
            "Contact List",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.5,
                fontSize: 21,
                fontFamily: "RobotoMedium"),
          ),
        ),
      ),
      body: trustedList.contacts.length  > 0 ?  ListView.builder(
        padding: const EdgeInsets.all(5),
        itemCount: trustedList.contacts.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              onLongPress: () {},
              leading: CircleAvatar(
                  child: Text("${trustedList.contacts[index].name}",
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: UniqueColorGenerator.getColor()
              ),
              title: Text("${trustedList.contacts[index].name}"),
              subtitle: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${trustedList.contacts[index].phone}",style: TextStyle(fontFamily: "RobotoMedium",color: Colors.grey.shade800),),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: mediaQueryData.size.width - 20 ,
                    child:  Text("${trustedList.contacts[index].desc}",style: TextStyle(fontFamily: "MyanmarSansPro"),),
                  )
                ],
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.delete_outline,
                  color: Colors.brown[900],
                ),
                onPressed: () {
                  setState(() {
                    trustedList = getIt<TrustedListService>().deleteContact(
                        contactKey: trustedList.contacts[index].key);
                  });
                },
              ),
            ),
          );
        },
      ) : Center(child: Container(child: Text('လူယုံမထည့်ရသေးပါ', style: TextStyle(fontFamily: "MyanmarSansPro",fontSize: 20),),),)
    );
  }

  String _getInitials(name) {
    var nameParts = name.split(" ").map((elem) {
      return elem[0];
    });

    if (nameParts.length == 0) {
      return "";
    }

    int numberOfParts = min(2, nameParts.length);
    return nameParts.join().substring(0, numberOfParts);
  }
}
