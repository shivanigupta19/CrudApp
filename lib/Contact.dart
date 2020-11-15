import 'package:firebase_database/firebase_database.dart';

class Contact {
  String _id;
  String _name;
  String _phone;
  String _email;

  // Constructor for add
  Contact(this._name, this._phone, this._email);

  // Constructor for edit
  Contact.withId(this._id, this._name, this._phone, this._email);

  // Getters
  String get id => this._id;
  String get name => this._name;
  String get phone => this._phone;
  String get email => this._email;

  // Setters

  set name(String name) {
    this.name = name;
  }

  set phone(String phone) {
    this._phone = phone;
  }

  set email(String email) {
    this._email = email;
  }

  Contact.fromSnapshot(DataSnapshot snapshot) {
    this._id = snapshot.key;
    this._name = snapshot.value['name'];
    this._phone = snapshot.value['phone'];
    this._email = snapshot.value['email'];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": _name,
      "phone": _phone,
      "email": _email,
    };
  }
}
