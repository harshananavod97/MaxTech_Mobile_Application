import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:maxtech/constant/api_consts.dart';
import 'package:maxtech/screens/Main_Page.dart';

import 'package:maxtech/screens/login_page_screen.dart';
import 'package:maxtech/screens/pendingscreen.dart';

import 'dart:async'; //
import 'package:maxtech/utils/colors.dart';

import 'package:shared_preferences/shared_preferences.dart';

class DashBoardService {
  static List<DashBord> dashbordList = [];
  //Token Load Api

  static Future<List<DashBord>> getdash(
    String Stratdate,
    enddate,
    locationid
  ) async {
    final response = await http.get(
      Uri.parse(
          'https://newmaxtechnology.clickypos.com/connector/api/get/total?'
    'start=$Stratdate&end=$enddate&location_id=$locationid'),
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
      //   dashbordList.add(photos);
      // }
      var jsonData = json.decode(response.body);

      dashbordList.clear();

      // Iterate through each item in the "data" array and print the "first_name"

      DashBord dash = DashBord(
        total_sell: data["total_sell"],
        total_sell_return: data["total_sell_return"],
        total_purchase: data["total_purchase"],
        total_purchase_return: data["total_purchase_return"],
        net: data["net"],
      );
      dashbordList.add(dash);
    }
    return dashbordList;
  }
}

class DashBord {
  String total_sell, total_sell_return, total_purchase;
  final total_purchase_return, net;

  DashBord(
      {required this.total_sell,
      required this.total_sell_return,
      required this.total_purchase,
      required this.total_purchase_return,
      required this.net});
}
