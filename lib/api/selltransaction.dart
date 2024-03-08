import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:maxtech/models/CustomerDetails_model.dart';

class SellsCard {
  static List<SellTransaction> salesList = [];

  static Future<List<SellTransaction>> GetSellsTransaction(
      String token, int contactid) async {
    try {
      final response = await http.get(
        Uri.parse(
            "https://newmaxtechnology.clickypos.com/connector/api/customer/sells?"
            'contact_id=$contactid'),
        headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0In0.eyJhdWQiOiIxMCIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0IiwiaWF0IjoxNzA4MDg0MzYxLCJuYmYiOjE3MDgwODQzNjEsImV4cCI6MTczOTcwNjc2MSwic3ViIjoiMSIsInNjb3BlcyI6W119.nE6jpMdFZR10duRar6fXe3r4zbWk3kR1Tio-nb2tfE385cgcZ5jJhyYBz7bsTt4O6E8GlDcrRSy01ASHc5Yss-eIstz37g9U3d5RkENI1BQ9SGZAVhFX1am9C5HIB_DW4Lcs9HF8IrwZ7KVnVHIV94azoKSlhTZ6v0soNIjVDMDOzQOOPqe6fY9uNYpIxR1m4kJ-iUYWn_8gyGZlHq6K8G1NV1UFL0bkpakES5_owjLJgGSG_ljhmGIe6Qx1ymlRTALK2vB6sfOM0W0SO5T3lYEwSv_kgb79s3UwP5K-ib3k8H8LZkAa1Hll9oTUAGgKHAfCxBUs0Z39RZYx5kgKrCPhe3NqwED5phWQzCg-LofAPOfZS-T6P8vzgnvW9lH151nQHMeM1l5_fn16GeL21etW2Zu7iPyZtE19YRg1yRRD497eAPA3PyK_hRQMRLgaliwzjmrnuTxcD8HA0y8R0EAGqxO8hNlrufDaPNLsbCFTkG-02hwh-OHL7TdDyt2tBIlFNWhHwytRQtFS96isbJ2P3gzg8rooYstRE3j6sjMasMeETtJC7IQmCAwYPJqhADe7MpuFW_fjCemHi9gpOaOGSTyygOXUlDnRrh60ZxJaH8eJOu7q4KaiDDk88Sad82JiDU6alUDopNfxzJunwQX0Z8eqYqBHu4cwfAgNlCI", // Use the actual token variable
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        print("success");
        var jsonResponse = jsonDecode(response.body);

        salesList.clear();

        if (jsonResponse.containsKey('data')) {
          var data = jsonResponse['data'];

          if (data != null) {
            if (data is List) {
              for (var driverData in data) {
                SellTransaction sell = SellTransaction.fromJson(driverData);
                salesList.add(sell);
              }
            } else if (data is Map) {
              // If data is a map, you may need to handle it accordingly
              // For example, you might extract values and create a SellTransaction
              // based on your specific use case
            }
          }
        } else {
          print("Error: 'data' key not found in response");
        }
      } else {
        print("Error: ${response.statusCode}");
        // Handle the error accordingly
      }
    } catch (e) {
      print("Exception: $e");
      // Handle the exception accordingly
    }

    return salesList;
  }
}
