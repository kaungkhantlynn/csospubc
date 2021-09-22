class TrustedList {
  Contact authUser;
  List<Contact> contacts;

  TrustedList({
    this.contacts
  });

  TrustedList.fromJson(Map<String, dynamic> json) {
    if (json['auth_user'] != null) {
      authUser = Contact.fromJson(json['auth_user']);
    }
    contacts = List<Contact>();

    if (json['contacts'] != null) {
      json['contacts'].forEach((v) {
        contacts.add(Contact.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.authUser != null) {
      data['auth_user'] = this.authUser.toJson();
    }
    if (this.contacts != null) {
      data['contacts'] = this.contacts.map((v) => v.toJson()).toList();
    }

    return data;
  }

}

class Contact {
  String name;
  String phone;
  String key;
  String desc;

  Contact({this.name,this.phone, this.key, this.desc});

  Contact.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    key = json['key'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['key'] = this.key;
    data['desc'] = this.desc;
    return data;
  }
}