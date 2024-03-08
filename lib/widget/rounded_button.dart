import 'package:flutter/material.dart';
import 'package:maxtech/utils/colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key, required this.buttonText, required this.onPress});

  final String buttonText;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        // ignore: sort_child_properties_last
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(
                  fontFamily: 'inter', fontSize: 14, color: Kwhite),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: kPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
