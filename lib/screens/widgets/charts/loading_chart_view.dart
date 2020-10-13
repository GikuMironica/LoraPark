import 'package:flutter/material.dart';

class LoadingChartView extends StatefulWidget {
  @override
  _LoadingChartViewState createState() => _LoadingChartViewState();
}

class _LoadingChartViewState extends State<LoadingChartView>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Color> colorAnimationOne;
  Animation<Color> colorAnimationTwo;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1500),
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

      this.setState(() {});
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
    return ShaderMask(
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width / 2,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ],
      ),
    );
  }
}
