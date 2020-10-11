import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataPresenter extends StatelessWidget {
  final double width;
  final double height;
  String data;
  BuildContext context;
  final String text;
  final AssetImage image;
  final String unit;

  DataPresenter(
      {this.context,
      this.width,
      this.height,
      this.text,
      this.image,
      this.data,
      this.unit,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: this.width,
      height: this.height,
      child: Container(
          padding: EdgeInsets.all(20),
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
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(text,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Roboto Condensed',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      )),
                ]),
                Row(
                  children: [
                    SizedBox(
                        width: 60,
                        height: 60,
                        child: Image(
                          image: this.image,
                        )),
                    SizedBox(width: 10),
                    Text(this.data +" "+ this.unit,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Roboto Condensed',
                          fontWeight: FontWeight.w700,
                          fontSize: 36
                        )),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
