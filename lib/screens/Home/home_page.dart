import 'package:flutter/material.dart';
import 'package:maxtech/api/App_api_services.dart';
import 'package:maxtech/api/Dash_Board_Data.dart';
import 'package:maxtech/screens/Customer/customer_page.dart';
import 'package:maxtech/utils/colors.dart';
import 'package:maxtech/widget/rounded_button.dart';
import 'package:maxtech/widget/textStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getShortForm(double number) {
    var shortForm = "";
    if (number != null) {
      if (number < 1000) {
        shortForm = number.toString();
      } else if (number >= 1000 && number < 1000000) {
        shortForm = (number / 1000).toStringAsFixed(1) + " K";
      } else if (number >= 1000000 && number < 1000000000) {
        shortForm = (number / 1000000).toStringAsFixed(1) + " M";
      } else if (number >= 1000000000 && number < 1000000000000) {
        shortForm = (number / 1000000000).toStringAsFixed(1) + " B";
      }
    }
    return shortForm;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  String Token = "";

  Future<void> gettoken() async {
    final pref = await SharedPreferences.getInstance();

    Token = await pref.getString('acesstoken').toString();
  }

  String selectedValue = 'sales';
  String selectedText = '1';
  DateTime selectedDateTime = DateTime.now();
  DateTime returnselectedDateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = getFormattedDate(selectedDateTime);
    String salesformattedDate = getsalesFormattedDate(returnselectedDateTime);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              color: kPrimary,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //
                    const TextComponent(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      size: 20,
                      text: 'Hi Admin',
                      fontfamily: 'inter',
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextComponent(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              size: 15,
                              text: 'Start Date',
                              fontfamily: 'inter',
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    _selectDateTime(context);
                                  },
                                  child: TextComponent(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    size: 20,
                                    text: formattedDate,
                                    fontfamily: 'inter',
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _selectDateTime(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 25),
                              child: TextComponent(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                size: 15,
                                text: 'End Date',
                                fontfamily: 'inter',
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _salesselectDateTime(context);
                                  },
                                  child: TextComponent(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    size: 20,
                                    text: salesformattedDate,
                                    fontfamily: 'inter',
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      _salesselectDateTime(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),

                    Expanded(
                      child: StreamBuilder<List<DashBord>>(
                        stream: DashBoardService.getdash(
                                formattedDate, salesformattedDate, "2")
                            .asStream(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }

                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          List<DashBord> dashbordList = snapshot.data!;

                          // Use the dashbordList to build your UI
                          return ListView.builder(
                            itemCount: dashbordList.length,
                            itemBuilder: (context, index) {
                              DashBord dash = dashbordList[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BalanceValueContainer(
                                        valuesize: 15,
                                        titlesize: 10,
                                        Title: "TOTAL SALES",
                                        Values: getShortForm(double.parse(
                                          dash.total_sell.toString(),
                                        )),
                                        icon: Icons.shopping_cart,
                                      ),
                                      BalanceValueContainer(
                                        valuesize: 15,
                                        titlesize: 10,
                                        Title: "TOTAL PURCHASE",
                                        Values: getShortForm(double.parse(
                                          dash.total_purchase,
                                        )),
                                        icon: Icons.money,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      BalanceValueContainer(
                                        valuesize: 15,
                                        titlesize: 10,
                                        Title: "TOTAL SELL\n RETURN",
                                        Values: getShortForm(double.parse(
                                            dash.total_sell_return)),
                                        icon: Icons.autorenew_sharp,
                                      ),
                                      BalanceValueContainer(
                                        valuesize: 15,
                                        titlesize: 10,
                                        Title: "TOTAL PURCHASE\n RETURN",
                                        Values: getShortForm(double.parse(
                                          dash.total_purchase_return,
                                        )),
                                        icon: Icons.auto_mode_sharp,
                                      ),
                                    ],
                                  )
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Admin Name

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 30),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CustomerPage()));
                          },
                          child: RoundedButton(
                            color: Color.fromARGB(255, 125, 202, 238),
                            icon: Icons.balance_sharp,
                            text: "Add Sales    ",
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {},
                          child: RoundedButton(
                            color: Color.fromARGB(255, 125, 202, 238),
                            icon: Icons.attach_money,
                            text: "  Add Payment",
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getSelectedText(String selectedValue) {
    switch (selectedValue) {
      case 'sales':
        return '1';
      case 'Sales Return':
        return '2';
      default:
        return 'Select an option';
    }
  }

  String getFormattedDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
    // ${dateTime.hour}:${dateTime.minute
  }

  String getsalesFormattedDate(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
    // ${dateTime.hour}:${dateTime.minute
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Keep the time part unchanged
      DateTime newDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        selectedDateTime.hour,
        selectedDateTime.minute,
      );

      setState(() {
        selectedDateTime = newDateTime;
      });
    }
  }

  Future<void> _salesselectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: returnselectedDateTime,
      firstDate: DateTime(2000),
      // Adjust the lastDate to allow selecting future dates
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      // Keep the time part unchanged
      DateTime newDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
      );

      setState(() {
        returnselectedDateTime = newDateTime;
      });
    }
  }
}

class RoundedButton extends StatelessWidget {
  Color color;
  IconData icon;
  String text;
  RoundedButton({
    required this.color,
    required this.icon,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 14,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(50), color: color),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: Icon(
                icon,
                size: 25,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            TextComponent(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              size: 20,
              text: text,
              fontfamily: 'inter',
            ),
          ],
        ),
      ),
    );
  }
}

class BalanceValueContainer extends StatelessWidget {
  IconData icon;
  String Title;
  String Values;
  double titlesize;
  double valuesize;

  BalanceValueContainer({
    required this.Title,
    required this.Values,
    required this.icon,
    required this.titlesize,
    required this.valuesize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 * 0.85,
      height: MediaQuery.of(context).size.width / 5,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 125, 202, 238),
                  borderRadius: BorderRadius.circular(50)),
              child: Icon(icon),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextComponent(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  size: titlesize,
                  text: Title,
                  fontfamily: 'inter',
                ),
                TextComponent(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  size: valuesize,
                  // ignore: prefer_interpolation_to_compose_strings
                  text: 'RS .' + Values,
                  fontfamily: 'inter',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
