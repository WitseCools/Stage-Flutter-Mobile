import 'package:flutter/material.dart';
import 'package:frontend/widgets/PeriodSelector.dart';
import 'package:hexcolor/hexcolor.dart';

class VacationScreen extends StatelessWidget {
  const VacationScreen({Key key}) : super(key: key);
  static const routeName = '/vacation';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text(
                        "Days off overview",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsetsDirectional.only(top: 20),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.2,
                child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100))),
                    color: Colors.grey[300],
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: PeriodSelector(),
                        )
                      ],
                    )),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
