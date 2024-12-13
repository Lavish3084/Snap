
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:snap/helpers/constants.dart';
import 'package:snap/main.dart';
import 'package:snap/services/api.dart';
import 'package:snap/widgets/snackbar.dart';

class AuthService {
  static setToken(token) async{
    var _storage = FlutterSecureStorage();
    await _storage.write(key: "appAuthToken", value: token);
  }

  static readToken() async{
    var _storage = FlutterSecureStorage();
    return await _storage.read(key: "appAuthToken");
  }

  static deleteToken() async{
    var _storage = FlutterSecureStorage();
    await _storage.delete(key: "appAuthToken");
    return true;
  }

  static signup (email,phone,password) async{
    try{
      var result = await MyHttp.post(Server.signup, {"email":email,"phone":phone,"password":password});
      if(result != null && result['success']) return true;
      else return false;
    }catch(e){
      print("Error $e");
      openPrimarySnackBar(navigatorKey.currentContext, "Something went wrong $e",color: Colors.redAccent);
    }
  }

  static getUserProfile () async{
    try{
      var result = await MyHttp.get(Server.userProfile);
      print("check it out $result");
      return result;
    }catch(e){
      print("Error $e");
      // openPrimarySnackBar(navigatorKey.currentContext, "Something went wrong",color: Colors.redAccent);
    }
  }

  static verifyOtpSignup (email,phone,otp,password,accountType) async{
    try{
      var result = await MyHttp.post(Server.verifySignup, {"email":email,"phone":phone,"accountType":accountType,"otp":otp,"password":password});
      if(result != null && result['success'] && (result['token'] !=null)){
        await setToken(result['token']);
        return true;
      }else return false;
    }catch(e){
      print("Error $e");
      openPrimarySnackBar(navigatorKey.currentContext, "Something went wrong $e",color: Colors.redAccent);
    }
  }
  
  static login (phone,password) async{
    try{
      var result = await MyHttp.post(Server.login, {"phoneNumber":phone,"password":password});
      print("here is result $result");
      if(result != null && result['success'] && (result['token'] !=null)){
        await setToken(result['token']);
        return true;
      }else return false;
    }catch(e){
      print("Error $e");
      openPrimarySnackBar(navigatorKey.currentContext, "Something went wrong $e",color: Colors.redAccent);
    }
  }
  static register (body) async{
    try{
      var result = await MyHttp.post(Server.register, body);
      if(result != null && result['success']){
        return true;
      }else return false;
    }catch(e){
      print("Error $e");
      openPrimarySnackBar(navigatorKey.currentContext, "Something went wrong $e",color: Colors.redAccent);
    }
  }

  static start () async{
    try{
      var result = await MyHttp.post(Server.start, {});
      if(result != null && result['success']){
        return true;
      }else return false;
    }catch(e){
      print("Error $e");
      openPrimarySnackBar(navigatorKey.currentContext, "Something went wrong $e",color: Colors.redAccent);
    }
  }

  static stop () async{
    try{
      var result = await MyHttp.post(Server.stop, {});
      if(result != null && result['success']){
        return true;
      }else return false;
    }catch(e){
      print("Error $e");
      openPrimarySnackBar(navigatorKey.currentContext, "Something went wrong $e",color: Colors.redAccent);
    }
  }

  static update (body) async{
    try{
      var result = await MyHttp.put(Server.userProfile, body);
      if(result != null && result['success']){
        return true;
      }else return false;
    }catch(e){
      print("Error $e");
      openPrimarySnackBar(navigatorKey.currentContext, "Something went wrong $e",color: Colors.redAccent);
    }
  }
}