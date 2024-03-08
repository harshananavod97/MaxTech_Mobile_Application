import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:maxtech/api/Add_Customer_Api_End_Point.dart';
import 'package:maxtech/api/App_api_services.dart';
import 'package:maxtech/api/Salescreate_Api_service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:maxtech/utils/colors.dart';
import 'package:maxtech/widget/rounded_button.dart';
import 'package:maxtech/widget/textStyle.dart';
import 'package:intl/intl.dart';

class AddCustomer extends StatefulWidget {
  String customerName = "";
  int customerid;

  AddCustomer(
      {super.key, required this.customerName, required this.customerid});

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  List<dynamic> productlist = [
    "Orderd",
    "Packed",
    "Shiped",
    "Deliverd",
    "Cancled",
  ];
  String token = "";
  bool isLoading = false;
  @override
  void initState() {
    customernaameController.text = widget.customerName;
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

  late Future<List<String>> _dropdownData;

  Future<List<Map<String, dynamic>>> getbusines() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://newmaxtechnology.clickypos.com/connector/api/customer/assgin/user'),
        headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA3MjBjYjM4NWI1ZDM5MDM1NjUzNmIyMGQzM2FlNTA4OTZjYjUwMTQzMzhkNWYzYWFlYTUwMjU5Yzg2YmZkYzAyZmQzOGMxNDFmYTE2MGY1In0.eyJhdWQiOiIxMCIsImp0aSI6IjA3MjBjYjM4NWI1ZDM5MDM1NjUzNmIyMGQzM2FlNTA4OTZjYjUwMTQzMzhkNWYzYWFlYTUwMjU5Yzg2YmZkYzAyZmQzOGMxNDFmYTE2MGY1IiwiaWF0IjoxNzA2NTEyMzIxLCJuYmYiOjE3MDY1MTIzMjEsImV4cCI6MTczODEzNDcyMSwic3ViIjoiMSIsInNjb3BlcyI6W119.Ut8kcatFaP9P6qUEsxPWL2DjELXRuaBkdVqdnOx_dN_0mZDdRYManjkux4JVrYKW4hPCFaGWLMi9V-TK5Y61-9V4_u7AemrwmuON45x-0pxhFiuIf3i3dJkFoi9qudE21NYRTS1XhZntk7pR7WXJQlFVuEzFFmOpHT1BlrSewozja_LqEwmr63w2rC8NXrqvXs5axQ7hflEVKLrbDrFHTL704cfugRDcl-3WyDB6woe90Wa2Hy_c8EzPlIguBrrg16PjBe10NwLVHouUku6qcMyIHBvcQeDXgUiztB6bOSBo1C42C5BTIThlS0RfuF5qp68qvbJo774AbnEouSsxY83gw0K-4mL0zB1YOH6okD1rWrwwDRdJwX9hVCEzI2n393OWWcwBYvP2WZIy_249ncCzz_RdmVcCtaewcm9VL3FvJi_9g02wSduS0-RKX0HmgSAh_c4MGamVYOJOrQYyp3quPMasSOFkNBeJqOeMm02jERJI23wtqKfcNq_UdbsWFGIHYC_nlLw3CmWD4-WQG3p2h1vZ5Ohq9dDyRywYUvIeY_WhVJOF5ryJJPqO1Y4bgczpvlUFR3nYYxZywA3MPXbANWy_fG9RDV6SoeQKoKlRWpIY3Q3ETUManoYwKe4V1Go-eaP56xDHtGeZ5TMF4268PMc8-tco_dcxG1umI8o"
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        List<Map<String, dynamic>> products = [];

        for (var item in data["data"]) {
          products.add({
            "id": item["id"],
            "name": item["username"],
          });
        }

        return products;
      } else {
        throw Exception('Failed to load dropdown data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load dropdown data');
    }
  }

  String? selectedProductName;
  String? selectedProductId;

  TextEditingController customernaameController = TextEditingController();
  TextEditingController satesDateTimeController = TextEditingController();
  TextEditingController mobilenumbercontroller = TextEditingController();
  TextEditingController openingbalanceController = TextEditingController();
  TextEditingController alternatecontactnumber = TextEditingController();
  TextEditingController lanlinenumbercontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController customergroup = TextEditingController();
  TextEditingController taxnumbercontroller = TextEditingController();
  TextEditingController disconttime = TextEditingController();
  TextEditingController creditcontrollercontroller = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController Zipcode = TextEditingController();
  TextEditingController prefix = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController customfiled1 = TextEditingController();
  TextEditingController customfiled2 = TextEditingController();
  TextEditingController customfiled3 = TextEditingController();
  TextEditingController customfiled4 = TextEditingController();
  TextEditingController businessname = TextEditingController();

  final _contactTypeController = TextEditingController();

  final _discoutamountcontroller = TextEditingController();

  final _discounttype = TextEditingController();

  AutovalidateMode switched = AutovalidateMode.disabled;

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey6 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey7 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey8 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey9 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey10 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey11 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey12 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey13 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey14 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey15 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey16 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey17 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey18 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey19 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey20 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey21 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey22 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey23 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey24 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey25 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey26 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey27 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey28 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey29 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey30 = GlobalKey<FormState>();

  DateTime? selectedDate;

  final emailFocusNode = FocusNode();

  final creditFocusNode = FocusNode();
  final discounttypeFocusNode = FocusNode();
  final discountFocusNode = FocusNode();
  final invoicenumFocusNode = FocusNode();
  final address1FocusNode = FocusNode();
  final address2FocusNode = FocusNode();
  final cityFocusNode = FocusNode();
  final stateFocusNode = FocusNode();
  final countryFocusNode = FocusNode();
  final zipcodeFocusNode = FocusNode();
  final openingbalanceFocusNode = FocusNode();
  final taxnumFocusNode = FocusNode();
  final landlinenumberFocusNode = FocusNode();
  final customergroupFocusNode = FocusNode();
  final emailfocusnode = FocusNode();
  final alternatenumber = FocusNode();
  final shipingAddress = FocusNode();
  final mobile = FocusNode();
  final passwordFocusNode = FocusNode();
  final businessnameFocusNode = FocusNode();

  final firstnameFocusNode = FocusNode();
  final middlenameFocusNode = FocusNode();
  final lastnameFocusNode = FocusNode();
  final dobFocusNode = FocusNode();
  final customfiled1FocusNode = FocusNode();
  final customfiled2FocusNode = FocusNode();
  final customfiled3FocusNode = FocusNode();
  final customfiled4FocusNode = FocusNode();
  final pfrefux = FocusNode();
  final businessnames = FocusNode();
  bool selectindividual = true;

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
              const UpperSection(),
              Expanded(
                flex: 4,
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
                              color: darkGrey,
                              fontWeight: FontWeight.w500,
                              size: 14,
                              text: 'Customer Details :',
                              fontfamily: 'inter',
                            ),
                            lableField(
                              "Contact type",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey6,
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    DropdownButtonFormField<String>(
                                      autovalidateMode: switched,
                                      onChanged: (String? value) {
                                        setState(() {
                                          _contactTypeController.text =
                                              value.toString();
                                        });
                                        // Handle the selected value here if needed
                                        print('Selected value: $value');
                                      },
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.person),
                                        hintStyle: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: Color(0xFFBCBCBC),
                                        ),
                                        hintText: 'Please Select',
                                        filled: true,
                                        fillColor: Colors.white, // ,
                                        contentPadding: EdgeInsets.all(11.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 248, 249, 249),
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      items: [
                                        "supliers",
                                        "customer",
                                        "both",
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                        );
                                      }).toList(),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectindividual = true;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        color: selectindividual
                                            ? Colors.blue
                                            : Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Individual',
                                  style: const TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 13.0,
                                    color: kdarkText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectindividual = false;
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        color: selectindividual
                                            ? Colors.white
                                            : Colors.blue,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    height: 15,
                                    width: 15,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Business',
                                  style: const TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 13.0,
                                    color: kdarkText,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            lableField(
                              "Customer Group",
                            ),
                            Form(
                              key: _formKey9,
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    DropdownButtonFormField<String>(
                                      autovalidateMode: switched,
                                      onChanged: (String? value) {
                                        setState(() {
                                          customergroup.text = value.toString();
                                        });
                                        // Handle the selected value here if needed
                                        print('Selected value: $value');
                                      },
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.group),
                                        hintStyle: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: Color(0xFFBCBCBC),
                                        ),
                                        hintText: 'Select Customer Group',
                                        filled: true,
                                        fillColor: Colors.white, // ,
                                        contentPadding: EdgeInsets.all(11.0),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 248, 249, 249),
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(5.0),
                                          ),
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      items: [
                                        "40% B Mobile ",
                                        "50% A Mobile",
                                        "30% C Mobile",
                                        "20% D Mobile",
                                        "10% E Mobile",
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                        );
                                      }).toList(),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please select';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            selectindividual
                                ? Container()
                                : lableField(
                                    "Business Name",
                                  ),
                            selectindividual
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : Container(),
                            selectindividual
                                ? Container()
                                : Form(
                                    key: _formKey25,
                                    autovalidateMode: switched,
                                    child: TextFormField(
                                      readOnly: false,
                                      controller: businessname,
                                      keyboardType: TextInputType.emailAddress,
                                      focusNode: businessnameFocusNode,
                                      style: const TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14,
                                        color: kdarkText,
                                      ),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.business),
                                        hintStyle: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: Color(0xFFBCBCBC),
                                        ),
                                        hintText: "Business Name",
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
                                          return 'Business Name is required';
                                        }

                                        return null;
                                      },
                                    ),
                                  ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Assigned to",
                            ),
                            Form(
                              key: _formKey18,
                              autovalidateMode: switched,
                              child: Container(
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 5),
                                    FutureBuilder<List<Map<String, dynamic>>>(
                                      future: getbusines(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              'Error: ${snapshot.error}');
                                        } else {
                                          return Column(
                                            children: [
                                              DropdownButtonFormField<String>(
                                                value:
                                                    selectedProductName, // Add this line
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                onChanged: (String? value) {
                                                  var selectedProduct =
                                                      snapshot.data?.firstWhere(
                                                    (product) =>
                                                        product["name"] ==
                                                        value,
                                                    orElse: () =>
                                                        {"id": 0, "name": ""},
                                                  );

                                                  setState(() {
                                                    customergroup.text =
                                                        value.toString();
                                                    selectedProductName = value;
                                                    selectedProductId =
                                                        selectedProduct?["id"]
                                                            .toString(); // Convert to String
                                                  });

                                                  print(
                                                      'Selected value: $value, Selected ID: $selectedProductId');
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: "Please Select",
                                                  prefixIcon: Icon(Icons.group),
                                                  hintStyle: TextStyle(
                                                    fontFamily: 'inter',
                                                    fontSize: 14,
                                                    color: Color(0xFFBCBCBC),
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  contentPadding:
                                                      EdgeInsets.all(11.0),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Color.fromARGB(
                                                          255, 248, 249, 249),
                                                      width: 2.0,
                                                    ),
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(5.0),
                                                    ),
                                                    borderSide: BorderSide(
                                                      color: Colors.grey,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                                items: snapshot.data
                                                        ?.map((product) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: product["name"],
                                                        child: Text(
                                                            product["name"],
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                      );
                                                    }).toList() ??
                                                    [],
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Please select';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            selectindividual
                                ? lableField(
                                    "Prefix",
                                  )
                                : Container(),
                            selectindividual
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : Container(),
                            selectindividual
                                ? Form(
                                    key: _formKey19,
                                    child: Container(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          DropdownButtonFormField<String>(
                                            autovalidateMode: switched,
                                            onChanged: (String? value) {
                                              setState(() {
                                                prefix.text = value.toString();
                                              });
                                              // Handle the selected value here if needed
                                              print('Selected value: $value');
                                            },
                                            decoration: const InputDecoration(
                                              prefixIcon: Icon(Icons.person),
                                              hintStyle: TextStyle(
                                                fontFamily: 'inter',
                                                fontSize: 14,
                                                color: Color(0xFFBCBCBC),
                                              ),
                                              hintText: 'Please Select',
                                              filled: true,
                                              fillColor: Colors.white, // ,
                                              contentPadding:
                                                  EdgeInsets.all(11.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 248, 249, 249),
                                                  width: 2.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            items: [
                                              "Mr",
                                              "Miss",
                                              "Mrs",
                                            ].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 10,
                            ),
                            selectindividual
                                ? lableField(
                                    "First Name",
                                  )
                                : Container(),
                            selectindividual
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : Container(),
                            selectindividual
                                ? Form(
                                    key: _formKey20,
                                    autovalidateMode: switched,
                                    child: TextFormField(
                                      readOnly: false,
                                      controller: firstName,
                                      keyboardType: TextInputType.emailAddress,
                                      focusNode: firstnameFocusNode,
                                      style: const TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14,
                                        color: kdarkText,
                                      ),
                                      decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.location_on_rounded),
                                        hintStyle: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: Color(0xFFBCBCBC),
                                        ),
                                        hintText: "Address Line 2",
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
                                          return 'First Name is required';
                                        }

                                        return null;
                                      },
                                    ),
                                  )
                                : Container(),
                            const SizedBox(
                              height: 10,
                            ),
                            selectindividual
                                ? lableField(
                                    "Middle Name",
                                  )
                                : Container(),
                            selectindividual
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : Container(),
                            selectindividual
                                ? Form(
                                    key: _formKey21,
                                    autovalidateMode: switched,
                                    child: TextFormField(
                                      readOnly: false,
                                      controller: middleName,
                                      keyboardType: TextInputType.emailAddress,
                                      focusNode: middlenameFocusNode,
                                      style: const TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14,
                                        color: kdarkText,
                                      ),
                                      decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.location_on_rounded),
                                        hintStyle: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: Color(0xFFBCBCBC),
                                        ),
                                        hintText: "Middle Name",
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
                                          return 'Middle Name is required';
                                        }

                                        return null;
                                      },
                                    ),
                                  )
                                : Container(),
                            selectindividual
                                ? lableField(
                                    "Last Name",
                                  )
                                : Container(),
                            selectindividual
                                ? const SizedBox(
                                    height: 10,
                                  )
                                : Container(),
                            selectindividual
                                ? Form(
                                    key: _formKey23,
                                    autovalidateMode: switched,
                                    child: TextFormField(
                                      readOnly: false,
                                      controller: lastName,
                                      keyboardType: TextInputType.emailAddress,
                                      focusNode: lastnameFocusNode,
                                      style: const TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14,
                                        color: kdarkText,
                                      ),
                                      decoration: const InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.location_on_rounded),
                                        hintStyle: TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: Color(0xFFBCBCBC),
                                        ),
                                        hintText: "Last Name",
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
                                          return 'Last Name is required';
                                        }

                                        return null;
                                      },
                                    ),
                                  )
                                : Container(),
                            lableField(
                              "Mobile No",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey5,
                              autovalidateMode: switched,
                              child: TextFormField(
                                maxLength: 10,
                                controller: mobilenumbercontroller,
                                keyboardType: TextInputType.number,
                                focusNode: mobile,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.call),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Enter Mobile Number",
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
                                      color: Colors.grey,
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Mobile number is required';
                                  }
                                  // Add any additional validation logic if needed
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Alternate contact number",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey8,
                              autovalidateMode: switched,
                              child: TextFormField(
                                maxLength: 10,
                                readOnly: false,
                                controller: alternatecontactnumber,
                                keyboardType: TextInputType.number,
                                focusNode: alternatenumber,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.call),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Enter Alternate contact number",
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
                                    return 'Alternate contact number is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Landline",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey10,
                              autovalidateMode: switched,
                              child: TextFormField(
                                maxLength: 10,
                                readOnly: false,
                                controller: lanlinenumbercontroller,
                                keyboardType: TextInputType.number,
                                focusNode: landlinenumberFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.call),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Enter Land  Number",
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
                                    return 'Landline number is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Email",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey11,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: emailcontroller,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: emailFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Enter Email",
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
                                    return 'Email is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField("Date of Birth"),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key:
                                  _formKey22, // Make sure to define a new GlobalKey for the DOB form
                              autovalidateMode: switched,
                              child: GestureDetector(
                                onTap: () {
                                  _selectDate(
                                      context); // Function to show date picker
                                },
                                child: AbsorbPointer(
                                  child: TextFormField(
                                    readOnly:
                                        true, // Make the text field read-only
                                    controller:
                                        dob, // Use a TextEditingController for the DOB
                                    keyboardType: TextInputType.datetime,
                                    style: const TextStyle(
                                      fontFamily: 'inter',
                                      fontSize: 14,
                                      color: kdarkText,
                                    ),
                                    decoration: const InputDecoration(
                                      prefixIcon: Icon(Icons.calendar_today),
                                      hintStyle: TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14,
                                        color: Color(0xFFBCBCBC),
                                      ),
                                      hintText: "Date of Birth",
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
                                          color: Colors.grey,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Date of Birth is required';
                                      }
                                      // Add additional validation if needed
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Tax number",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey2,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: taxnumbercontroller,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: taxnumFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.card_giftcard),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Tax number Number",
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
                                    return 'Tax number is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Operning Balance",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey3,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: openingbalanceController,
                                keyboardType: TextInputType.number,
                                focusNode: openingbalanceFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.money),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Operning Balance",
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
                                    return 'Operning Balance is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Pay term",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 4, right: 2),
                                  child: Container(
                                    width: 200,
                                    height: 50,
                                    child: Form(
                                      key: _formKey17,
                                      child: TextFormField(
                                        readOnly: false,
                                        controller: _discoutamountcontroller,
                                        keyboardType: TextInputType.name,
                                        focusNode: discountFocusNode,
                                        style: const TextStyle(
                                          fontFamily: 'inter',
                                          fontSize: 14,
                                          color: kdarkText,
                                        ),
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.balance),
                                          hintStyle: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 14,
                                            color: Color(0xFFBCBCBC),
                                          ),
                                          hintText: "Pay term",
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
                                            return 'Pay term is required';
                                          }

                                          return null;
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 140,
                                  child: Form(
                                    key: _formKey7,
                                    child: Container(
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 5),
                                          DropdownButtonFormField<String>(
                                            autovalidateMode: switched,
                                            onChanged: (String? value) {
                                              setState(() {
                                                _discounttype.text =
                                                    value.toString();
                                              });
                                              // Handle the selected value here if needed
                                              print('Selected value: $value');
                                            },
                                            decoration: const InputDecoration(
                                              hintStyle: TextStyle(
                                                fontFamily: 'inter',
                                                fontSize: 14,
                                                color: Color(0xFFBCBCBC),
                                              ),
                                              hintText: 'Select',
                                              filled: true,
                                              fillColor: Colors.white, // ,
                                              contentPadding:
                                                  EdgeInsets.all(11.0),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                                borderSide: BorderSide(
                                                  color: Color.fromARGB(
                                                      255, 248, 249, 249),
                                                  width: 2.0,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0),
                                                ),
                                                borderSide: BorderSide(
                                                  color: Colors.grey,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            items: [
                                              "Months ",
                                              "Days",
                                            ].map((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value,
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              );
                                            }).toList(),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Please select';
                                              }
                                              return null;
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Credit Limit",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey4,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: creditcontrollercontroller,
                                keyboardType: TextInputType.number,
                                focusNode: creditFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.money),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Credit Limit",
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
                                    return 'Credit Limit is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Address Line 1",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey1,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: address1,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: address1FocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.location_on_rounded),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Address Line 1",
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
                                    return 'Address Line 1 is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Address Line 2",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey12,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: address2,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: address2FocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.location_on_rounded),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Address Line 2",
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
                                    return 'Address Line 2 is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "City",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey13,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: city,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: cityFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.location_city),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "City",
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
                                    return 'City is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "State",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey14,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: state,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: stateFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.location_on_rounded),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "State",
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
                                    return 'State  is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Country",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey15,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: country,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: countryFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.map),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Country",
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
                                    return 'Country is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Zip Code",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey16,
                              autovalidateMode: switched,
                              child: TextFormField(
                                readOnly: false,
                                controller: Zipcode,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: zipcodeFocusNode,
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 14,
                                  color: kdarkText,
                                ),
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.location_on_rounded),
                                  hintStyle: TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: Color(0xFFBCBCBC),
                                  ),
                                  hintText: "Zip Code",
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
                                    return 'Zip Code is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Custom Field 1",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey24,
                              child: TextFormField(
                                readOnly: false,
                                controller: customfiled1,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: customfiled1FocusNode,
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
                                  hintText: "Custom Field 1",
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
                                    return 'Custom Field 1 is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Custom Field 2",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey27,
                              child: TextFormField(
                                readOnly: false,
                                controller: customfiled2,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: customfiled2FocusNode,
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
                                  hintText: "Custom Field 2",
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
                                    return 'Custom Field 2 is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Custom Field 3",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey28,
                              child: TextFormField(
                                readOnly: false,
                                controller: customfiled3,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: customfiled3FocusNode,
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
                                  hintText: "Custom Field 3",
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
                                    return 'Custom Field 3 is required';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Custom Field 4",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Form(
                              key: _formKey29,
                              child: TextFormField(
                                readOnly: false,
                                controller: customfiled4,
                                keyboardType: TextInputType.emailAddress,
                                focusNode: customfiled4FocusNode,
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
                                  hintText: "Custom Field 4",
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
                                    return 'Custom Field 4';
                                  }

                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : RoundedButton(
                                    buttonText: "Add Customer",
                                    onPress: () async {
                                      setState(() {
                                        switched = AutovalidateMode.always;
                                      });
                                      String openingBalanceText =
                                          openingbalanceController.text;
                                      double openingBalance =
                                          double.parse(openingBalanceText);

                                      await CustomeCreateEndPoint.postData(
                                          _contactTypeController.text,
                                          businessname.text ?? "",
                                          prefix.text,
                                          firstName.text ?? "",
                                          middleName.text ?? "",
                                          lastName.text ?? "",
                                          taxnumbercontroller.text, //tax num
                                          _discounttype.text,
                                          mobilenumbercontroller.text,
                                          lanlinenumbercontroller.text,
                                          alternatecontactnumber.text,
                                          address1.text,
                                          address2.text,
                                          city.text,
                                          state.text,
                                          country.text,
                                          Zipcode.text,
                                          "", //group id

                                          dob.text ?? "",
                                          customfiled1.text,
                                          customfiled2.text,
                                          customfiled3.text,
                                          customfiled4.text,
                                          emailcontroller.text,
                                          openingBalance,
                                          context);

                                      try {
                                        // Perform your login logic here

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dob.text) {
      setState(() {
        dob.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }
}

class UpperSection extends StatelessWidget {
  const UpperSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Expanded(
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
                text: 'Add New Customer\n Connections To Cients',
                fontfamily: 'inter',
              ),
            ),
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
