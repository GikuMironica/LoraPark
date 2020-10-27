import 'package:flutter/material.dart';

import '../../../data/models/sensor.dart';

class SensorWidget extends StatelessWidget {
 final Sensor sensor;
 SensorWidget({this.sensor});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 6,
                  spreadRadius: 6)
            ],
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.width * 0.2,
                child: Row(children: <Widget>[
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.grey.shade300,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.58,
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Text(
                      "abcd",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                      "abcd",
                        style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(32),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Text(
                      "abcd",
                    ),
                  ),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("abcd", style: TextStyle(fontSize: 20.0)),
                    Icon(Icons.arrow_forward)
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
