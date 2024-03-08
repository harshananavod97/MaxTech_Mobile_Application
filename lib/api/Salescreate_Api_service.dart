import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maxtech/utils/colors.dart';

class SalescreateApiEndpoint {
  static Future<void> createsales(
      int customeid,
      String Salescreate,
      String type,
      double salesdiscount,

      // int productid,
      // double discountamout,
      // String discountType,
      // int quantity,
      // double price,
      List<Map<String, dynamic>> products,
      List<Map<String, dynamic>> payments,
      int locationid,
      String substatus,
      BuildContext context) async {
    final String apiUrl =
        'https://newmaxtechnology.clickypos.com/connector/api/sell';

    // Your JSON data
    Map<String, dynamic> postData = {
      "sells": [
        {
          "location_id": locationid,
          "contact_id": customeid,
          "transaction_date": Salescreate,
          "invoice_no": null,
          "source": "api, phone, woocommerce",
          "status": type,
          "sub_status": substatus,
          "is_quotation": false,
          "discount_amount": salesdiscount,
          "discount_type": "fixed",
          "sale_note": "qui",
          "staff_note": "unde",
          "commission_agent": null,
          "shipping_details": "Express Delivery",
          "shipping_address": "tenetur",
          "shipping_status": "ordered",
          "delivered_to": "'Mr robin'",
          "shipping_charges": 0,
          "packing_charge": 0,
          "exchange_rate": 1,
          "selling_price_group_id": null,
          "pay_term_number": 3,
          "pay_term_type": "months",
          "is_suspend": false,
          "is_recurring": 0,
          "recur_interval": 11,
          "recur_interval_type": "months",
          "subscription_repeat_on": 15,
          "subscription_no": "libero",
          "recur_repetitions": 19,
          "rp_redeemed": 0,
          "rp_redeemed_amount": 0,
          "types_of_service_id": null,
          "service_custom_field_1": "saepe",
          "service_custom_field_2": "enim",
          "service_custom_field_3": "quasi",
          "service_custom_field_4": "ut",
          "service_custom_field_5": "tempore",
          "service_custom_field_6": "optio",
          "round_off_amount": 0,
          "table_id": null,
          "service_staff_id": null,
          "change_return": 0,
          "products": products,
          "payments": payments
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0In0.eyJhdWQiOiIxMCIsImp0aSI6ImYzOWYyNDgwY2U5Y2JlMTI3ZmRjNTYyNmUyN2YwNzE3YzJiYzhiODYzOTUwYzg5ZThmYmUxYTFlNjZlM2U1ZGJjMTZmOWUzMjQzNWVjYmM0IiwiaWF0IjoxNzA4MDg0MzYxLCJuYmYiOjE3MDgwODQzNjEsImV4cCI6MTczOTcwNjc2MSwic3ViIjoiMSIsInNjb3BlcyI6W119.nE6jpMdFZR10duRar6fXe3r4zbWk3kR1Tio-nb2tfE385cgcZ5jJhyYBz7bsTt4O6E8GlDcrRSy01ASHc5Yss-eIstz37g9U3d5RkENI1BQ9SGZAVhFX1am9C5HIB_DW4Lcs9HF8IrwZ7KVnVHIV94azoKSlhTZ6v0soNIjVDMDOzQOOPqe6fY9uNYpIxR1m4kJ-iUYWn_8gyGZlHq6K8G1NV1UFL0bkpakES5_owjLJgGSG_ljhmGIe6Qx1ymlRTALK2vB6sfOM0W0SO5T3lYEwSv_kgb79s3UwP5K-ib3k8H8LZkAa1Hll9oTUAGgKHAfCxBUs0Z39RZYx5kgKrCPhe3NqwED5phWQzCg-LofAPOfZS-T6P8vzgnvW9lH151nQHMeM1l5_fn16GeL21etW2Zu7iPyZtE19YRg1yRRD497eAPA3PyK_hRQMRLgaliwzjmrnuTxcD8HA0y8R0EAGqxO8hNlrufDaPNLsbCFTkG-02hwh-OHL7TdDyt2tBIlFNWhHwytRQtFS96isbJ2P3gzg8rooYstRE3j6sjMasMeETtJC7IQmCAwYPJqhADe7MpuFW_fjCemHi9gpOaOGSTyygOXUlDnRrh60ZxJaH8eJOu7q4KaiDDk88Sad82JiDU6alUDopNfxzJunwQX0Z8eqYqBHu4cwfAgNlCI",
        },
        body: jsonEncode(postData),
      );

      var data = jsonDecode(response.body);

      print(data);
      print(response.body);
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: kPrimary,
            content: Text('Sales Created Sucessfully'),
          ),
        );

        Navigator.pop(context);
        print(response.body);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: kPrimary,
            content: Text('Sales Created Unsucessfully'),
          ),
        );
      }
    } catch (error) {
      print('Exception: $error');
    }
  }
}
