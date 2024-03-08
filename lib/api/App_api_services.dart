import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:maxtech/constant/api_consts.dart';
import 'package:maxtech/screens/Main_Page.dart';


import 'dart:async'; //
import 'package:maxtech/utils/colors.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AppApiServices {
  //Token Load Api

  static FutureOr<String> getToken(String grant_type, client_id, client_secret,
      username, password, BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "grant_type": grant_type,
      "client_id": client_id,
      "client_secret": client_secret,
      "username": username,
      "password": password,
    };

    String body = json.encode(data);
    var url = Uri.parse("https://newmaxtechnology.clickypos.com/oauth/token");

    try {
      var response = await http.post(url, headers: {
        "accept": "application/json",
      }, body: {
        "grant_type": grant_type,
        "client_id": client_id,
        "client_secret": client_secret,
        "username": username,
        "password": password,
      });

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);

        String accessToken = responseBody['access_token'];
        return accessToken;
        return "";
      } else if (response.statusCode == 422) {
        return "";
      } else if (response.statusCode == 400) {
        return "";
      } else if (response.statusCode == 403) {
        return "";
      } else if (response.statusCode == 401) {
        return "";
      } else {
        return "";
      }
    } catch (e) {
      print(e);
    }
    return "";
  }

  //login Api End Points

  static FutureOr<void> login(
      String Username, String password, BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    var url = Uri.parse(
        "https://newmaxtechnology.clickypos.com/connector/api/user/loggedin?username=$Username&password=$password");

    try {
      var response = await http.get(
        url,
        headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjdkNjhiZWJjYjNlMmMwMDlmZWFlM2YzOWM4N2IwNDdhZTQ0OWEzMWI4NzkyNjY2OWQ3NzQwMWNjYTY2NWI1NTk1ZjM4YzQ3YTEyZjljMjE1In0.eyJhdWQiOiIxMCIsImp0aSI6IjdkNjhiZWJjYjNlMmMwMDlmZWFlM2YzOWM4N2IwNDdhZTQ0OWEzMWI4NzkyNjY2OWQ3NzQwMWNjYTY2NWI1NTk1ZjM4YzQ3YTEyZjljMjE1IiwiaWF0IjoxNzA2MzQzMjQzLCJuYmYiOjE3MDYzNDMyNDMsImV4cCI6MTczNzk2NTY0Mywic3ViIjoiMSIsInNjb3BlcyI6W119.nAFhAKb7R8IuETn0xYY5-riEPiyAQW49gNmnlWfRZWdchIPBOrt7DaUhcLbB957G1blo09gg4ZBRnIkN_nMD_IwNIH4Fi-lV1LH-NpbAD6HTCOZPSRLwYcOndc37-A4dddRa-Z8plT1WgeC-NzFW-pmW_FPreCWlcexN8V_bR1cpDDXnr9h472Cz5V9N_6wPNLc9R6fHtgDGUYlwvkseedoAwRkZM62gkR89N01rw2hjBxZA2dg-ZfSZWNCMKLhMUFFoNK4oxi6hvjXnsMJw9RF0mR1LzncUQ8Lx8DEYa8eoqLL8a9KBACZtlE-VJZpJCnUSYlgpgDhTz3uDeNbzFPSpu1WAzlHs6Cv5NV11RU8fR7H4ewHT23_jlC1EaYoAxOTOafqO_MzYRWHlY6A3MT6p0X92ngtlDFFSjXTRZIXokpjPX7dNYGKviyfdaU9v4QM43W6Ruh3NeSQzAJPZR-NorbnyOIkNnRUmgDV_bhOXkRHt3gG_kOgXQ0GDvK4H8fFcJfu_9CfoqoQ4c0FqArZrwVupmWu_G9O-8FnULtpZ1fEw5z1_0AYn4vSwgpmn4uIBxFNWbjJKzaUpIYI3Sq7Ytr5uhH8TiPm_EcCm9DkQFqOwXJiKjCMu9LqtIYobDPNTLJ3zvjqKPzvElcgMXw-s-ZR1TikWBV_Y3ZlGs04"
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        pref.setBool('login', true);
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String accessToken = jsonResponse['status'];

        if (accessToken == "Username Or Password is incerect.!") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: kPrimary,
              content:
                  Center(child: Text('Username Or Password is incerect.!')),
            ),
          );
        } else {
          
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: kPrimary,
              content: Center(child: Text('Wellcome To MaxTach')),
            ),
          );
        }
      } else if (response.statusCode == 422) {
      } else if (response.statusCode == 400) {
      } else if (response.statusCode == 403) {
      } else if (response.statusCode == 401) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Before Login Create Your Profile'),
          ),
        );
      }
    } catch (e) {
      print(e);

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MainPage(),
          ));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: kPrimary,
          content: Center(child: Text('Wellcome To MaxTach')),
        ),
      );
    }
  }

