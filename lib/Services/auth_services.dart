import 'dart:convert';
import 'package:http/http.dart' as http;

import '../AppCommons/global.dart';

class AuthServices {
  var jsonResponse;
  emailAuth(String email, String reason) async {
    print('$uri2/send_email_code');
    print("$email");
    print("$reason");
    String url = '$uri2/send_email_code';
    try {
      var headers = {
        'Content-Type': 'application/json'
      };
      var request = http.Request('POST', Uri.parse(url));
      request.body = json.encode({
        "email": email,
        "reason": reason
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        jsonResponse = jsonDecode(await response.stream.bytesToString());
        return jsonResponse;      }
      else {
        print(response.reasonPhrase);
      }

    } catch (e) {
      print(e);
    }
  }
  signUpAuth(String email, String passCode) async {
    print("$uri2/login_signup");
    // try {
    //
    //
    // } catch (e) {
    //   print(e);
    // }
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://server.satoshiair.xyz/users/login_signup'));
    request.body = json.encode({
      "email": "$email",
      "emailCode": "$passCode"
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      jsonResponse = jsonDecode(await response.stream.bytesToString());
      return jsonResponse;
    }
    else {
      print(response.reasonPhrase);
    }
  }
  // loginAuth(String email, password) async {
  //   String url = '$uri/login';
  //   try {
  //     var jsonResponse;
  //     Map<String, dynamic> data = {"email": email,"password": password };
  //     var _body = jsonEncode(data);
  //     var response = await http.patch(Uri.parse(url), body: _body, headers: {
  //       'Content-Type': "application/json",
  //       // 'Authorization': 'Bearer $accessToken',
  //     });
  //     print("statuscode: ${response.statusCode}");
  //     print("statusCode: ${response.body}");
  //     if (response.statusCode == 200) {
  //       jsonResponse = jsonDecode(response.body);
  //       return jsonResponse;
  //     } else if (response.statusCode == 400) {
  //
  //     } else {
  //
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   // var headers = {
  //   //   'Content-Type': 'application/json'
  //   // };
  //   // var request = http.Request('POST', Uri.parse('$uri/auth/player/login'));
  //   // var decode;
  //   // request.body = json.encode({
  //   //   "mobile": mobile,
  //   // });
  //   // request.headers.addAll(headers);
  //   //
  //   // http.StreamedResponse response = await request.send();
  //   // print("response.statusCode: ${response.statusCode}");
  //   // if (response.statusCode == 200) {
  //   //   // print(response.stream);
  //   //   decode=json.decode(await response.stream.bytesToString());
  //   //   return decode;
  //   // }
  //   // else {
  //   // }
  // }
  // updatePassword(String email, String password, String passCode) async {
  //   String url = '$uri/update_password';
  //   try {
  //     var jsonResponse;
  //     Map<String, dynamic> data = {
  //       "email":email,
  //       "emailCode": passCode,
  //       "password": password
  //     };
  //     var _body = jsonEncode(data);
  //     var response = await http.patch(Uri.parse(url), body: _body, headers: {
  //       'Content-Type': "application/json",
  //       // 'Authorization': 'Bearer $accessToken',
  //     });
  //     print("statuscode: ${response.statusCode}");
  //     print("statusCode: ${response.body}");
  //     if (response.statusCode == 200) {
  //       jsonResponse = jsonDecode(response.body);
  //       return jsonResponse;
  //     } else if (response.statusCode == 400) {
  //
  //     } else {
  //
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   // var headers = {
  //   //   'Content-Type': 'application/json'
  //   // };
  //   // var request = http.Request('POST', Uri.parse('$uri/auth/player/login'));
  //   // var decode;
  //   // request.body = json.encode({
  //   //   "mobile": mobile,
  //   // });
  //   // request.headers.addAll(headers);
  //   //
  //   // http.StreamedResponse response = await request.send();
  //   // print("response.statusCode: ${response.statusCode}");
  //   // if (response.statusCode == 200) {
  //   //   // print(response.stream);
  //   //   decode=json.decode(await response.stream.bytesToString());
  //   //   return decode;
  //   // }
  //   // else {
  //   // }
  // }
  // deleteAccount(String email, String passCode) async {
  //   String url = '$uri/deleteAccount';
  //   try {
  //     var jsonResponse;
  //     Map<String, dynamic> data = {
  //       "email":email,
  //       "emailCode": passCode,
  //     };
  //     var _body = jsonEncode(data);
  //     var response = await http.patch(Uri.parse(url), body: _body, headers: {
  //       'Content-Type': "application/json",
  //       // 'Authorization': 'Bearer $accessToken',
  //     });
  //     print("statuscode: ${response.statusCode}");
  //     print("statusCode: ${response.body}");
  //     if (response.statusCode == 200) {
  //       jsonResponse = jsonDecode(response.body);
  //       return jsonResponse;
  //     } else if (response.statusCode == 400) {
  //
  //     } else {
  //
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  //   // var headers = {
  //   //   'Content-Type': 'application/json'
  //   // };
  //   // var request = http.Request('POST', Uri.parse('$uri/auth/player/login'));
  //   // var decode;
  //   // request.body = json.encode({
  //   //   "mobile": mobile,
  //   // });
  //   // request.headers.addAll(headers);
  //   //
  //   // http.StreamedResponse response = await request.send();
  //   // print("response.statusCode: ${response.statusCode}");
  //   // if (response.statusCode == 200) {
  //   //   // print(response.stream);
  //   //   decode=json.decode(await response.stream.bytesToString());
  //   //   return decode;
  //   // }
  //   // else {
  //   // }
  // }


  config(id, bearerToken, object, String endPoint, String method)async{
    String url = uri+endPoint;
    try {
      print('Config Object: $object');
      print('Config endPoint: $endPoint');
      print('Config method: $method');
      print('Config token: $bearerToken');
      print('Config userid: $id');
      var jsonResponse;
      Map<String, dynamic> data = object;
      // {"email": email,"password": password };
      var _body = jsonEncode(data);
      var response;

      if(method=="post"){
        response = await http.post(Uri.parse(url), body: _body, headers: {
          'Authorization': bearerToken,
          'Content-Type': 'application/json'          // 'Authorization': 'Bearer $accessToken',
        });
        print('statusCode: ${response.statusCode}');
      }
      else if(method=="patch"){
        print("patch");
        response = await http.patch(Uri.parse(url), body: _body, headers: {
          'Authorization': bearerToken,
          'Content-Type': "application/json",
          // 'Authorization': 'Bearer $accessToken',
        });
        print('statusCode: ${response.statusCode}');
      }
      print("statuscode: ${response.statusCode}");
      print("statusCode: ${response.body}");
      if (response.statusCode == 200 || response.statusCode==201) {
        jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else if (response.statusCode == 400) {
        jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      } else {

      }
    } catch (e) {
      print(e);
    }
  }
}