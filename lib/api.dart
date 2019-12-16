import 'dart:convert';

import 'package:app_10_fluttertube/app/models/video.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

const API_KEY = "AIzaSyB8mknlaIsQTb77sP34VJFsvn8_R2Vte7I";


class API {

  String _search;
  String _next;

  Future<List<Video>> search({
    @required String search,
    String next
  }) async {
    String url = "https://www.googleapis.com/youtube/v3/search?"
        "part=snippet"
        "&q=$search"
        "&type=video"
        "&key=$API_KEY"
        "&maxResults=10";

    try{
      _search = search;
      var response = await Dio().get(url);
      return decode(response);
    }catch(exp){
      throw exp;
    }

  }

  Future<List<Video>> next() async {
    String url = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_next";
    try{
      var response = await Dio().get(url);
      return decode(response);
    }catch(exp){
      throw exp;
    }
  }

  List<Video> decode(response){
    if(response?.statusCode == 200){
      _next = response.data['nextPageToken'];
      return response.data['items'].map<Video>((json) => Video.fromJson(json)).toList();
    }


    throw Exception();
  }

  Future<List<String>> suggestions(String query) async{
    String url = "http://suggestqueries.google.com/complete/search?"
        "hl=en&"
        "ds=yt&"
        "client=youtube&"
        "hjson=t&"
        "cp=1&"
        "q=$query&"
        "format=5"
        "&alt=json";

    var data = await Dio().get(url);
    return data.data[1].map<String>((i) => i[0].toString()).toList();
  }
}

//
//"http://suggestqueries.google.com/complete/search?hl=en&ds=yt&client=youtube&hjson=t&cp=1&q=$search&format=5&alt=json"