import 'package:flutter/material.dart';
import 'package:maxtech/utils/colors.dart';


class ProfileItemComponent extends StatelessWidget {
  const ProfileItemComponent({
    required this.icon,
    required this.iconname,
    required this.isavalable,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String iconname;
  final bool isavalable;

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    final double horizontalPadding = isSmallScreen ? 20 : 20;
    final double iconSize = isSmallScreen ? 40 : 25;
    final double arrowIconSize = isSmallScreen ? 14 : 11;
    final double spacing = isSmallScreen ? 25 : 25;
    final double fontSize = isSmallScreen ? 14 : 14;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: iconSize,
                color: Colors.blue,
              ),
              SizedBox(width: spacing),
              Text(
                iconname,
                style: TextStyle(
                  color: ashcolor,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize,
                  fontFamily: 'Roboto',
                ),
              ),
            ],
          ),
          isavalable
              ? Icon(
                  Icons.arrow_forward_ios,
                  size: arrowIconSize,
                  color: const Color(0xFF4F5E7B),
                )
              : Container(),
        ],
      ),
    );
  }
}
