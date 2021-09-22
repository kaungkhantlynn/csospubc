import 'dart:convert';

import 'package:community_sos/app/di/di.dart';
import 'package:community_sos/app/modules/sharedpref/shared_preference_helper.dart';
import 'package:flutter/material.dart';

import '../trusted_list.dart';

class TrustedListService {
  final SharedPreferenceHelper sharedPreferenceHelper = getIt<SharedPreferenceHelper>();
  TrustedList trustedList;
  static TrustedListService _instance;

  static Future<TrustedListService> getInstance() async {
    if (_instance == null) {
      _instance = TrustedListService();
      _instance.getContactsFromSharedPref();
    }

    return _instance;
  }

  void saveAuthUser({@required Contact contact}) {
    trustedList.authUser = contact;
    saveTrustedList(trustedList);
  }

  void updateAuthUser({@required String phone,@required String desc,@required String name}) {
    trustedList.authUser.phone = phone;
    trustedList.authUser.desc = desc;
    trustedList.authUser.name = name;
    saveTrustedList(trustedList);
  }

  void addContactToTrustedList({@required Contact contact}) {
    if (trustedList.contacts.length > 0) {

      var index = trustedList.contacts.indexWhere((element) => element.key == contact.key);

      if (index != -1) {
        trustedList.contacts[index] = contact;
        sharedPreferenceHelper.putString(SharedPreferenceHelper.keyTrustedList, json.encode(trustedList.toJson()));
        return;
      }
    }

    trustedList.contacts.add(contact);

    saveTrustedList(trustedList);
  }

  void saveTrustedList(TrustedList list) {
    sharedPreferenceHelper.putString(SharedPreferenceHelper.keyTrustedList, json.encode(list.toJson()));
  }

  TrustedList updateContact({Contact contact}) {
    if (trustedList.contacts.length > 0) {

      var index = trustedList.contacts.indexWhere((element) => element.key == contact.key);

      if (index != -1) {
        trustedList.contacts[index] = contact;
      } else {
        trustedList.contacts.add(contact);
      }
    } else {
      trustedList.contacts.add(contact);
    }

    return trustedList;
  }

  TrustedList deleteContact({@required String contactKey}) {

    trustedList.contacts = trustedList.contacts.where((element) => element.key != contactKey).toList();

    saveTrustedList(trustedList);

    return trustedList;
  }

  TrustedList getContactsFromSharedPref() {
    final String trustedListJson = sharedPreferenceHelper.getString(SharedPreferenceHelper.keyTrustedList);

    if (trustedListJson != null) {
      trustedList = TrustedList.fromJson(json.decode(trustedListJson));

      return trustedList;
    }

    trustedList = TrustedList(
        contacts: List(),
    );

    saveTrustedList(trustedList);

    return trustedList;
  }

  TrustedList getTrustedList() {

    if (trustedList != null) {
      return trustedList;
    }

    return getContactsFromSharedPref();
  }

  Contact getAuthUser() {
    TrustedList list = getTrustedList();

    return list.authUser;
  }

  void clearTrustedList() {
    sharedPreferenceHelper.clearKey(SharedPreferenceHelper.keyTrustedList);
  }
}