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
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FittedBox(
              alignment: Alignment.topCenter,
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
            Expanded(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    visualization == null
                        ? SizedBox(width: 0, height: 0)
                        : FittedBox(
                            fit: BoxFit.scaleDown,
                            child: visualization,
                          ),
                    visualization == null
                        ? SizedBox(width: 0, height: 0)
                        : SizedBox(width: 10),
                    Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.contain,
                        child: data,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
