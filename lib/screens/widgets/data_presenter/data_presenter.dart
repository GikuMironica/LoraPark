import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DataPresenter extends StatelessWidget {
  final double width;
  final double height;
  final Widget data;
  final String title;
  final Widget visualization;

  DataPresenter({
    this.width,
    this.height,
    @required this.title,
    this.visualization,
    @required this.data,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: FittedBox(
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
          ),
          Expanded(
            flex: 6,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  visualization ?? SizedBox(width: 0, height: 0),
                  visualization == null
                      ? SizedBox(width: 0, height: 0)
                      : SizedBox(width: 10),
                  data,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
