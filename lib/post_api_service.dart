import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:post_api/post_model.dart';

class ApiServices{
  Future<bool> login(String login, String password) async{
    try{
      var url =Uri.parse("https://recruitment-api.pyt1.stg.jmr.pl/login");

      var response=await http.post(
          url,
          body:jsonEncode({
        "login": login,
        "password": password,
      }),
          headers: {"Content-Type": "application/json"}
      );

      if(response.statusCode==200){
        LoginModel model=LoginModel.fromJson(jsonDecode(response.body));
        print("Message:${model.message}");
        Fluttertoast.showToast(
            msg: "${model.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return true;
      } else if(response.statusCode==400){
        Fluttertoast.showToast(
            msg: "Login failed. Please check your credentials.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        return false;
      }
    }catch(e){
      print(e.toString());
    }
    return false;
  }
}



