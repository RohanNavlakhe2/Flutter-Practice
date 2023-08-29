import 'dart:convert';


import 'package:chitra/model/image_response.dart';
import 'package:chitra/network/custom_exception.dart';
import 'package:chitra/network/ui_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

class NetworkCall{

  NetworkCall._constructor();
  static final NetworkCall networkCall = NetworkCall._constructor();

  static final String _BASE_URL = "https://pixabay.com/api/?key=16267324-f1ef58206c55ac352a6b4a831";

   Future<ImageResponse> getImages(String imageQuery) async {
      http.Response httpResponse =  await http.get(_BASE_URL+imageQuery);
      if(httpResponse.statusCode == 200){
         return  ImageResponse.fromJsonMap(jsonDecode(httpResponse?.body));
      }else
        //If the response contains message then we can send the message here
        //Ex.  ImageResponse.fromJsonMap(jsonDecode(httpResponse?.body)).message
        //But in this case this response doesn't contain message field
        return throw FetchDataException("Error in Response");
  }



}