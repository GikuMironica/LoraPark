import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataPresenter extends StatelessWidget {
  final double width;
  final double height;
  final String data;
  final String title;
  final AssetImage image;
  final String unit;

  DataPresenter({
    this.width,
    this.height,
    @required this.title,
    @required this.image,
    @required this.data,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xff657582).withOpacity(0.17),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(5, 5),
          ),
        ],
      ),
      child: FittedBox(
        alignment: Alignment.topLeft,
        fit: BoxFit.scaleDown,
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image(
                    image: image,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    data + ' ' + unit,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
