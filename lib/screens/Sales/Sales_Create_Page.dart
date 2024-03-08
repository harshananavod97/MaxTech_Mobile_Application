import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:maxtech/api/App_api_services.dart';
import 'package:maxtech/api/Salescreate_Api_service.dart';
import 'package:maxtech/constant/api_consts.dart';
import 'package:maxtech/models/CustomerDetails_model.dart';
import 'package:maxtech/screens/Customer/AddCustomerPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:maxtech/utils/colors.dart';
import 'package:maxtech/widget/rounded_button.dart';
import 'package:maxtech/widget/textStyle.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SalesCreate extends StatefulWidget {
  String paymentmethodvalue = '';

  String customerName = "";
  int customerid;

  SalesCreate(
      {super.key, required this.customerName, required this.customerid});

  @override
  State<SalesCreate> createState() => _SalesCreateState();
}

class _SalesCreateState extends State<SalesCreate> {
  var count = 0;
  @override
  void initState() {
    declare();
    getAccounts();
    getLocationAccounts();

    gettoken();

    // TODO: implement initState
    super.initState();
  }

  void declare() {
    setState(() {
      customernaameController.text = widget.customerName;
      _multipleCardammount.text = '0.0';
      accountId = 0;
      _cardnumber.text = "";
      _cardholdername.text = "";
      _cardTransactioNumumber.text = "";
      _cardType.text = "";
      _cardMonth.text = "";
      _cardYear.text = "";
      _securityCode.text = "";
      _bankTransferNumber.text = "";
      _paymentNote.text = "";
      _checkNumber.text = "";
      _paymentmethod.text = "cash";
    });
  }

  List<Map<String, dynamic>> productList = [];
  List<Map<String, dynamic>> paymentList = [];
  bool edit = false;

  int quantity = 1;
  List<dynamic> productlist = [
    "Orderd",
    "Packed",
    "Shiped",
    "Deliverd",
    "Cancled",
  ];
  String token = "";
  bool isLoading = false;

