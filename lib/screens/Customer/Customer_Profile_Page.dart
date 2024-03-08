import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maxtech/api/selltransaction.dart';
import 'package:maxtech/models/CustomerDetails_model.dart';
import 'package:maxtech/screens/Sales/Sales_Create_Page.dart';
import 'package:maxtech/widget/SalesCreateCard.dart';
import 'package:maxtech/widget/rounded_button.dart';
import 'package:maxtech/widget/textStyle.dart';

class CustomerProfile extends StatefulWidget {
  String name, phonenumber, totalbalance, totalrp, totalrpused;
  int customerid;
  CustomerProfile(
      {super.key,
      required this.customerid,
      required this.name,
      required this.phonenumber,
      required this.totalbalance,
      required this.totalrp,
      required this.totalrpused});

  @override
  State<CustomerProfile> createState() => _CustomerProfileState();
}

class _CustomerProfileState extends State<CustomerProfile> {
  late Timer _timer;
  late StreamController<List<SellTransaction>> _controller;
  late Stream<List<SellTransaction>> _stream;

  get i => null;

  @override
  void dispose() {
    _timer.cancel();
    _controller.close();

    super.dispose();
  }

  Future<void> getAllDrivers() async {
    try {
      List<SellTransaction> driversList =
          await SellsCard.GetSellsTransaction('', widget.customerid);
      _controller.add(driversList);
    } catch (error) {
      print("Error fetching drivers: $error");
    }
  }

