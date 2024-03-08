import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maxtech/screens/Customer/customer_page.dart';
import 'package:maxtech/screens/Home/home_page.dart';
import 'package:maxtech/screens/Inventory/Inventory_page.dart';
import 'package:maxtech/screens/Reports/Reports_page.dart';
import 'package:maxtech/screens/login_page_screen.dart';
import 'package:maxtech/utils/colors.dart';
import 'package:maxtech/widget/textStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 5,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Divider(
                  thickness: 2,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                color: const Color.fromARGB(255, 230, 224, 224),
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ));
                  final pref = await SharedPreferences.getInstance();

                  pref.setBool('login', false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 40,
                    ),
                    Text(
                      'Log Out',
                      style: const TextStyle(
                        fontFamily: 'inter',
                        fontSize: 13.0,
                        color: kdarkText,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                color: const Color.fromARGB(255, 230, 224, 224),
              ),
            ],
          ),
        );
      },
    );
  }

  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List _widgetOptions = [
      HomePage(),
      CustomerPage(),
      InventryPage(),
      ReportPage(),
    ];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimary,
          centerTitle: true,
          title: TextComponent(
            color: Kwhite,
            fontWeight: FontWeight.w700,
            size: 25,
            text: 'MaxTach™',
            fontfamily: 'inter',
          ),
          leading: Container(), // This will remove the back icon
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Kwhite,
                ),
                onPressed: () {
                  showBottomSheet(context);
                },
              ),
            ),
          ],
        ),
        body: WillPopScope(
          onWillPop: () async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Do you want to exit from this application ? "),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      // return true;
                    },
                    child: Text("No"),
                  ),
                  TextButton(
                    onPressed: () {
                      SystemNavigator.pop();
                      // return true;
                    },
                    child: Text("Yes"),
                  ),
                ],
              ),
            );
            return false;
          },
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: _widgetOptions[_selectedIndex],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          selectedItemColor: kPrimary,
          unselectedItemColor: Colors.orange,
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: GestureDetector(
                  child: Icon(
                Icons.dashboard,
                size: 25,
                color: _selectedIndex == 0 ? kPrimary : Colors.grey,
              )),
              label: "Dash Board",
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  child: Icon(
                Icons.person,
                size: 30,
                color: _selectedIndex == 1 ? kPrimary : Colors.grey,
              )),
              label: "Customer",
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  child: Icon(
                Icons.inventory,
                size: 25,
                color: _selectedIndex == 2 ? kPrimary : Colors.grey,
              )),
              label: "Inventory",
            ),
            BottomNavigationBarItem(
              icon: GestureDetector(
                  child: Icon(
                Icons.file_copy_sharp,
                size: 25,
                color: _selectedIndex == 3 ? kPrimary : Colors.grey,
              )),
              label: "Reports",
            ),
          ],
        ));
  }
}
