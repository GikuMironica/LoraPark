import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorapark_app/controller/more_controller/more_controller.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  final String PARTNERS = 'assets/images/partners';
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return ChangeNotifierProvider(
      create: (_) => MoreController(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 120,
          centerTitle: true,
          title: Text(
            'More', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Consumer<MoreController>(
                builder: (_, controller, __) => ListView.separated(
                  primary: false,
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
              SizedBox(height: 16,),
              Text('Our Partners'),
              Container(
                color: Colors.white,
                child: Wrap(
                  direction: Axis.vertical,
                  spacing: 16.0,
                  children: [
                    Wrap(
                      spacing: s.width * 0.1,
                      children: [
                        partner(image: '$PARTNERS/cortex.png',),
                        partner(image: '$PARTNERS/thu.jpg'),
                      ],
                    ),
                    Wrap(
                      spacing: s.width * 0.1,
                      children: [
                        partner(image: '$PARTNERS/citysens.png',),
                        partner(image: '$PARTNERS/dz.jpg',),
                      ],
                    ),
                    Wrap(
                      spacing: s.width * 0.1,
                      children: [
                        partner(image: '$PARTNERS/spk-logo-desktop.png',),
                        Container(
                          width: s.width * 0.4,
                          height: s.height * 0.15,
                          child: SvgPicture.asset('$PARTNERS/exxcellent.svg'),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: s.width * 0.1,
                      children: [
                        Container(
                          width: s.width * 0.4,
                          height: s.height * 0.15,
                          child: SvgPicture.asset('$PARTNERS/stadt-ulm.svg'),
                        ),
                        Container(
                          width: s.width * 0.4,
                          height: s.height * 0.15,
                          child: SvgPicture.asset('$PARTNERS/uni-ulm.svg'),
                        ),
                      ],
                    ),
                    Wrap(
                      spacing: s.width * 0.1,
                      children: [
                        Container(
                          width: s.width * 0.4,
                          height: s.height * 0.15,
                          child: SvgPicture.asset('$PARTNERS/initiative.svg'),
                        ),
                        Container(
                          width: s.width * 0.4,
                          height: s.height * 0.15,
                          child: SvgPicture.asset('$PARTNERS/vsh.svg'),
                        )
                      ],
                    ),
                    Wrap(
                      spacing: s.width * 0.1,
                      children: [
                        partner(image: '$PARTNERS/systemzwo.png',),
                        partner(image: '$PARTNERS/swu.jpg'),
                      ],
                    ),
                    Wrap(
                      spacing: s.width * 0.1,
                      children: [
                        partner(image: '$PARTNERS/zukunftsstadt.jpg'),
                        partner(image: '$PARTNERS/bmbf.jpg'),
                      ],
                    ),
            ],
          ),
        ),
    ],
    ),
    ),
    ));
  }

  Container partner({String image, Color backgroundColor}){
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage(image),
          fit: BoxFit.contain,
        ),
        color: backgroundColor,
      ),
    );
  }
}
