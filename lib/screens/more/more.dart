import 'package:flutter/material.dart';
import 'package:lorapark_app/controller/more_controller/more_controller.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MoreController(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          centerTitle: true,
          title: Text(
            'More', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Consumer<MoreController>(
            builder: (_, controller, __) => ListView.separated(
                separatorBuilder: (context, index) =>
                    Divider(indent: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2, endIndent: MediaQuery
                        .of(context)
                        .size
                        .width * 0.2,),
                shrinkWrap: true,
                itemCount: controller.listItems.length,
                itemBuilder: (context, index) => controller.listItems[index],
            ),
          ),
        ),
      ),
    );
  }
}