  @override
  void initState() {
    print(widget.customerid);
    _controller = StreamController<List<SellTransaction>>();
    _stream = _controller.stream;
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      getAllDrivers();
    });
    // TODO: implement initState
    super.initState();
    getAllDrivers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          UpperSection(widget: widget),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //           height: MediaQuery.of(context).size.width / 8,
          //           width: MediaQuery.of(context).size.width / 2 * 0.85,
          //           child: RoundedButton(
          //               buttonText: "Create Sales",
          //               onPress: () {

          //               })),
          //       Container(
          //           height: MediaQuery.of(context).size.width / 8,
          //           width: MediaQuery.of(context).size.width / 2 * 0.85,
          //           child: RoundedButton(
          //               buttonText: "Add Payment", onPress: () {}))
          //     ],
          //   ),
          // ),
          SizedBox(
            height: 20,
          ),
          Divider(
            color: Colors.grey.withOpacity(0.8),
            thickness: 1.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextComponent(
                  color: Color(0xff536471),
                  fontWeight: FontWeight.w400,
                  size: 18,
                  text: 'Sales History',
                  fontfamily: 'inter',
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SalesCreate(
                              customerName: widget.name,
                              customerid: widget.customerid),
                        ));
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_shopping_cart,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      TextComponent(
                        color: Colors.blue,
                        fontWeight: FontWeight.w800,
                        size: 18,
                        text: 'Sales Create',
                        fontfamily: 'inter',
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.8),
            thickness: 1.0,
          ),

          Expanded(
            flex: 4,
            child: StreamBuilder<List<SellTransaction>>(
              stream: _stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  List<SellTransaction>? driversList = snapshot.data;

                  return ListView.builder(
                    itemCount: driversList?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SalesCard(
                          location: driversList![index].businessLocation,
                          sellretunDue: driversList![index].paymentLines.isEmpty
                              ? driversList![index].amountReturn.toString()
                              : (double.parse(driversList![index]
                                          .amountReturn
                                          .toString()) -
                                      double.parse(driversList![index]
                                          .paymentLines![0]
                                          .amount
                                          .toString()))
                                  .toString(),
                          selldue: driversList![index].paymentLines.isEmpty
                              ? driversList![index].finalTotal.toString()
                              : (double.parse(driversList![index]
                                          .finalTotal
                                          .toString()) -
                                      double.parse(driversList![index]
                                          .paymentLines![0]
                                          .amount
                                          .toString()))
                                  .toString(),
                          shipingstatues: driversList![index]
                                      .shippingStatus
                                      .toString() ==
                                  ""
                              ? 'Not Selected'
                              : driversList![index].shippingStatus.toString(),
                          paymentmethod:
                              driversList![index].paymentLines.isEmpty
                                  ? 'Not Added'
                                  : driversList![index].paymentLines![0].method,
                          paymentStatues: driversList![index]
                                      .paymentStatus
                                      .toString() ==
                                  "null"
                              ? 'Not Added'
                              : driversList![index].paymentStatus.toString(),
                          SellNote: driversList![index]
                                      .additionalNotes
                                      .toString() ==
                                  ""
                              ? 'Not Added'
                              : driversList![index].additionalNotes.toString(),
                          Stafnote:
                              driversList![index].staffNote.toString() == ""
                                  ? 'Not Added'
                                  : driversList![index].staffNote.toString(),
                          TotalPaid:
                              driversList![index].totalPaid.toString() == 'null'
                                  ? '0.00'
                                  : driversList![index].totalPaid.toString(),
                          totalItem: driversList![index].totalItems.toString(),
                          totalamount:
                              driversList![index].finalTotal.toString(),
                          Invoicenumber:
                              driversList![index].invoiceNo.toString(),
                          AddedBy: driversList![index].addedBy,
                          ShipingDetails: driversList![index]
                                      .shippingDetails
                                      .toString() ==
                                  ""
                              ? 'Not Added'
                              : driversList![index].shippingDetails.toString(),
                          SellDetails: '',
                          datetime: driversList![index].saleDate.toString(),
                          token: '',
                        ),
                      ); // Return an empty container if no match
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UpperSection extends StatelessWidget {
  const UpperSection({
    super.key,
    required this.widget,
  });

  final CustomerProfile widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              "https://img.freepik.com/free-vector/isolated-young-handsome-man-set-different-poses-white-background-illustration_632498-652.jpg?w=740&t=st=1706545131~exp=1706545731~hmac=ea778074807066d294b20b472bdcc549dd5078fa7f878048a21cb64c0f6f21a9",
            ),
          ),
        ),
        TextComponent(
          color: Color(0xff000000),
          fontWeight: FontWeight.w700,
          size: 25,
          text: widget.name,
          fontfamily: 'inter',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.email,
                size: 20,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            TextComponent(
              color: Color(0xff536471),
              fontWeight: FontWeight.w400,
              size: 18,
              text: 'Test@Gmail.com',
              fontfamily: 'inter',
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(2.0),
              child: Icon(
                Icons.call,
                size: 20,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            TextComponent(
              color: Color(0xff536471),
              fontWeight: FontWeight.w400,
              size: 18,
              text: widget.phonenumber,
              fontfamily: 'inter',
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Column(
                      children: [
                        TextComponent(
                            text: widget.totalbalance,
                            size: 20,
                            color: Color(0xffDF5E01),
                            fontWeight: FontWeight.bold,
                            fontfamily: 'inter'),
                        TextComponent(
                            text: "Balance",
                            size: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontfamily: 'inter'),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Center(
                          child: TextComponent(
                              text: widget.totalrp == '0'
                                  ? '0.00     '
                                  : widget.totalrp,
                              size: 20,
                              color: Color(0xffDF5E01),
                              fontWeight: FontWeight.bold,
                              fontfamily: 'inter'),
                        ),
                        TextComponent(
                            text: "Total Rp",
                            size: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontfamily: 'inter'),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Center(
                          child: TextComponent(
                              text: widget.totalrpused == '0'
                                  ? '0.00    '
                                  : widget.totalrpused,
                              size: 20,
                              color: Color(0xffDF5E01),
                              fontWeight: FontWeight.bold,
                              fontfamily: 'inter'),
                        ),
                        TextComponent(
                            text: "Total Used",
                            size: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontfamily: 'inter'),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
