import 'package:flutter/material.dart';
import 'package:maxtech/utils/colors.dart';
import 'package:maxtech/widget/textStyle.dart';


class PendingApproval extends StatefulWidget {
  const PendingApproval({super.key});

  @override
  State<PendingApproval> createState() => _PendingApprovalState();
}

class _PendingApprovalState extends State<PendingApproval> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Kwhite,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Kwhite,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Kwhite,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: kdarkText,
                size: 25,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset('assets/images/Hourglass.png', ),
                SizedBox(
                  height: 16,
                ),
                const TextComponent(
                  color: kdarkText,
                  fontWeight: FontWeight.w700,
                  size: 24,
                  text: 'Pending Approval',
                  fontfamily: 'inter',
                ),
                const TextComponent(
                  color: darkGrey,
                  fontWeight: FontWeight.w500,
                  size: 14,
                  text:
                      'Your account is pending approval. Once\napproved, you’ll get an email. You can then\ncome back and create a profile here.',
                  fontfamily: 'inter',
                ),
                SizedBox(
                  height: 20,
                ),
                const TextComponent(
                  color: darkGrey,
                  fontWeight: FontWeight.w500,
                  size: 14,
                  text:
                      'Keep the app installed and you will get a push notification that you are approved!',
                  fontfamily: 'inter',
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
