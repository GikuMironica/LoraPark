import 'package:flutter/material.dart';

class BottomSheet extends StatefulWidget {
  BottomSheet({Key key}) : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  double _initialSheetChildSize = 0.3;
  double _dragScrollSheetExtent = 0;
  double _widgetHeight = 0;
  double _fabPosition = 0;
  double _fabPositionPadding = 10;

  @override
  void initState(){
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {

        _fabPosition = _initialSheetChildSize * _widgetHeight;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.pink,
          // here maps.
        ),
        Positioned(
          bottom: _fabPosition + _fabPositionPadding,
          right: _fabPositionPadding,
          child: FloatingActionButton(),
        ),


        NotificationListener<DraggableScrollableNotification>(
          onNotification: (DraggableScrollableNotification notification) {
            setState(() {
              _widgetHeight = context.size.height;
              _dragScrollSheetExtent = notification.extent;

              // Calculate FAB position based on parent widget height and DraggableScrollable position
              _fabPosition = _dragScrollSheetExtent * _widgetHeight;
            });
          return;
          },
          child: DraggableScrollableSheet(
            initialChildSize: _initialSheetChildSize,
            maxChildSize: 0.5,
            minChildSize: 0.1,
            builder: (context, scrollController) => ListView.builder(
              controller: scrollController,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {

              },
            ),
          ),
        ),
      ],
    );
  }
}