  Future<void> gettoken() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      print("token is" + token);
      token = pref.getString('acesstoken').toString();
    });
  }

  String? selectedProductName;
  String? selectedProductId;
  String? sellprice;

  TextEditingController customernaameController = TextEditingController();
  TextEditingController satesDateTimeController = TextEditingController();
  TextEditingController InvoiceNumberController = TextEditingController();

  final _paymentmethod = TextEditingController();

  final _discouttypecontroller = TextEditingController();
  final _discoutamountcontroller = TextEditingController();
  final _salediscoutamountcontroller = TextEditingController();

  // final _shipingdetails = TextEditingController();
  final _shipingaddresscontroller = TextEditingController();
  final _shipingstatuscontroller = TextEditingController();

  void clearFunction() {
    setState(() {
      _shipingstatuscontroller.clear();
      _shipingstatuscontroller.clear();
      _salediscoutamountcontroller.clear();
      _discouttypecontroller.clear();
      _discoutamountcontroller.clear();
      selectedProductValues.clear();
      ismultiplepayment = false;
      paymentList.clear();
    });
  }

  AutovalidateMode switched = AutovalidateMode.disabled;
  final _customernameFormkey = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey1 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey3 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey6 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey5 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey4 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey7 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey8 = GlobalKey<FormState>();

  final GlobalKey<FormState> _formKey10 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey11 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey12 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey13 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey14 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey15 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey16 = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey17 = GlobalKey<FormState>();
  DateTime? selectedDate;

  final emailFocusNode = FocusNode();
  final invoicenumFocusNode = FocusNode();
  final shipingAddress = FocusNode();
  final passwordFocusNode = FocusNode();
  final multipleAmountFocusNode = FocusNode();
  final multipleAccountFocusNode = FocusNode();
  final multiplepaymentMethodFocusNode = FocusNode();
  final f1 = FocusNode();
  final f2 = FocusNode();
  final f3 = FocusNode();
  final f4 = FocusNode();
  final f5 = FocusNode();
  final f6 = FocusNode();
  final f7 = FocusNode();
  final f8 = FocusNode();
  final f9 = FocusNode();
  final f10 = FocusNode();
  final f11 = FocusNode();
  final f12 = FocusNode();
  final f13 = FocusNode();
  final f14 = FocusNode();
  final f15 = FocusNode();
  final f16 = FocusNode();
  final f17 = FocusNode();

  //searchcontroller

  TextEditingController search = TextEditingController();

  Future<List<ProductInfo>> fetchProductInfo(String pattern) async {
    final url =
        'https://newmaxtechnology.clickypos.com/connector/api/new_product';
    final queryParams = {
      'location_id': locationAccountValueId.toString(),
      'name_or_sku': pattern
    };

    final uri = Uri.https(
      'newmaxtechnology.clickypos.com',
      '/connector/api/new_product',
      queryParams,
    );

    final response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Authorization":
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0In0.eyJhdWQiOiIxMCIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0IiwiaWF0IjoxNzA4MDg0MzYxLCJuYmYiOjE3MDgwODQzNjEsImV4cCI6MTczOTcwNjc2MSwic3ViIjoiMSIsInNjb3BlcyI6W119.nE6jpMdFZR10duRar6fXe3r4zbWk3kR1Tio-nb2tfE385cgcZ5jJhyYBz7bsTt4O6E8GlDcrRSy01ASHc5Yss-eIstz37g9U3d5RkENI1BQ9SGZAVhFX1am9C5HIB_DW4Lcs9HF8IrwZ7KVnVHIV94azoKSlhTZ6v0soNIjVDMDOzQOOPqe6fY9uNYpIxR1m4kJ-iUYWn_8gyGZlHq6K8G1NV1UFL0bkpakES5_owjLJgGSG_ljhmGIe6Qx1ymlRTALK2vB6sfOM0W0SO5T3lYEwSv_kgb79s3UwP5K-ib3k8H8LZkAa1Hll9oTUAGgKHAfCxBUs0Z39RZYx5kgKrCPhe3NqwED5phWQzCg-LofAPOfZS-T6P8vzgnvW9lH151nQHMeM1l5_fn16GeL21etW2Zu7iPyZtE19YRg1yRRD497eAPA3PyK_hRQMRLgaliwzjmrnuTxcD8HA0y8R0EAGqxO8hNlrufDaPNLsbCFTkG-02hwh-OHL7TdDyt2tBIlFNWhHwytRQtFS96isbJ2P3gzg8rooYstRE3j6sjMasMeETtJC7IQmCAwYPJqhADe7MpuFW_fjCemHi9gpOaOGSTyygOXUlDnRrh60ZxJaH8eJOu7q4KaiDDk88Sad82JiDU6alUDopNfxzJunwQX0Z8eqYqBHu4cwfAgNlCI",
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      final List<ProductInfo> productInfoList = data.map((productData) {
        return ProductInfo(
            picestype: productData['unit']["actual_name"],
            variationid: productData['product_variations'][0]["id"],
            productName: productData['name'],
            sellPriceIncTax: productData['product_variations'][0]['variations']
                [0]['sell_price_inc_tax'],
            productId: productData['id'],
            productquantity: productData['product_variations'][0]['variations']
                [0]['variation_location_details'][0]['qty_available']);
      }).toList();

      return productInfoList;
    } else {
      throw Exception('Failed to load product information');
    }
  }

  List<Map<dynamic, dynamic>> selectedProductValues = [];

  int totalQuantity = 0;
  int calculateTotalQuantity(
      List<Map<dynamic, dynamic>> selectedProductValues) {
    totalQuantity = 0;
    for (int i = 0; i < selectedProductValues.length; i++) {
      totalQuantity = totalQuantity +
          int.parse(selectedProductValues[i]['quntity'].toString());
    }

    return totalQuantity;
  }

  double totalamount = 0;
  double calculateTotalAmount(
      List<Map<dynamic, dynamic>> selectedProductValues) {
    totalamount = 0;
    for (int i = 0; i < selectedProductValues.length; i++) {
      totalamount = totalamount +
          double.parse(
                  selectedProductValues[i]['sell_price_inc_tax'].toString()) *
              int.parse(selectedProductValues[i]['quntity'].toString());
    }

    return totalamount;
  }

  double totaldiscount = 0;
  double calculateDiscountAmount(
      List<Map<dynamic, dynamic>> selectedProductValues) {
    totaldiscount = 0;
    for (int i = 0; i < selectedProductValues.length; i++) {
      totaldiscount = totaldiscount +
          double.parse(selectedProductValues[i]['discount'].toString());
    }

    return totaldiscount;
  }

  //Botom Sheet Display

  void showBottomSheet(BuildContext context, int i) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                lableField(
                  "Discount Amount",
                ),
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey13,
                  autovalidateMode: switched,
                  child: TextFormField(
                    readOnly: false,
                    controller: _discoutamountcontroller,
                    keyboardType: TextInputType.number,
                    focusNode: emailFocusNode,
                    style: const TextStyle(
                      fontFamily: 'inter',
                      fontSize: 14,
                      color: kdarkText,
                    ),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.price_change),
                      hintStyle: TextStyle(
                        fontFamily: 'inter',
                        fontSize: 14,
                        color: Color(0xFFBCBCBC),
                      ),
                      hintText: "Enter Discount",
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
                          color:
                              Colors.grey, // Add your desired border color here
                          width: 1.0,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        if (value.isNotEmpty)
                          selectedProductValues[i]['discount'] =
                              value.toString();

                        productList[i]['discount_amount'] =
                            double.parse(value.toString());
                      });
                    },
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
                  "discount Type",
                ),
                Form(
                  key: _formKey11,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          autovalidateMode: switched,
                          onChanged: (String? value) {
                            setState(() {
                              selectedProductValues[i]['discountType'] =
                                  value.toString();
                              productList[i]['discount_type'] =
                                  value.toString();
                            });
                            // Handle the selected value here if needed
                            print('Selected value: $value');
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.discount),
                            hintStyle: const TextStyle(
                              fontFamily: 'inter',
                              fontSize: 14,
                              color: Colors.black,
                            ),
                            hintText: selectedProductValues[i]['discountType'],
                            filled: true,
                            fillColor: Colors.white, // ,
                            contentPadding: const EdgeInsets.all(11.0),
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.0),
                              ),
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 248, 249, 249),
                                width: 2.0,
                              ),
                            ),
                            enabledBorder: const OutlineInputBorder(
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
                            "fixed",
                            "Precentage",
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w400),
                              ),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '';
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
              ],
            ),
          ),
        );
      },
    );
  }

  //Mutiple  payment

  final _multipleCardammount = TextEditingController();
  final _cardnumber = TextEditingController();
  final _cardholdername = TextEditingController();
  final _cardTransactioNumumber = TextEditingController();
  final _cardType = TextEditingController();
  final _cardMonth = TextEditingController();
  final _cardYear = TextEditingController();
  final _securityCode = TextEditingController();
  final _paymentNote = TextEditingController();
  final _checkType = TextEditingController();
  final _checkNumber = TextEditingController();
  final _bankTransferNumber = TextEditingController();

  bool ismultiplepayment = false;

  //Get Payment Method

  List<Map<String, dynamic>> paymentAccounts = [];
  String paymentAccountValue = '';

  Future<void> getAccounts() async {
    final Uri uri = Uri.https(
      "newmaxtechnology.clickypos.com",
      "/connector/api/payment-accounts",
      {"type": "sell"},
    );

    final response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Authorization":
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0In0.eyJhdWQiOiIxMCIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0IiwiaWF0IjoxNzA4MDg0MzYxLCJuYmYiOjE3MDgwODQzNjEsImV4cCI6MTczOTcwNjc2MSwic3ViIjoiMSIsInNjb3BlcyI6W119.nE6jpMdFZR10duRar6fXe3r4zbWk3kR1Tio-nb2tfE385cgcZ5jJhyYBz7bsTt4O6E8GlDcrRSy01ASHc5Yss-eIstz37g9U3d5RkENI1BQ9SGZAVhFX1am9C5HIB_DW4Lcs9HF8IrwZ7KVnVHIV94azoKSlhTZ6v0soNIjVDMDOzQOOPqe6fY9uNYpIxR1m4kJ-iUYWn_8gyGZlHq6K8G1NV1UFL0bkpakES5_owjLJgGSG_ljhmGIe6Qx1ymlRTALK2vB6sfOM0W0SO5T3lYEwSv_kgb79s3UwP5K-ib3k8H8LZkAa1Hll9oTUAGgKHAfCxBUs0Z39RZYx5kgKrCPhe3NqwED5phWQzCg-LofAPOfZS-T6P8vzgnvW9lH151nQHMeM1l5_fn16GeL21etW2Zu7iPyZtE19YRg1yRRD497eAPA3PyK_hRQMRLgaliwzjmrnuTxcD8HA0y8R0EAGqxO8hNlrufDaPNLsbCFTkG-02hwh-OHL7TdDyt2tBIlFNWhHwytRQtFS96isbJ2P3gzg8rooYstRE3j6sjMasMeETtJC7IQmCAwYPJqhADe7MpuFW_fjCemHi9gpOaOGSTyygOXUlDnRrh60ZxJaH8eJOu7q4KaiDDk88Sad82JiDU6alUDopNfxzJunwQX0Z8eqYqBHu4cwfAgNlCI",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey("data")) {
        paymentAccounts = List<Map<String, dynamic>>.from(responseData["data"]);
        print(paymentAccounts);
        if (paymentAccounts.isNotEmpty) {
          setState(() {
            paymentAccountValue = paymentAccounts[0]["name"];
            // paymentAccountValue = paymentAccounts[0]["id"];
          });
        }
      }
    }
  }

  List<Map<String, dynamic>> locationAccounts = [];
  String locationAccountValue = '';
  List<Map<String, dynamic>> locationAccountsId = [];
  int locationAccountValueId = 0;

  Future<void> getLocationAccounts() async {
    final Uri uri = Uri.https(
      "newmaxtechnology.clickypos.com",
      "/connector/api/business-location",
    );

    final response = await http.get(
      uri,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
        "Authorization":
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0In0.eyJhdWQiOiIxMCIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0IiwiaWF0IjoxNzA4MDg0MzYxLCJuYmYiOjE3MDgwODQzNjEsImV4cCI6MTczOTcwNjc2MSwic3ViIjoiMSIsInNjb3BlcyI6W119.nE6jpMdFZR10duRar6fXe3r4zbWk3kR1Tio-nb2tfE385cgcZ5jJhyYBz7bsTt4O6E8GlDcrRSy01ASHc5Yss-eIstz37g9U3d5RkENI1BQ9SGZAVhFX1am9C5HIB_DW4Lcs9HF8IrwZ7KVnVHIV94azoKSlhTZ6v0soNIjVDMDOzQOOPqe6fY9uNYpIxR1m4kJ-iUYWn_8gyGZlHq6K8G1NV1UFL0bkpakES5_owjLJgGSG_ljhmGIe6Qx1ymlRTALK2vB6sfOM0W0SO5T3lYEwSv_kgb79s3UwP5K-ib3k8H8LZkAa1Hll9oTUAGgKHAfCxBUs0Z39RZYx5kgKrCPhe3NqwED5phWQzCg-LofAPOfZS-T6P8vzgnvW9lH151nQHMeM1l5_fn16GeL21etW2Zu7iPyZtE19YRg1yRRD497eAPA3PyK_hRQMRLgaliwzjmrnuTxcD8HA0y8R0EAGqxO8hNlrufDaPNLsbCFTkG-02hwh-OHL7TdDyt2tBIlFNWhHwytRQtFS96isbJ2P3gzg8rooYstRE3j6sjMasMeETtJC7IQmCAwYPJqhADe7MpuFW_fjCemHi9gpOaOGSTyygOXUlDnRrh60ZxJaH8eJOu7q4KaiDDk88Sad82JiDU6alUDopNfxzJunwQX0Z8eqYqBHu4cwfAgNlCI",
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      if (responseData.containsKey("data")) {
        locationAccounts =
            List<Map<String, dynamic>>.from(responseData["data"]);
        print(locationAccounts);
        if (locationAccounts.isNotEmpty) {
          setState(() {
            locationAccountValue = locationAccounts[0]["name"];
            locationAccountValueId = locationAccounts[0]["id"];
          });
        }
      }
    }
  }

  int accountId = 0;

  void printSelectedValue() {
    // Find the selected payment account based on the value
    var selectedAccount = paymentAccounts
        .firstWhere((account) => account["name"] == paymentAccountValue);

    // If a matching account is found, print its "id"
    if (selectedAccount != null) {
      print("Selected Payment Account ID: ${selectedAccount["id"]}");
      accountId = int.parse(selectedAccount["id"].toString());
    }
  }

  DateTime selectedDateTime = DateTime.now();
  TextEditingController _checkdatecontroller = TextEditingController();

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _checkdatecontroller.text =
              DateFormat('yyyy-MM-dd HH:mm').format(selectedDateTime);
        });
      }
    }
  }

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

                            // lableField(
                            //   "Customer Name",
                            // ),
                            const SizedBox(
                              height: 10,
                            ),
                            lableField(
                              "Select Location",
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 1 * 0.75,
                              child: Form(
                                  key: _formKey17,
                                  autovalidateMode: switched,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color:
                                              Colors.grey), // Set border color
                                      borderRadius: BorderRadius.circular(
                                          5.0), // Set border radius
                                    ),
                                    child: DropdownButton(
                                      value: locationAccountValue,
                                      items: locationAccounts.map((e) {
                                        return DropdownMenuItem(
                                          child: Text(
                                            "   " + e["name"],
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          value: e["name"],
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          clearFunction();
                                          locationAccountValue =
                                              value.toString();
                                          locationAccountValueId =
                                              locationAccounts.firstWhere(
                                                  (location) =>
                                                      location["name"] ==
                                                      value)["id"];

                                          print(locationAccountValueId);
                                        });
                                      },
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width /
                                      1 *
                                      0.75,
                                  child: Form(
                                    key: _customernameFormkey,
                                    autovalidateMode: switched,
                                    child: TextFormField(
                                      readOnly: true,
                                      controller: customernaameController,
                                      keyboardType: TextInputType.name,
                                      focusNode: emailFocusNode,
                                      style: const TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 14,
                                        color: kdarkText,
                                      ),
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.person),
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
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddCustomer(
                                              customerName: widget.customerName,
                                              customerid: widget.customerid),
                                        ));
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: kPrimary,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Icon(
                                      Icons.add,
                                      color: Kwhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width /
                                      1 *
                                      0.75,
                                  child: Form(
                                    key: _formKey12,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    child: TypeAheadFormField(
                                      textFieldConfiguration:
                                          TextFieldConfiguration(
                                        controller: search,
                                        keyboardType: TextInputType.name,
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Icons.person),
                                          hintStyle: TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 14,
                                            color: Color(0xFFBCBCBC),
                                          ),
                                          hintText: "Enter Product Name",
                                          filled: true,
                                          fillColor: Colors
                                              .white, // Corrected from Kwhite to Colors.white
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
                                      ),
                                      suggestionsCallback: (pattern) async {
                                        return await fetchProductInfo(pattern);
                                      },
                                      itemBuilder: (context, suggestion) {
                                        return ListTile(
                                          title: Text(suggestion.productName),
                                        );
                                      },
                                      onSuggestionSelected: (suggestion) {
                                        customernaameController.text =
                                            suggestion.productName;

                                        Map<dynamic, dynamic>
                                            selectedProductMap = {
                                          'product_id': suggestion.productId,
                                          'quntity': 1,
                                          'sell_price_inc_tax':
                                              suggestion.sellPriceIncTax,
                                          'product_name':
                                              suggestion.productName,
                                          'discount': '0.00',
                                          'discountType': 'fixed',
                                          'qty_available':
                                              suggestion.productquantity,
                                          'picestype': suggestion.picestype
                                        };

                                        ///pass for create product
                                        Map<String, dynamic> createproduct = {
                                          "product_id": suggestion.productId,
                                          "variation_id": int.parse(suggestion
                                              .variationid
                                              .toString()),
                                          "quantity": 1,
                                          "unit_price": double.parse(suggestion
                                              .sellPriceIncTax
                                              .toString()),
                                          "discount_amount": '0.00',
                                          "discount_type": "fixed",
                                          "sub_unit_id": 1,
                                          "note": "vero"
                                        };

                                        setState(() {
                                          selectedProductValues
                                              .add(selectedProductMap);

                                          productList.add(createproduct);
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      quantity++;
                                    });
                                  },
                                  child: Container(
                                    height: 25,
                                    width: 25,
                                    decoration: BoxDecoration(
                                        color: kPrimary,
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Icon(
                                      Icons.add,
                                      color: Kwhite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),

                            Container(
                              width:
                                  MediaQuery.of(context).size.width / 1 * 0.75,
                              child: Form(
                                key: _formKey10,
                                autovalidateMode: switched,
                                child: TextFormField(
                                  readOnly: false,
                                  controller: _salediscoutamountcontroller,
                                  keyboardType: TextInputType.number,
                                  focusNode: emailFocusNode,
                                  style: const TextStyle(
                                    fontFamily: 'inter',
                                    fontSize: 14,
                                    color: kdarkText,
                                  ),
                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.price_change),
                                    hintStyle: TextStyle(
                                      fontFamily: 'inter',
                                      fontSize: 14,
                                      color: Color(0xFFBCBCBC),
                                    ),
                                    hintText: "Enter Discount",
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
                                ),
                              ),
                            ),
                            selectedProductValues.isEmpty
                                ? Container()
                                : Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1)),
                                    child: Column(
                                      children: [
                                        TableHeader(
                                            title1: "Product",
                                            title2: "Quantity",
                                            title3: "Price\n Inc.\nTax",
                                            title4: "Sub Total"),
                                        for (int i = 0;
                                            i < selectedProductValues.length;
                                            i++)
                                          TableRow(
                                            //Options Adding Colum
                                            onshowbotomsheet: () {
                                              setState(() {
                                                InvoiceNumberController.text =
                                                    'sell-00345';

                                                _shipingaddresscontroller.text =
                                                    "colombo";
                                                _shipingstatuscontroller.text =
                                                    "ordered";

                                                _discoutamountcontroller.text =
                                                    selectedProductValues[i]
                                                                ['discount']
                                                            .toString() ??
                                                        "";
                                                _discouttypecontroller.text =
                                                    selectedProductValues[i]
                                                            ['discountType']
                                                        .toString();
                                              });

                                              showBottomSheet(context, i);
                                            },
                                            ontapincrese: () {
                                              setState(() {
                                                selectedProductValues[i]
                                                    ['quntity']++;

                                                productList[i]['quantity'] =
                                                    selectedProductValues[i]
                                                        ['quntity'];
                                              });
                                            },
                                            ontapdecrese: () {
                                              setState(() {
                                                if (selectedProductValues[i]
                                                        ['quntity'] !=
                                                    1)
                                                  selectedProductValues[i]
                                                      ['quntity']--;
                                                productList[i]['quantity'] =
                                                    selectedProductValues[i]
                                                        ['quntity'];
                                              });
                                            },
                                            productname:
                                                selectedProductValues[i]
                                                        ['product_name'] +
                                                    "\n(" +
                                                    selectedProductValues[i]
                                                            ['qty_available']
                                                        .toString() +
                                                    '\n' +
                                                    selectedProductValues[i]
                                                        ['picestype'] +
                                                    ')',
                                            quntity: selectedProductValues[i]
                                                ['quntity'],
                                            sellprice: selectedProductValues[i]
                                                ['sell_price_inc_tax'],
                                          ),
                                      ],
                                    ),
                                  ),

                            selectedProductValues.isEmpty
                                ? Container()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    child: Row(
                                      children: [
                                        Text(
                                          "Items :   " +
                                              calculateTotalQuantity(
                                                      selectedProductValues)
                                                  .toString(),
                                          style: const TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 15.0,
                                            color: kdarkText,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "Total: " +
                                              calculateTotalAmount(
                                                      selectedProductValues)
                                                  .toStringAsFixed(
                                                      2), // Format to two decimal places
                                          style: const TextStyle(
                                            fontFamily: 'inter',
                                            fontSize: 15.0,
                                            color: kdarkText,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                            const SizedBox(
                              height: 20,
                            ),

                            InkWell(
                              onTap: () {
                                setState(() {
                                  edit = !edit;
                                });
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Text(
                                      "Discount (-" +
                                          calculateDiscountAmount(
                                                  selectedProductValues)
                                              .toStringAsFixed(2) +
                                          " ) ",
                                      style: const TextStyle(
                                        fontFamily: 'inter',
                                        fontSize: 15.0,
                                        color:
                                            Color.fromARGB(255, 120, 119, 119),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

                            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
                            const SizedBox(
                              height: 40,
                            ),

                            Center(
                              child: Text(
                                "Total Payable " +
                                    calculateTotalAmount(selectedProductValues)
                                        .toStringAsFixed(2),
                                style: const TextStyle(
                                  fontFamily: 'inter',
                                  fontSize: 25.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 40,
                            ),
////////////////////////////////////////////////////////////  Multiple Payments ////////////////////////////////////////////
                            ismultiplepayment
                                ? Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              lableField(
                                                "Payment Amount",
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 *
                                                    1.00,
                                                child: Form(
                                                  key: _formKey1,
                                                  autovalidateMode: switched,
                                                  child: TextFormField(
                                                    readOnly: false,
                                                    controller:
                                                        _multipleCardammount,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    focusNode:
                                                        multipleAmountFocusNode,
                                                    style: const TextStyle(
                                                      fontFamily: 'inter',
                                                      fontSize: 14,
                                                      color: kdarkText,
                                                    ),
                                                    decoration:
                                                        const InputDecoration(
                                                      prefixIcon: Icon(
                                                          Icons.price_change),
                                                      hintStyle: TextStyle(
                                                        fontFamily: 'inter',
                                                        fontSize: 14,
                                                        color:
                                                            Color(0xFFBCBCBC),
                                                      ),
                                                      hintText: "Enter Amount",
                                                      filled: true,
                                                      fillColor: Kwhite,
                                                      contentPadding:
                                                          EdgeInsets.all(11.0),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5.0),
                                                        ),
                                                        borderSide: BorderSide(
                                                          color: Colors.blue,
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
                                                          color: Colors
                                                              .grey, // Add your desired border color here
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Form(
                                            key: _formKey8,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                lableField(
                                                  "Payment Method",
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      3 *
                                                      1.00,
                                                  child: Column(
                                                    children: [
                                                      DropdownButtonFormField<
                                                          String>(
                                                        autovalidateMode:
                                                            switched,
                                                        onChanged:
                                                            (String? value) {
                                                          setState(() {
                                                            _paymentmethod
                                                                    .text =
                                                                value
                                                                    .toString();
                                                          });
                                                          // Handle the selected value here if needed
                                                          print(
                                                              'Selected value: $value');
                                                        },
                                                        decoration:
                                                            const InputDecoration(
                                                          hintStyle: TextStyle(
                                                            fontFamily: 'inter',
                                                            fontSize: 14,
                                                            color: Color(
                                                                0xFFBCBCBC),
                                                          ),
                                                          hintText: 'Select',
                                                          filled: true,
                                                          fillColor:
                                                              Colors.white, // ,
                                                          contentPadding:
                                                              EdgeInsets.all(
                                                                  11.0),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5.0),
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              color:
                                                                  Colors.blue,
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  5.0),
                                                            ),
                                                            borderSide:
                                                                BorderSide(
                                                              color: Colors
                                                                  .grey, // Add your desired border color here
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                        ),
                                                        items: [
                                                          "cash",
                                                          "card",
                                                          "cheque",
                                                          "bank_transfer",
                                                        ].map((String value) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value,
                                                                style: const TextStyle(
                                                                    fontSize:
                                                                        10,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
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
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          lableField(
                                            "Payment Account",
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1 *
                                                1.00,
                                            child: Form(
                                                key: _formKey3,
                                                autovalidateMode: switched,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors
                                                            .grey), // Set border color
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0), // Set border radius
                                                  ),
                                                  child: DropdownButton(
                                                    value: paymentAccountValue,
                                                    items: paymentAccounts
                                                        .map((e) {
                                                      return DropdownMenuItem(
                                                        child: Text(e["name"],
                                                            style: const TextStyle(
                                                                fontSize: 10,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                        value: e["name"],
                                                      );
                                                    }).toList(),
                                                    onChanged: (value) {
                                                      setState(() {
                                                        paymentAccountValue =
                                                            value.toString();
                                                        printSelectedValue();
                                                      });
                                                    },
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                      _paymentmethod.text == "card"
                                          ? Column(
                                              children: [
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    lableField(
                                                      "Card Number",
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1 *
                                                              1.00,
                                                      child: Form(
                                                        key: _formKey2,
                                                        autovalidateMode:
                                                            switched,
                                                        child: TextFormField(
                                                          readOnly: false,
                                                          controller:
                                                              _cardnumber,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          focusNode: f1,
                                                          style:
                                                              const TextStyle(
                                                            fontFamily: 'inter',
                                                            fontSize: 14,
                                                            color: kdarkText,
                                                          ),
                                                          decoration:
                                                              const InputDecoration(
                                                            prefixIcon: Icon(Icons
                                                                .credit_card),
                                                            hintStyle:
                                                                TextStyle(
                                                              fontFamily:
                                                                  'inter',
                                                              fontSize: 14,
                                                              color: Color(
                                                                  0xFFBCBCBC),
                                                            ),
                                                            hintText:
                                                                " Enter Card Number",
                                                            filled: true,
                                                            fillColor: Kwhite,
                                                            contentPadding:
                                                                EdgeInsets.all(
                                                                    11.0),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5.0),
                                                              ),
                                                              borderSide:
                                                                  BorderSide(
                                                                color:
                                                                    Colors.blue,
                                                                width: 2.0,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(
                                                                Radius.circular(
                                                                    5.0),
                                                              ),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: Colors
                                                                    .grey, // Add your desired border color here
                                                                width: 1.0,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        lableField(
                                                          "Card Holder Name",
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4 *
                                                              1.00,
                                                          child: Form(
                                                            key: _formKey4,
                                                            autovalidateMode:
                                                                switched,
                                                            child:
                                                                TextFormField(
                                                              readOnly: false,
                                                              controller:
                                                                  _cardholdername,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .name,
                                                              focusNode: f2,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'inter',
                                                                fontSize: 14,
                                                                color:
                                                                    kdarkText,
                                                              ),
                                                              decoration:
                                                                  const InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .person),
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'inter',
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFFBCBCBC),
                                                                ),
                                                                hintText:
                                                                    "Crad Holder Name",
                                                                filled: true,
                                                                fillColor:
                                                                    Kwhite,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            11.0),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey, // Add your desired border color here
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        lableField(
                                                          "Transaction No",
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4 *
                                                              1.00,
                                                          child: Form(
                                                            key: _formKey5,
                                                            autovalidateMode:
                                                                switched,
                                                            child:
                                                                TextFormField(
                                                              readOnly: false,
                                                              controller:
                                                                  _cardTransactioNumumber,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              focusNode: f3,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'inter',
                                                                fontSize: 14,
                                                                color:
                                                                    kdarkText,
                                                              ),
                                                              decoration:
                                                                  const InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .numbers),
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'inter',
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFFBCBCBC),
                                                                ),
                                                                hintText:
                                                                    "Transaction Number",
                                                                filled: true,
                                                                fillColor:
                                                                    Kwhite,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            11.0),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey, // Add your desired border color here
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Form(
                                                      key: _formKey7,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          lableField(
                                                            "Card Type",
                                                          ),
                                                          SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                3 *
                                                                1.00,
                                                            child: Column(
                                                              children: [
                                                                DropdownButtonFormField<
                                                                    String>(
                                                                  autovalidateMode:
                                                                      switched,
                                                                  onChanged:
                                                                      (String?
                                                                          value) {
                                                                    setState(
                                                                        () {
                                                                      _cardType
                                                                              .text =
                                                                          value
                                                                              .toString();
                                                                    });
                                                                    // Handle the selected value here if needed
                                                                    print(
                                                                        'Selected value: $value');
                                                                  },
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'inter',
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xFFBCBCBC),
                                                                    ),
                                                                    hintText:
                                                                        'Select',
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Colors
                                                                            .white, // ,
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            11.0),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            5.0),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .blue,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            5.0),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .grey, // Add your desired border color here
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  items: [
                                                                    "Visa",
                                                                    "Master",
                                                                  ].map((String
                                                                      value) {
                                                                    return DropdownMenuItem<
                                                                        String>(
                                                                      value:
                                                                          value,
                                                                      child: Text(
                                                                          value,
                                                                          style: const TextStyle(
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.w400)),
                                                                    );
                                                                  }).toList(),
                                                                  validator:
                                                                      (value) {
                                                                    if (value ==
                                                                            null ||
                                                                        value
                                                                            .isEmpty) {
                                                                      return 'Please select';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        lableField(
                                                          "Month",
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4 *
                                                              1.00,
                                                          child: Form(
                                                            key: _formKey15,
                                                            autovalidateMode:
                                                                switched,
                                                            child:
                                                                TextFormField(
                                                              readOnly: false,
                                                              controller:
                                                                  _cardMonth,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              focusNode: f5,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'inter',
                                                                fontSize: 14,
                                                                color:
                                                                    kdarkText,
                                                              ),
                                                              decoration:
                                                                  const InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .calendar_today),
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'inter',
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFFBCBCBC),
                                                                ),
                                                                hintText:
                                                                    "Enter Month",
                                                                filled: true,
                                                                fillColor:
                                                                    Kwhite,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            11.0),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey, // Add your desired border color here
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        lableField(
                                                          "Year",
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4 *
                                                              1.00,
                                                          child: Form(
                                                            key: _formKey16,
                                                            autovalidateMode:
                                                                switched,
                                                            child:
                                                                TextFormField(
                                                              readOnly: false,
                                                              controller:
                                                                  _cardYear,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              focusNode: f6,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'inter',
                                                                fontSize: 14,
                                                                color:
                                                                    kdarkText,
                                                              ),
                                                              decoration:
                                                                  const InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .calendar_month),
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'inter',
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFFBCBCBC),
                                                                ),
                                                                hintText:
                                                                    "Enter Year",
                                                                filled: true,
                                                                fillColor:
                                                                    Kwhite,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            11.0),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey, // Add your desired border color here
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        lableField(
                                                          "CVC",
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4 *
                                                              1.00,
                                                          child: Form(
                                                            key: _formKey14,
                                                            autovalidateMode:
                                                                switched,
                                                            child:
                                                                TextFormField(
                                                              readOnly: false,
                                                              controller:
                                                                  _securityCode,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              focusNode: f7,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'inter',
                                                                fontSize: 14,
                                                                color:
                                                                    kdarkText,
                                                              ),
                                                              decoration:
                                                                  const InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .security),
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'inter',
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFFBCBCBC),
                                                                ),
                                                                hintText:
                                                                    "Enter Security",
                                                                filled: true,
                                                                fillColor:
                                                                    Kwhite,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            11.0),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey, // Add your desired border color here
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    lableField(
                                                      "Payment Note",
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    TextField(
                                                      controller: _paymentNote,
                                                      maxLines:
                                                          3, // Set maxLines to null for a multiline text field
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : _paymentmethod.text == "cheque"
                                              ? Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        lableField(
                                                          "Cheque No",
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              1 *
                                                              1.00,
                                                          child: Form(
                                                            key: _formKey2,
                                                            autovalidateMode:
                                                                switched,
                                                            child:
                                                                TextFormField(
                                                              readOnly: false,
                                                              controller:
                                                                  _checkNumber,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              focusNode: f8,
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    'inter',
                                                                fontSize: 14,
                                                                color:
                                                                    kdarkText,
                                                              ),
                                                              decoration:
                                                                  const InputDecoration(
                                                                prefixIcon:
                                                                    Icon(Icons
                                                                        .card_giftcard),
                                                                hintStyle:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'inter',
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xFFBCBCBC),
                                                                ),
                                                                hintText:
                                                                    " Enter Check Number",
                                                                filled: true,
                                                                fillColor:
                                                                    Kwhite,
                                                                contentPadding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            11.0),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .blue,
                                                                    width: 2.0,
                                                                  ),
                                                                ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            5.0),
                                                                  ),
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .grey, // Add your desired border color here
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Form(
                                                          key: _formKey7,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              lableField(
                                                                "Cheque Type",
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    3 *
                                                                    1.00,
                                                                child: Column(
                                                                  children: [
                                                                    DropdownButtonFormField<
                                                                        String>(
                                                                      autovalidateMode:
                                                                          switched,
                                                                      onChanged:
                                                                          (String?
                                                                              value) {
                                                                        setState(
                                                                            () {
                                                                          _checkType.text =
                                                                              value.toString();
                                                                        });
                                                                        // Handle the selected value here if needed
                                                                        print(
                                                                            'Selected value: $value');
                                                                      },
                                                                      decoration:
                                                                          const InputDecoration(
                                                                        hintStyle:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'inter',
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Color(0xFFBCBCBC),
                                                                        ),
                                                                        hintText:
                                                                            'Select',
                                                                        filled:
                                                                            true,
                                                                        fillColor:
                                                                            Colors.white, // ,
                                                                        contentPadding:
                                                                            EdgeInsets.all(11.0),
                                                                        focusedBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(5.0),
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.blue,
                                                                            width:
                                                                                2.0,
                                                                          ),
                                                                        ),
                                                                        enabledBorder:
                                                                            OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.all(
                                                                            Radius.circular(5.0),
                                                                          ),
                                                                          borderSide:
                                                                              BorderSide(
                                                                            color:
                                                                                Colors.grey, // Add your desired border color here
                                                                            width:
                                                                                1.0,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      items: [
                                                                        "Issued",
                                                                        "Master",
                                                                      ].map((String
                                                                          value) {
                                                                        return DropdownMenuItem<
                                                                            String>(
                                                                          value:
                                                                              value,
                                                                          child: Text(
                                                                              value,
                                                                              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400)),
                                                                        );
                                                                      }).toList(),
                                                                      validator:
                                                                          (value) {
                                                                        if (value ==
                                                                                null ||
                                                                            value.isEmpty) {
                                                                          return 'Please select';
                                                                        }
                                                                        return null;
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Form(
                                                          autovalidateMode:
                                                              switched,
                                                          key: _formKey6,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              lableField(
                                                                "Cheque Date",
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    2 *
                                                                    1.00,
                                                                child:
                                                                    TextFormField(
                                                                  readOnly:
                                                                      true,
                                                                  onTap: () =>
                                                                      _selectDateTime(
                                                                          context),
                                                                  controller:
                                                                      _checkdatecontroller,
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .calendar_month),
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'inter',
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xFFBCBCBC),
                                                                    ),
                                                                    hintText:
                                                                        " Enter Date",
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Kwhite,
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            11.0),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            5.0),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .blue,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            5.0),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .grey, // Add your desired border color here
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        lableField(
                                                          "Payment Note",
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        TextField(
                                                          controller:
                                                              _paymentNote,
                                                          maxLines:
                                                              3, // Set maxLines to null for a multiline text field
                                                          keyboardType:
                                                              TextInputType
                                                                  .multiline,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Enter Payment Note',
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )
                                              : _paymentmethod.text == "cash"
                                                  ? Container()
                                                  : Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            lableField(
                                                              "Bank Ac No",
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  1 *
                                                                  1.00,
                                                              child: Form(
                                                                key: _formKey2,
                                                                autovalidateMode:
                                                                    switched,
                                                                child:
                                                                    TextFormField(
                                                                  readOnly:
                                                                      false,
                                                                  controller:
                                                                      _bankTransferNumber,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  focusNode:
                                                                      f10,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'inter',
                                                                    fontSize:
                                                                        14,
                                                                    color:
                                                                        kdarkText,
                                                                  ),
                                                                  decoration:
                                                                      const InputDecoration(
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .price_change),
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'inter',
                                                                      fontSize:
                                                                          14,
                                                                      color: Color(
                                                                          0xFFBCBCBC),
                                                                    ),
                                                                    hintText:
                                                                        "Bank Account Number",
                                                                    filled:
                                                                        true,
                                                                    fillColor:
                                                                        Kwhite,
                                                                    contentPadding:
                                                                        EdgeInsets.all(
                                                                            11.0),
                                                                    focusedBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            5.0),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .blue,
                                                                        width:
                                                                            2.0,
                                                                      ),
                                                                    ),
                                                                    enabledBorder:
                                                                        OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .all(
                                                                        Radius.circular(
                                                                            5.0),
                                                                      ),
                                                                      borderSide:
                                                                          BorderSide(
                                                                        color: Colors
                                                                            .grey, // Add your desired border color here
                                                                        width:
                                                                            1.0,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            lableField(
                                                              "Payment Note",
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),
                                                            TextField(
                                                              controller:
                                                                  _paymentNote,
                                                              maxLines:
                                                                  3, // Set maxLines to null for a multiline text field
                                                              keyboardType:
                                                                  TextInputType
                                                                      .multiline,
                                                              decoration:
                                                                  InputDecoration(
                                                                labelText:
                                                                    'Enter Payment Note',
                                                                border:
                                                                    OutlineInputBorder(),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Column(
                                        children: [
                                          paymentList.isNotEmpty
                                              ? TableHeader(
                                                  title1: "Numbers",
                                                  title2: "Pyament Type",
                                                  title3: "Amount",
                                                  title4: "")
                                              : Container(),
                                          for (int i = 0;
                                              i < paymentList.length;
                                              i++)
                                            PymentRow(
                                              title1: (i + 1).toString(),
                                              title2: paymentList[i]["method"],
                                              title3: paymentList[i]["amount"]
                                                  .toString(),
                                              title4: "",
                                            )
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: RoundedButton(
                                                    buttonText: "Add Payment",
                                                    onPress: () {
                                                      // ;
                                                      // ;,
                                                      setState(() {
                                                        Map<String, dynamic>
                                                            createpayment = {
                                                          "amount": double.parse(
                                                              _multipleCardammount
                                                                  .text),
                                                          "method":
                                                              _paymentmethod
                                                                  .text,
                                                          "account_id":
                                                              accountId,
                                                          "card_number":
                                                              _cardnumber.text,
                                                          "card_holder_name":
                                                              _cardholdername
                                                                  .text,
                                                          "card_transaction_number":
                                                              _cardTransactioNumumber
                                                                  .text,
                                                          "card_type":
                                                              _cardType.text,
                                                          "card_month":
                                                              _cardMonth.text,
                                                          "card_year":
                                                              _cardYear.text,
                                                          "card_security":
                                                              _securityCode
                                                                  .text,
                                                          "transaction_no_1":
                                                              " ",
                                                          "transaction_no_2":
                                                              " ",
                                                          "transaction_no_3":
                                                              " ",
                                                          "bank_account_number":
                                                              _bankTransferNumber
                                                                  .text,
                                                          "note":
                                                              _paymentNote.text,
                                                          "cheque_number":
                                                              _checkNumber.text
                                                        };

                                                        paymentList
                                                            .add(createpayment);
                                                      });
                                                    }),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                width: 150,
                                                child: RoundedButton(
                                                    buttonText: "Cancle",
                                                    onPress: () {
                                                      setState(() {
                                                        ismultiplepayment =
                                                            false;
                                                      });
                                                    }),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          paymentList.isNotEmpty
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 25),
                                                  child: RoundedButton(
                                                      buttonText: "Create Sale",
                                                      onPress: () async {
                                                        print(
                                                            locationAccountValueId);
                                                        print(paymentList);
                                                        await SalescreateApiEndpoint.createsales(
                                                            widget.customerid,
                                                            DateTime.now()
                                                                .toString(),
                                                            'final',
                                                            double.parse(
                                                                _salediscoutamountcontroller
                                                                        .text
                                                                        .isEmpty
                                                                    ? '0.0'
                                                                    : _salediscoutamountcontroller
                                                                        .text),
                                                            productList,
                                                            paymentList,
                                                            locationAccountValueId,
                                                            "",
                                                            context);
                                                      }),
                                                )
                                              : Container()
                                        ],
                                      )
                                    ],
                                  )
                                : Container(),

                            const SizedBox(
                              height: 20,
                            ),

                            ismultiplepayment
                                ? Container()
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Container(
                                                  height: 60,
                                                  width: 140,
                                                  child: RoundedButton(
                                                      buttonText: "Cash Sale",
                                                      onPress: () async {
                                                        setState(() {
                                                          switched =
                                                              AutovalidateMode
                                                                  .always;
                                                        });

                                                        double val =
                                                            calculateTotalAmount(
                                                                selectedProductValues);
                                                        print("val is " +
                                                            val.toString());

                                                        Map<String, dynamic>
                                                            createpayment = {
                                                          "amount": val,
                                                          "method": "cash",
                                                          "account_id": 0,
                                                          "card_number": "",
                                                          "card_holder_name":
                                                              "",
                                                          "card_transaction_number":
                                                              "",
                                                          "card_type": "sit",
                                                          "card_month": "",
                                                          "card_year": "",
                                                          "card_security": "",
                                                          "transaction_no_1":
                                                              "",
                                                          "transaction_no_2":
                                                              "",
                                                          "transaction_no_3":
                                                              "",
                                                          "bank_account_number":
                                                              "",
                                                          "note": "",
                                                          "cheque_number": ""
                                                        };

                                                        paymentList
                                                            .add(createpayment);

                                                        await SalescreateApiEndpoint.createsales(
                                                            widget.customerid,
                                                            DateTime.now()
                                                                .toString(),
                                                            "final",
                                                            double.parse(
                                                                _salediscoutamountcontroller
                                                                        .text
                                                                        .isEmpty
                                                                    ? '0.0'
                                                                    : _salediscoutamountcontroller
                                                                        .text),
                                                            productList,
                                                            paymentList,
                                                            locationAccountValueId,
                                                            "",
                                                            context);

                                                        try {} catch (e) {
                                                        } finally {
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        }
                                                      }),
                                                ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Container(
                                                  height: 60,
                                                  width: 140,
                                                  child: RoundedButton(
                                                      buttonText: "Credit Sale",
                                                      onPress: () async {
                                                        setState(() {});
                                                        Map<String, dynamic>
                                                            createpayment = {
                                                          "amount": 0.0,
                                                          "method": "credit",
                                                          "account_id": 28,
                                                          "card_number": "quia",
                                                          "card_holder_name":
                                                              "qui",
                                                          "card_transaction_number":
                                                              "repellat",
                                                          "card_type": "sit",
                                                          "card_month":
                                                              "corporis",
                                                          "card_year": "illum",
                                                          "card_security":
                                                              "hic",
                                                          "transaction_no_1":
                                                              "et",
                                                          "transaction_no_2":
                                                              "temporibus",
                                                          "transaction_no_3":
                                                              "amet",
                                                          "bank_account_number":
                                                              "maiores",
                                                          "note": "sint",
                                                          "cheque_number":
                                                              "sint"
                                                        };

                                                        paymentList
                                                            .add(createpayment);

                                                        await SalescreateApiEndpoint.createsales(
                                                            widget.customerid,
                                                            DateTime.now()
                                                                .toString(),
                                                            "final",
                                                            double.parse(
                                                                _salediscoutamountcontroller
                                                                        .text
                                                                        .isEmpty
                                                                    ? '0.0'
                                                                    : _salediscoutamountcontroller
                                                                        .text),
                                                            productList,
                                                            paymentList,
                                                            locationAccountValueId,
                                                            "",
                                                            context);

                                                        try {} catch (e) {
                                                        } finally {
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        }
                                                      }),
                                                ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Container(
                                                  width: 140,
                                                  child: RoundedButton(
                                                      buttonText:
                                                          "Multiple Payment",
                                                      onPress: () async {
                                                        setState(() {
                                                          ismultiplepayment =
                                                              true;
                                                        });
                                                        try {} catch (e) {
                                                        } finally {
                                                          // setState(() {
                                                          //   isLoading = false;
                                                          // });
                                                        }
                                                      }),
                                                ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Container(
                                                  width: 140,
                                                  height: 70,
                                                  child: RoundedButton(
                                                      buttonText: "draft",
                                                      onPress: () async {
                                                        print(productList);
                                                        setState(() {
                                                          switched =
                                                              AutovalidateMode
                                                                  .always;
                                                        });
                                                        Map<String, dynamic>
                                                            createpayment = {
                                                          "amount": 0.0,
                                                          "method": " ",
                                                          "account_id": 0,
                                                          "card_number": "",
                                                          "card_holder_name":
                                                              "",
                                                          "card_transaction_number":
                                                              "",
                                                          "card_type": "",
                                                          "card_month": "",
                                                          "card_year": "",
                                                          "card_security": "",
                                                          "transaction_no_1":
                                                              "",
                                                          "transaction_no_2":
                                                              "temporibus",
                                                          "transaction_no_3":
                                                              "",
                                                          "bank_account_number":
                                                              "",
                                                          "note": "",
                                                          "cheque_number": ""
                                                        };

                                                        paymentList
                                                            .add(createpayment);

                                                        await SalescreateApiEndpoint.createsales(
                                                            widget.customerid,
                                                            DateTime.now()
                                                                .toString(),
                                                            'draft',
                                                            double.parse(
                                                                _salediscoutamountcontroller
                                                                        .text
                                                                        .isEmpty
                                                                    ? '0.0'
                                                                    : _salediscoutamountcontroller
                                                                        .text),
                                                            productList,
                                                            paymentList,
                                                            locationAccountValueId,
                                                            "",
                                                            context);

                                                        try {} catch (e) {
                                                        } finally {
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        }
                                                      }),
                                                ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Container(
                                                  height: 60,
                                                  width: 140,
                                                  child: RoundedButton(
                                                      buttonText: "Quotation",
                                                      onPress: () async {
                                                        print(productList);
                                                        setState(() {
                                                          switched =
                                                              AutovalidateMode
                                                                  .always;
                                                        });
                                                        Map<String, dynamic>
                                                            createpayment = {
                                                          "amount": 0.0,
                                                          "method": " ",
                                                          "account_id": 0,
                                                          "card_number": "",
                                                          "card_holder_name":
                                                              "",
                                                          "card_transaction_number":
                                                              "",
                                                          "card_type": "",
                                                          "card_month": "",
                                                          "card_year": "",
                                                          "card_security": "",
                                                          "transaction_no_1":
                                                              "",
                                                          "transaction_no_2":
                                                              "",
                                                          "transaction_no_3":
                                                              "",
                                                          "bank_account_number":
                                                              "",
                                                          "note": "",
                                                          "cheque_number": ""
                                                        };

                                                        paymentList
                                                            .add(createpayment);

                                                        await SalescreateApiEndpoint.createsales(
                                                            widget.customerid,
                                                            DateTime.now()
                                                                .toString(),
                                                            'draft',
                                                            double.parse(
                                                                _salediscoutamountcontroller
                                                                        .text
                                                                        .isEmpty
                                                                    ? '0.0'
                                                                    : _salediscoutamountcontroller
                                                                        .text),
                                                            productList,
                                                            paymentList,
                                                            locationAccountValueId,
                                                            "quotation",
                                                            context);

                                                        try {} catch (e) {
                                                        } finally {
                                                          setState(() {
                                                            isLoading = false;
                                                          });
                                                        }
                                                      }),
                                                ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          isLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator())
                                              : Container(
                                                  height: 60,
                                                  width: 140,
                                                  child: RoundedButton(
                                                      buttonText: "Cancle",
                                                      onPress: () async {
                                                        Navigator.pop(context);

                                                        print(paymentList);

                                                        try {} catch (e) {
                                                        } finally {
                                                          // setState(() {
                                                          //   isLoading = false;
                                                          // });
                                                        }
                                                      }),
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),

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
                            //   ontapdecrese: () {
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        satesDateTimeController.text =
            picked.toLocal().toString().split(' ')[0];
      });
    }
  }
}

class TableRow extends StatefulWidget {
  int quntity;
  String sellprice;
  String productname;
  final VoidCallback ontapdecrese;
  final VoidCallback ontapincrese;
  final VoidCallback onshowbotomsheet;

  TableRow(
      {super.key,
      required this.quntity,
      required this.sellprice,
      required this.productname,
      required this.ontapdecrese,
      required this.ontapincrese,
      required this.onshowbotomsheet});

  @override
  State<TableRow> createState() => _TableRowState();
}

class _TableRowState extends State<TableRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                  height: 80,
                  width: 100,
                  child: Center(child: Text(widget.productname.toString()))),
              InkWell(
                onTap: widget.onshowbotomsheet,
                child: const Icon(
                  Icons.info,
                  color: Colors.blue,
                ),
              )
            ],
          ),
          Row(
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                    color: kPrimary, borderRadius: BorderRadius.circular(50)),
                child: InkWell(
                  onTap: widget.ontapincrese,
                  child: const Icon(
                    Icons.add,
                    color: Kwhite,
                    size: 12,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  widget.quntity.toString(),
                  style: const TextStyle(
                    fontFamily: 'inter',
                    fontSize: 13.0,
                    color: kdarkText,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              InkWell(
                onTap: widget.ontapdecrese,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: kPrimary, borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    Icons.minimize,
                    color: Kwhite,
                    size: 12,
                  ),
                ),
              ),
            ],
          ),
          Text(
            widget.sellprice.toString(),
            style: const TextStyle(
              fontFamily: 'inter',
              fontSize: 13.0,
              color: kdarkText,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            (double.parse(widget.sellprice.toString()) * widget.quntity)
                .toString(),
            style: const TextStyle(
              fontFamily: 'inter',
              fontSize: 13.0,
              color: kdarkText,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  String title1, title2, title3, title4;
  TableHeader({
    super.key,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 185, 220, 249),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title1.toString(),
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.0,
                color: kdarkText,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              title2,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.0,
                color: kdarkText,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              title3,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.0,
                color: kdarkText,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              title4,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.0,
                color: kdarkText,
                fontWeight: FontWeight.w900,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PymentRow extends StatelessWidget {
  String title1, title2, title3, title4;
  PymentRow({
    super.key,
    required this.title1,
    required this.title2,
    required this.title3,
    required this.title4,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title1.toString(),
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.0,
                color: kdarkText,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              title2,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.0,
                color: kdarkText,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              title3,
              style: TextStyle(
                fontFamily: 'inter',
                fontSize: 13.0,
                color: kdarkText,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
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
                text: 'Add Your Sale',
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
