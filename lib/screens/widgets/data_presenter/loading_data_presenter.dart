import 'package:flutter/material.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';

class LoadingDataPresenter extends StatefulWidget {
  final double height;
  final double width;

  @override
  _LoadingDataPresenterState createState() => _LoadingDataPresenterState();

  LoadingDataPresenter({this.height, this.width});
}

class _LoadingDataPresenterState extends State<LoadingDataPresenter>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> colorAnimationOne;
  Animation<Color> colorAnimationTwo;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    colorAnimationOne = ColorTween(
      begin: Colors.white54,
      end: Colors.grey.withOpacity(0.8),
    ).animate(_animationController);
    colorAnimationTwo = ColorTween(
      begin: Colors.grey.withOpacity(0.8),
      end: Colors.white54,
    ).animate(_animationController);

    _animationController.forward();

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (_animationController.status == AnimationStatus.dismissed) {
        _animationController.forward();
      }

      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? MediaQuery.of(context).size.width,
      height: widget.height == null
          ? widget.width == null
              ? MediaQuery.of(context).size.width * 0.3
              : widget.width * 0.3
          : widget.height,
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          LoraParkTheme.boxShadow,
        ],
      ),
      child: ShaderMask(
        shaderCallback: (rect) {
          return LinearGradient(
            colors: [
              colorAnimationOne.value,
              colorAnimationTwo.value,
            ],
          ).createShader(rect);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                width: widget.width == null
                    ? MediaQuery.of(context).size.width / 2
                    : widget.width / 2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: widget.width ?? MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
