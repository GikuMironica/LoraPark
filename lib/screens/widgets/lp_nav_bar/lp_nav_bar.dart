import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lorapark_app/screens/widgets/lp_nav_bar/lp_nav_bar_item.dart';
import 'package:lorapark_app/themes/lorapark_theme.dart';

class LPNavBar extends StatelessWidget {
  final int selectedIndex;
  final List<LPNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  LPNavBar({Key key, this.selectedIndex, @required this.items, this.onItemSelected});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topRight: LoraParkTheme.bottomBarRadius, topLeft: LoraParkTheme.bottomBarRadius),
      color: LoraParkTheme.bottomBarColor,
      boxShadow: [],
    ),
    child: Container(
      width: double.infinity,
      height: 60.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((i){
          var idx = items.indexOf(i);
          return Expanded(
            child: GestureDetector(
              onTap: () => onItemSelected(idx),
              child: _buildItem(i, selectedIndex == idx),
            ),
          );
        }).toList(),
      )
    ),

  );

  Widget _buildItem(LPNavBarItem item, bool isSelected) => Container(
    alignment: Alignment.center,
    height: 60.0,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: SvgPicture.asset(
            'assets/icons/svg/${item.iconName}.svg',
            color: isSelected ? LoraParkTheme.bottomBarSelectedItemColor : Colors.grey,
            height: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(0),
          child: Material(
            type: MaterialType.transparency,
            child: FittedBox(
              child: Text(
                item.title,
                style: TextStyle(
                  color: isSelected ? LoraParkTheme.bottomBarSelectedItemTitle : Colors.grey,
                  fontSize: 12
                ),
              )
            )
          ),
        )
      ],
    ),
  );
}