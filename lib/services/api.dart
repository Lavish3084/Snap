import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:snap/helpers/constants.dart';
import 'package:snap/main.dart';
import 'package:snap/services/AuthService.dart';
import 'package:snap/widgets/snackbar.dart';

class MyHttp {
  // GET request
  static get(String endpoint, {params}) async {
    final url = Uri.parse('${Server.baseUrl}$endpoint').replace(queryParameters: params);
    var token = await AuthService.readToken();
    final response = await http.get(url,headers: {
      'Authorization':'Bearer $token'
    });

    var data={};
    if (response.statusCode == 200) {
      final responseData = response.body;
      data = jsonDecode(responseData);
    } else {
      final responseData = jsonDecode(response.body);
      openPrimarySnackBar(color: Colors.redAccent,navigatorKey.currentContext, responseData["result"]["error"].toString());
      print('Error: ${response.body}');
    }
    print(data);
    if(data!=null) return data['result']['response'];
    else return null;
  }

  // POST request
  static multipartPost(String endpoint,file) async {
    final url = Uri.parse('${Server.baseUrl}$endpoint');
    var token = await AuthService.readToken();
    final request = await http.MultipartRequest('POST', url);
    request.headers.addAll({"Content-Type": "application/json",'Authorization':'Bearer $token'});
    request.files.add(await http.MultipartFile.fromPath(
        'media',
        file.path,
        filename: path.basename(file.path),
    ));

    var response = await request.send();

    print("put request response: ${response.statusCode}");

    if (response.statusCode == 200) {
      print('File uploaded successfully');
      final responseBody = await response.stream.bytesToString();

      final responseJson = jsonDecode(responseBody);
      if(responseJson!=null && responseJson['result']['success']){
        return responseJson['result']['url'];
      }
    } else {
      print('Failed to upload file');
    }
    return null;
  }

  // POST request
  static post(String endpoint,body) async {
    print(body);
    final url = Uri.parse('${Server.baseUrl}$endpoint');
    var token = await AuthService.readToken();
    print("we have token: $token");
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json",'Authorization':'Bearer $token'},
      body: jsonEncode(body),
    );
    var data={};
    print("-------- post request --------");
    print(response.statusCode);
    print(response);
    if (response.statusCode == 200) {
      final responseData = response.body;
      data = jsonDecode(responseData);
    } else {
      final responseData = jsonDecode(response.body);
      openPrimarySnackBar(color: Colors.redAccent,navigatorKey.currentContext, responseData["result"]["error"].toString());
      print('Error: ${response.body}');
    }
    print(data);
    return data['result'];
  }

  // PUT request
  static put(String endpoint, body) async {
    print(body);
    final url = Uri.parse('${Server.baseUrl}$endpoint');
    var token = await AuthService.readToken();
    final response = await http.put(
      url,
      headers: {"Content-Type": "application/json",'Authorization':'Bearer $token'},
      body: jsonEncode(body),
    );
    var data={};
    if (response.statusCode == 200) {
      final responseData = response.body;
      data = jsonDecode(responseData);
    } else {
      final responseData = jsonDecode(response.body);
      openPrimarySnackBar(color: Colors.redAccent,navigatorKey.currentContext, responseData["result"]["error"].toString());
      print('Error: ${response.body}');
    }
    print(data);
    return data['result'];
  }

  // DELETE request
  static Future<http.Response> delete(String endpoint) async {
    final url = Uri.parse('${Server.baseUrl}$endpoint');
    final response = await http.delete(url);
    return response;
  }
}