import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maxtech/screens/Customer/Customer_Profile_Page.dart';

class InventryPage extends StatefulWidget {
  const InventryPage({super.key});

  @override
  State<InventryPage> createState() => _InventryPageState();
}

class _InventryPageState extends State<InventryPage> {
  TextEditingController searchController = TextEditingController();
  List<Customer> customerlist = [];
  List<Customer> filteredList = [];
  Future<List<Customer>> getPhotos() async {
    final response = await http.get(
      Uri.parse('https://newmaxtechnology.clickypos.com/connector/api/product'),
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
      //   Customer photos = Customer(name: '');
      //   customerlist.add(photos);
      // }
      var jsonData = json.decode(response.body);

      customerlist.clear();

      // Iterate through each item in the "data" array and print the "first_name"
      for (var item in jsonData["data"]) {
        print("First Name: ${item["first_name"]}");
        Customer customer = Customer(
          name: item["name"],
          Productimage: item["image_url"],
          balance: item["name"],
          CurrentStock: item["enable_stock"],
          total_uised: item["name"],
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
    return Scaffold(
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
                      .where((customer) => customer.name
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                      .toList();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search Product',
                prefixIcon: Icon(Icons.search),
              ),
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
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => CustomerProfile(
                              //         totalrpused:
                              //             customer.total_uised.toString(),
                              //         totalrp: customer.CurrentStock.toString(),
                              //         totalbalance: customer.balance.toString(),
                              //         name: customer.name,
                              //         phonenumber: customer.Productimage,
                              //       ),
                              //     ));
                            },
                            child: ListTile(
                              tileColor: Colors.white,
                              leading: Container(
                                  child: Image.network(
                                      customer.Productimage.toString())),
                              subtitle: Text('Current Stock - ' +
                                  customer.CurrentStock.toString()),
                              title: Text(
                                customer.name,
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
    );
  }
}

class Customer {
  String name, Productimage, balance;
  final CurrentStock, total_uised;

  Customer(
      {required this.name,
      required this.Productimage,
      required this.balance,
      required this.CurrentStock,
      required this.total_uised});
}
