import 'package:amber_Hospital/main_screens/ambulance.dart';
import 'package:amber_Hospital/main_screens/dapartment.dart';
import 'package:amber_Hospital/main_screens/doctor.dart';
import 'package:amber_Hospital/main_screens/notification.dart';
import 'package:amber_Hospital/main_screens/rooms.dart';
import 'package:flutter/material.dart';
import 'package:amber_Hospital/shared/sidebuttons.dart';
import 'package:amber_Hospital/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:amber_Hospital/model/user.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  int displayScreen = 5;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(height: 60, child: Image.asset("assets/logo.png")),
        centerTitle: true,
        actions: [
          FlatButton.icon(
              onPressed: () async {
                //if user is not null signout or else pop and go to welcome screen
                if (user == null) {
                  Navigator.popAndPushNamed(context, "Welcome");
                } else
                  await _auth.signOut();
              },
              icon: Icon(Icons.person, color: Color(0xfff4a925), size: 30),
              label: Text('logout',
                  style: TextStyle(color: Colors.white, fontSize: 16)))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
      body: Container(
        color: Colors.white,
        child: Row(
          children: [
            Sidebuttons(
              onIconPress: (int icon) {
                setState(() {
                  displayScreen = icon;
                });
              },
            ),
            if (displayScreen == 0)
              Doctor()
            else if (displayScreen == 1)
              Room()
            else if (displayScreen == 2)
              Department()
            else if (displayScreen == 3)
              Ambulance()
            else if (displayScreen == 4)
              Notifications()
            else if (displayScreen == 5)
              Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  color: Colors.grey[300],
                  child: Center(
                      child:
                          Text("Your Hospital Information will be shown here")))
          ],
        ),
      ),
    );
  }
}