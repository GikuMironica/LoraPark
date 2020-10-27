import 'package:flutter/material.dart';


// this is just for testing navigation

class ExternalScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("The sensors page"),
      ),
      body: Center(
        child: Text(
          "The sensor displays"
        )
      )
    );
  }
}
