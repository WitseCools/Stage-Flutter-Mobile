import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../providers/User.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/Profile';

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<User>(context);

    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.grey[300],
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: HexColor("#222C4A"),
                  child: Card(
                    color: HexColor("#222C4A"),
                    child: Column(
                      children: [
                        Container(
                          height: 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  "Profile",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                              profileData.active
                                  ? Icon(
                                      Icons.verified_user,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.verified_user,
                                      color: Colors.red,
                                    ),
                            ],
                          ),
                        ),
                        Container(
                            child: Image(
                                width: 200,
                                image: AssetImage('images/profile.png'))),
                        Container(
                          alignment: Alignment.topLeft,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsetsDirectional.only(top: 20),
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2,
                    child: Card(
                      elevation: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              profileData.firstName.toString() +
                                  " " +
                                  profileData.lastName.toString(),
                              style: TextStyle(
                                  color: HexColor("#222C4A"),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          ),
                          Text(
                            "Function: " + profileData.function.toString(),
                            style: TextStyle(
                                color: HexColor("#222C4A"),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: RaisedButton(
                              onPressed: () => {
                                Navigator.of(context).pushNamed('/vacation')
                              },
                              color: HexColor("#222C4A"),
                              textColor: Colors.white,
                              child: Text("Days off overview"),
                            ),
                          ),
                        ],
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(100),
                              topRight: Radius.circular(100))),
                      color: Colors.grey[300],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
