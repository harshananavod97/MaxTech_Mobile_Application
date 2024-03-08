import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maxtech/screens/Main_Page.dart';
import 'package:maxtech/utils/colors.dart';

class CustomeCreateEndPoint {
  static Future<void> postData(
      String type,
      String supplier_business_name,
      String prefix,
      String first_name,
      String middle_name,
      String last_name,
      String tax_number,
      // String pay_term_number,
      String pay_term_type,
      String mobile,
      String landline,
      String alternate_number,
      String address_line_1,
      String address_line_2,
      String city,
      String state,
      String country,
      String zip_code,
      String customer_group_id,
      // String contact_id,
      String dob,
      String custom_field1,
      String custom_field2,
      String custom_field3,
      String custom_field4,
      String email,
      // String position,
      double opening_balance,
      // int source_id,
      // int life_stage_id,
      BuildContext context) async {
    var apiUrl =
        'https://newmaxtechnology.clickypos.com/connector/api/contactapi';

    var postData = {
      "type": type,
      "supplier_business_name": supplier_business_name,
      "prefix": prefix,
      "first_name": first_name,
      "middle_name": middle_name,
      "last_name": last_name,
      "tax_number": tax_number,
      "pay_term_number": null,
      "pay_term_type": pay_term_type,
      "mobile": mobile,
      "landline": landline,
      "alternate_number": alternate_number,
      "address_line_1": address_line_1,
      "address_line_2": address_line_2,
      "city": city,
      "state": state,
      "country": country,
      "zip_code": zip_code,
      "customer_group_id": "quaerat",
      "contact_id": "",
      "dob": dob,
      "custom_field1": custom_field1,
      "custom_field2": custom_field2,
      "custom_field3": custom_field3,
      "custom_field4": custom_field4,
      "email": email,
      "shipping_address": "non",
      "position": "voluptas",
      "opening_balance": opening_balance,
      "source_id": 19,
      "life_stage_id": 10,
    };
    try {
      var body = jsonEncode(postData);

      print('Request URL: $apiUrl');

      print('Request Body: $body');

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0In0.eyJhdWQiOiIxMCIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0IiwiaWF0IjoxNzA4MDg0MzYxLCJuYmYiOjE3MDgwODQzNjEsImV4cCI6MTczOTcwNjc2MSwic3ViIjoiMSIsInNjb3BlcyI6W119.nE6jpMdFZR10duRar6fXe3r4zbWk3kR1Tio-nb2tfE385cgcZ5jJhyYBz7bsTt4O6E8GlDcrRSy01ASHc5Yss-eIstz37g9U3d5RkENI1BQ9SGZAVhFX1am9C5HIB_DW4Lcs9HF8IrwZ7KVnVHIV94azoKSlhTZ6v0soNIjVDMDOzQOOPqe6fY9uNYpIxR1m4kJ-iUYWn_8gyGZlHq6K8G1NV1UFL0bkpakES5_owjLJgGSG_ljhmGIe6Qx1ymlRTALK2vB6sfOM0W0SO5T3lYEwSv_kgb79s3UwP5K-ib3k8H8LZkAa1Hll9oTUAGgKHAfCxBUs0Z39RZYx5kgKrCPhe3NqwED5phWQzCg-LofAPOfZS-T6P8vzgnvW9lH151nQHMeM1l5_fn16GeL21etW2Zu7iPyZtE19YRg1yRRD497eAPA3PyK_hRQMRLgaliwzjmrnuTxcD8HA0y8R0EAGqxO8hNlrufDaPNLsbCFTkG-02hwh-OHL7TdDyt2tBIlFNWhHwytRQtFS96isbJ2P3gzg8rooYstRE3j6sjMasMeETtJC7IQmCAwYPJqhADe7MpuFW_fjCemHi9gpOaOGSTyygOXUlDnRrh60ZxJaH8eJOu7q4KaiDDk88Sad82JiDU6alUDopNfxzJunwQX0Z8eqYqBHu4cwfAgNlCI"
        },
        body: body,
      );

      if (response.statusCode == 201) {
        print('Success! Response: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: kPrimary,
            content: Text('Customer Created Sucessfully'),
          ),
        );

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainPage(),
            ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: kPrimary,
            content: Text('Customer Created Unsucessfull'),
          ),
        );
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
