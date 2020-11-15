import 'package:blocCredApp/Contact.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hexcolor/hexcolor.dart';

class ViewContact extends StatefulWidget {
  final String id;
  ViewContact(this.id);
  @override
  _ViewContactState createState() => _ViewContactState(id);
}

class _ViewContactState extends State<ViewContact> {
  DatabaseReference _databaseReference = FirebaseDatabase.instance.reference();

  String id;
  _ViewContactState(this.id);
  Contact _contact;
  bool isLoading = true;

  getContact(id) async {
    _databaseReference.child(id).onValue.listen((event) {
      setState(() {
        _contact = Contact.fromSnapshot(event.snapshot);
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    this.getContact(id);
  }

  deleteContact() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Text(
              "Delete?",
              style: TextStyle(color: Colors.white),
            ),
            content: Text(
              "Delete Contact?",
              style: TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                color: HexColor('#317256'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text('Delete'),
                color: HexColor('#317256'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _databaseReference.child(id).remove();
                  navigateToLastScreen();
                },
              ),
            ],
          );
        });
  }

  navigateToLastScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // wrap screen in WillPopScreen widget
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("View Contact"),
      ),
      backgroundColor: HexColor('#419873'),
      body: Container(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: <Widget>[
                  Card(
                    color: HexColor('#317256'),
                    elevation: 50,
                    child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: double.maxFinite,
                        child: Column(
                          children: [
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Icon(Icons.perm_identity),
                                Container(
                                  width: 10.0,
                                ),
                                Text(
                                  "${_contact.name}",
                                  style: TextStyle(fontSize: 20.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Icon(Icons.phone),
                                Container(
                                  width: 10.0,
                                ),
                                Text(
                                  _contact.phone,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Icon(Icons.email),
                                Container(
                                  width: 10.0,
                                ),
                                Text(
                                  _contact.email,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            SizedBox(height: 10.0),
                          ],
                        )),
                  ),
                  SizedBox(height: 15.0),
                  ButtonTheme(
                    minWidth: 0.0,
                    height: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(120)),
                    child: Padding(
                      padding: EdgeInsets.all(45),
                      child: RaisedButton(
                        color: Colors.black,
                        padding: EdgeInsets.fromLTRB(50.0, 20.0, 50.0, 20.0),
                        onPressed: () {
                          deleteContact();
                        },
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
