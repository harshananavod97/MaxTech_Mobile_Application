import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maxtech/screens/Customer/AddCustomerPage.dart';
import 'package:maxtech/screens/Customer/Customer_Profile_Page.dart';
import 'package:maxtech/screens/Sales/Sales_Create_Page.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  TextEditingController searchController = TextEditingController();
  List<Customer> customerlist = [];
  List<Customer> filteredList = [];
  Future<List<Customer>> getPhotos() async {
    final response = await http.get(
      Uri.parse(
          'https://newmaxtechnology.clickypos.com/connector/api/contactapi'),
      headers: {
        "accept": "application/json",
        "Authorization":
            "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA3MjBjYjM4NWI1ZDM5MDM1NjUzNmIyMGQzM2FlNTA4OTZjYjUwMTQzMzhkNWYzYWFlYTUwMjU5Yzg2YmZkYzAyZmQzOGMxNDFmYTE2MGY1In0.eyJhdWQiOiIxMCIsImp0aSI6IjA3MjBjYjM4NWI1ZDM5MDM1NjUzNmIyMGQzM2FlNTA4OTZjYjUwMTQzMzhkNWYzYWFlYTUwMjU5Yzg2YmZkYzAyZmQzOGMxNDFmYTE2MGY1IiwiaWF0IjoxNzA2NTEyMzIxLCJuYmYiOjE3MDY1MTIzMjEsImV4cCI6MTczODEzNDcyMSwic3ViIjoiMSIsInNjb3BlcyI6W119.Ut8kcatFaP9P6qUEsxPWL2DjELXRuaBkdVqdnOx_dN_0mZDdRYManjkux4JVrYKW4hPCFaGWLMi9V-TK5Y61-9V4_u7AemrwmuON45x-0pxhFiuIf3i3dJkFoi9qudE21NYRTS1XhZntk7pR7WXJQlFVuEzFFmOpHT1BlrSewozja_LqEwmr63w2rC8NXrqvXs5axQ7hflEVKLrbDrFHTL704cfugRDcl-3WyDB6woe90Wa2Hy_c8EzPlIguBrrg16PjBe10NwLVHouUku6qcMyIHBvcQeDXgUiztB6bOSBo1C42C5BTIThlS0RfuF5qp68qvbJo774AbnEouSsxY83gw0K-4mL0zB1YOH6okD1rWrwwDRdJwX9hVCEzI2n393OWWcwBYvP2WZIy_249ncCzz_RdmVcCtaewcm9VL3FvJi_9g02wSduS0-RKX0HmgSAh_c4MGamVYOJOrQYyp3quPMasSOFkNBeJqOeMm02jERJI23wtqKfcNq_UdbsWFGIHYC_nlLw3CmWD4-WQG3p2h1vZ5Ohq9dDyRywYUvIeY_WhVJOF5ryJJPqO1Y4bgczpvlUFR3nYYxZywA3MPXbANWy_fG9RDV6SoeQKoKlRWpIY3Q3ETUManoYwKe4V1Go-eaP56xDHtGeZ5TMF4268PMc8-tco_dcxG1umI8o"
      },
    );
    var data = jsonDecode(response.body.toString());

    print(data);
    if (response.statusCode == 200) {
      // for (Map i in data) {
      //   Customer photos = Customer(fristname: '');
      //   customerlist.add(photos);
      // }
      var jsonData = json.decode(response.body);

      customerlist.clear();

      // Iterate through each item in the "data" array and print the "first_name"
      for (var item in jsonData["data"]) {
        print("First Name: ${item["first_name"]}");
        Customer customer = Customer(
          id: item["id"],
          fristname: item["first_name"],
          mobile: item["mobile"],
          balance: item["balance"],
          total_rp: item["total_rp"],
          total_uised: item["total_rp_used"],
        );
        customerlist.add(customer);
      }
      return customerlist;
    } else {
      return customerlist;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    // Filter the list based on the search input
                    filteredList = customerlist
                        .where((customer) => customer.fristname
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                        .toList();
                  });
                },
                decoration: InputDecoration(
                    labelText: 'Search Your Customer',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddCustomer(
                                    customerName: "", customerid: 1),
                              ));
                        },
                        icon: Icon(Icons.person_add))),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: getPhotos(),
                  builder: (context, AsyncSnapshot<List<Customer>> snapshot) {
                    return ListView.builder(
                      itemCount: filteredList.length == 0
                          ? customerlist.length
                          : filteredList.length,
                      itemBuilder: (context, index) {
                        final customer = filteredList.length == 0
                            ? customerlist[index]
                            : filteredList[index];

                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CustomerProfile(
                                        totalrpused:
                                            customer.total_uised.toString(),
                                        totalrp: customer.total_rp.toString(),
                                        totalbalance:
                                            customer.balance.toString(),
                                        phonenumber: customer.mobile.toString(),
                                        customerid: customer.id,
                                        name: customer.fristname.toString(),
                                      ),
                                    ));
                              },
                              child: ListTile(
                                tileColor: Colors.white,
                                leading: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                    "https://img.freepik.com/free-vector/isolated-young-handsome-man-set-different-poses-white-background-illustration_632498-652.jpg?w=740&t=st=1706545131~exp=1706545731~hmac=ea778074807066d294b20b472bdcc549dd5078fa7f878048a21cb64c0f6f21a9",
                                  ),
                                ),
                                subtitle: Text(
                                  customer.mobile.toString(),
                                ),
                                title: Text(
                                  customer.fristname,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Color(0xff303030),
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.withOpacity(0.4),
                              thickness: 1.0,
                            ),
                          ],
                        );
                      },
                    );
                    ;
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class Customer {
  String fristname, mobile, balance;
  int id;
  final total_rp, total_uised;

  Customer(
      {required this.id,
      required this.fristname,
      required this.mobile,
      required this.balance,
      required this.total_rp,
      required this.total_uised});
}
