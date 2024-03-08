// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maxtech/utils/colors.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final String fontfamily;

  const TextComponent({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
    required this.fontfamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: fontfamily,
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class TextComponentOnbording extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final String fontfamily;

  const TextComponentOnbording({
    super.key,
    required this.text,
    required this.size,
    required this.color,
    required this.fontWeight,
    required this.fontfamily,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: TextAlign.center,
      text,
      style: TextStyle(
        fontFamily: fontfamily,
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}

const labelText = TextStyle(
  fontFamily: 'inter',
  fontSize: 13.0,
  color: kdarkText,
  fontWeight: FontWeight.w400,
);
