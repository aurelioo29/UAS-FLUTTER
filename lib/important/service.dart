import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:uas_project/important/response.dart';

class ApiService {
  Future<PostResponse?> getPost() async {
    try {
      final response =
          await Dio().get('http://192.168.18.6/flutter-api/select.php');
      debugPrint('GET POST : ${response.data}');
      return PostResponse.fromJson(response.data);
    } on DioException catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
