import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';

class SensorDescription extends StatelessWidget {
  String text;
  AssetImage image;

  SensorDescription({this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  boxShadow: [
                    LoraParkTheme.boxShadow,
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    image: this.image,
                    alignment: Alignment.topLeft,
                  ),
                ),
              )
            ],
          ),
          SizedBox(height: 50),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Text(
              this.text,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
