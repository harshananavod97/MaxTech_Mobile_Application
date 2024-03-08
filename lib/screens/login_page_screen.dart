import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maxtech/api/App_api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:maxtech/utils/colors.dart';
import 'package:maxtech/widget/rounded_button.dart';
import 'package:maxtech/widget/textStyle.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String token = "";
  bool isLoading = false;
  bool _passwordVisible = true;
  @override
  void initState() {
    gettoken();
    // TODO: implement initState
    super.initState();
  }

  Future<void> gettoken() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      print("token is" + token);
      token = pref.getString('acesstoken').toString();
    });
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordContrller = TextEditingController();
  AutovalidateMode switched = AutovalidateMode.disabled;
  final _EmailformKey = GlobalKey<FormState>();
  final _UserNAMEformKey = GlobalKey<FormState>();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Kwhite,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kPrimary,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UpperSection(),
              Expanded(
                flex: 2,
                child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Kwhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            const TextComponent(
                              color: kdarkText,
                              fontWeight: FontWeight.w700,
                              size: 24,
                              text: 'Let’s get started',
                              fontfamily: 'inter',
                            ),
                            const TextComponent(
                              color: darkGrey,
                              fontWeight: FontWeight.w500,
                              size: 14,
                              text:
                                  'Sign in to access your MaxTach™\naccount and grow your business',
                              fontfamily: 'inter',
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "User Name",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _EmailformKey,
                              autovalidateMode: switched,
                              child: TextFormField(
                                controller: usernameController,
                                keyboardType: TextInputType.name,
                                focusNode: emailFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Your User Name",
                                  filled: true,
                                  fillColor: Kwhite,
                                  contentPadding: EdgeInsets.all(11.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Add your desired border color here
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'UserName is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Password",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _UserNAMEformKey,
                              autovalidateMode: switched,
                              child: TextFormField(
                               
                                controller: passwordContrller,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: passwordFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: InputDecoration(
                                  suffix: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Icon(
                                        // Based on passwordVisible state choose the icon
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                  ),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Your Password",
                                  filled: true,
                                  fillColor: Kwhite,
                                  contentPadding: EdgeInsets.all(11.0),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.blue,
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.0),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors
                                          .grey, // Add your desired border color here
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  }

                                  // Remove any non-digit characters from the phone number

                                  return null; // Return null if the phone number is valid
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            isLoading
                                ? Center(child: CircularProgressIndicator())
                                : RoundedButton(
                                    buttonText: "Sign in",
                                    onPress: () async {
                                      setState(() {
                                        switched = AutovalidateMode.always;
                                        isLoading = true;
                                      });

                                      try {
                                        // Perform your login logic here
                                        await AppApiServices.login(
                                          usernameController.text,
                                          passwordContrller.text,
                                          context,
                                        );

                                        // If login is successful, you can navigate to the next screen or perform other actions
                                      } catch (e) {
                                        // Handle any errors during the login process
                                      } finally {
                                        setState(() {
                                          isLoading =
                                              false; // Set isLoading to false when the login process is complete
                                        });
                                      }
                                    }),
                            const SizedBox(
                              height: 15,
                            ),
                            // const Center(
                            //   child: Text(
                            //     "Or you can",
                            //     style: TextStyle(
                            //       color: Color(0xFF8F8F8F),
                            //       fontWeight: FontWeight.w400,
                            //       fontSize: 12,
                            //       fontFamily: 'inter',
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 12,
                            // ),
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => CreateProfile(),
                            //         ));
                            //   },
                            //   child: const Center(
                            //     child: Text(
                            //       "Create Account",
                            //       style: TextStyle(
                            //         color: Color(0xFF717171),
                            //         fontWeight: FontWeight.w800,
                            //         fontSize: 14,
                            //         fontFamily: 'inter',
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UpperSection extends StatelessWidget {
  const UpperSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            Center(
              child: TextComponent(
                color: Kwhite,
                fontWeight: FontWeight.w700,
                size: 18,
                text: 'MaxTach™',
                fontfamily: 'inter',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: TextComponentOnbording(
                color: Kwhite,
                fontWeight: FontWeight.w600,
                size: 24,
                text: 'Convert MaxTach™\n Connections To Cients',
                fontfamily: 'inter',
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: TextComponentOnbording(
                color: Kwhite,
                fontWeight: FontWeight.w500,
                size: 14,
                text:
                    'Master the art of MaxTach™ outreach and\n messaging to grow your business with\n expert guidance',
                fontfamily: 'inter',
              ),
            ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}

Widget lableField(
  String labelName,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelName,
        style: labelText,
      ),
    ],
  );
}

Widget titleField(
  String titlename,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        titlename,
        style: const TextStyle(
          fontFamily: 'inter',
          fontSize: 15.0,
          color: kdarkText,
          fontWeight: FontWeight.w600,
        ),
      ),
    ],
  );
}
