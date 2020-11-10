import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';

class SensorDescription extends StatelessWidget {
  final String text;
  final AssetImage image;

  SensorDescription({@required this.text, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 18,
        top: 18,
        right: 18,
        bottom: 8,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [LoraParkTheme.boxShadow],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image(
                  image: image,
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
          Container(
            width: double.infinity,
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