//Get Customers Details
  static FutureOr<void> getCustomers(BuildContext context) async {
    var url = Uri.parse(
        "https://newmaxtechnology.clickypos.com/connector/api/contactapi");

    try {
      var response = await http.get(
        url,
        headers: {
          "accept": "application/json",
          "Authorization":
              "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA3MjBjYjM4NWI1ZDM5MDM1NjUzNmIyMGQzM2FlNTA4OTZjYjUwMTQzMzhkNWYzYWFlYTUwMjU5Yzg2YmZkYzAyZmQzOGMxNDFmYTE2MGY1In0.eyJhdWQiOiIxMCIsImp0aSI6IjA3MjBjYjM4NWI1ZDM5MDM1NjUzNmIyMGQzM2FlNTA4OTZjYjUwMTQzMzhkNWYzYWFlYTUwMjU5Yzg2YmZkYzAyZmQzOGMxNDFmYTE2MGY1IiwiaWF0IjoxNzA2NTEyMzIxLCJuYmYiOjE3MDY1MTIzMjEsImV4cCI6MTczODEzNDcyMSwic3ViIjoiMSIsInNjb3BlcyI6W119.Ut8kcatFaP9P6qUEsxPWL2DjELXRuaBkdVqdnOx_dN_0mZDdRYManjkux4JVrYKW4hPCFaGWLMi9V-TK5Y61-9V4_u7AemrwmuON45x-0pxhFiuIf3i3dJkFoi9qudE21NYRTS1XhZntk7pR7WXJQlFVuEzFFmOpHT1BlrSewozja_LqEwmr63w2rC8NXrqvXs5axQ7hflEVKLrbDrFHTL704cfugRDcl-3WyDB6woe90Wa2Hy_c8EzPlIguBrrg16PjBe10NwLVHouUku6qcMyIHBvcQeDXgUiztB6bOSBo1C42C5BTIThlS0RfuF5qp68qvbJo774AbnEouSsxY83gw0K-4mL0zB1YOH6okD1rWrwwDRdJwX9hVCEzI2n393OWWcwBYvP2WZIy_249ncCzz_RdmVcCtaewcm9VL3FvJi_9g02wSduS0-RKX0HmgSAh_c4MGamVYOJOrQYyp3quPMasSOFkNBeJqOeMm02jERJI23wtqKfcNq_UdbsWFGIHYC_nlLw3CmWD4-WQG3p2h1vZ5Ohq9dDyRywYUvIeY_WhVJOF5ryJJPqO1Y4bgczpvlUFR3nYYxZywA3MPXbANWy_fG9RDV6SoeQKoKlRWpIY3Q3ETUManoYwKe4V1Go-eaP56xDHtGeZ5TMF4268PMc8-tco_dcxG1umI8o"
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        // Parse JSON response
        var jsonData = json.decode(response.body);

        // Iterate through each item in the "data" array and print the "first_name"
        for (var item in jsonData["data"]) {
          print("First Name: ${item["first_name"]}");
        }
      } else if (response.statusCode == 422) {
        // Handle 422 status code
      } else if (response.statusCode == 400) {
        // Handle 400 status code
      } else if (response.statusCode == 403) {
        // Handle 403 status code
      } else if (response.statusCode == 401) {
        // Handle 401 status code
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again later.'),
          ),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }


  ////jkkk//////////////////////////////////////

  static FutureOr<void> VerifyCode(
      String otpcode, String number, BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    var url = Uri.parse(
        "$Common_Base_URL/connector/api/check/verification/otp?mobile=$number&app_login_otp=$otpcode");

    try {
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String message = jsonResponse["status"];

        if (message == "OTP is Matched.!") {
          const SnackBar(
            content: Text('OTP is Matched.!'),
          );
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ));
        } else if (message == "OTP is Invalid.!") {}
      } else if (response.statusCode == 208) {
        const SnackBar(
          content: Text("OTP is Invalid.!"),
        );
      } else if (response.statusCode == 422) {
      } else if (response.statusCode == 400) {
      } else if (response.statusCode == 403) {
      } else if (response.statusCode == 401) {
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Before Login Create Your Profile'),
          ),
        );
      }
    } catch (e) {
      print(e);

      // Display a Snackbar message to show the error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

  static gg(String email, password, BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      "email": email,
      "password": password,
    };

    String body = json.encode(data);
    var url = Uri.parse(Common_Base_URL + "/Auth/UserLogin");

    try {
      var response = await http.post(
        url,
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
        },
      );

      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        // Logger().i('success custom login');
        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String message = jsonResponse["message"];
        String token = jsonResponse["content"]["jwtAuthResponse"]["token"];
        bool hasUserProfile = jsonResponse["content"]["hasUpserProfile"];
        bool hasIdealClien = jsonResponse["content"]["hasIdealClient"];

        await pref.setString('UserState', message);
        await pref.setString('UserToken', token);
        await pref.setString('UserEmail', email.toString());

        print("Status: $message");
        print("Token: $token");
        print("has profile" + hasUserProfile.toString());
        bool ideal = false;
      } else {
        await pref.setString('UserEmail', email.toString());

        Map<String, dynamic> jsonResponse = json.decode(response.body);

        String message = jsonResponse["message"];
        await pref.setString('UserState', message);
        print("message: $message");

        // Display error message in a Snackbar
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(message),
        //   ),
        // );

        if (message == "Pending") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const PendingApproval(),
          //   ),
          // );
        }
      }
    } catch (e) {
      print(e);

      // Display a Snackbar for the network error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: kPrimary,
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

  static verify(String email, code, password, BuildContext context) async {
    final pref = await SharedPreferences.getInstance();

    print("Email is" + email);
    print("code is" + code.toString());

    var url = Uri.parse(
        Common_Base_URL + "/Auth/VerifyEmail?email=$email&code=$code");
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "accept": "application/json",
      },
    );

    print(response.body);
    print(response.statusCode);

    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        String message = jsonResponse["message"];
        await pref.setString('UserState', message);
        print("message: $message");
        if (message == "Pending") {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const PendingApproval(),
          //   ),
          // );
        } else {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => WillPopScope(
          //       onWillPop: () async {
          //         // Return false to prevent popping the current screen.
          //         return false;
          //       },
          //       child: CreateProfile(),
          //     ),
          //   ),
          // );
        }
      } else if (response.statusCode == 422) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isloged", false);

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => const SingInScreen()),
        //     (route) => false);
      } else if (response.statusCode == 400) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isloged", false);

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => const SingInScreen()),
        //     (route) => false);
      } else if (response.statusCode == 403) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isloged", false);

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => const SingInScreen()),
        //     (route) => false);
      } else if (response.statusCode == 401) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setBool("isloged", false);

        // Navigator.of(context).pushAndRemoveUntil(
        //     MaterialPageRoute(builder: (context) => const SingInScreen()),
        //     (route) => false);
      } else {}
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: kPrimary,
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }
}
