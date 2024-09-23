import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/base/secure.dart';

class NetworkAssistantProvider with ChangeNotifier {
  Future<BaseNetworkResponse> getArticles() async {
    try {
      final url = Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=${SecureKeys.apiKey}");
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return BaseNetworkResponse.success(
          data: json.decode(response.body),
          statusCode: response.statusCode,
        );
      } else {
        return BaseNetworkResponse.failure(
          errorMessage: "Something went wrong.",
          statusCode: response.statusCode,
        );
      }
    } catch (error) {
      return BaseNetworkResponse.failure(
        errorMessage: "Something went wrong.",
        statusCode: 400,
      );
    }
  }
}

class BaseNetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final Map<String, dynamic>? data;
  final String? errorMessage;

  BaseNetworkResponse.success({
    required this.data,
    required this.statusCode,
  })  : isSuccess = true,
        errorMessage = null;

  BaseNetworkResponse.failure({
    required this.statusCode,
    this.errorMessage,
  })  : isSuccess = false,
        data = null;
}

class BaseNetworkRequest {
  final Map<String, String>? headers;
  final Map<String, String>? queryParams;
  final Map<String, dynamic>? body;
  final int numberOfRetryAttempts;

  BaseNetworkRequest({
    this.headers,
    this.body,
    this.queryParams,
    this.numberOfRetryAttempts = 1,
  }) : assert(numberOfRetryAttempts >= 1 && numberOfRetryAttempts <= 8);
}

class ErrorBody {
  String? message;
  String? rawMessage;

  ErrorBody({
    this.message,
    this.rawMessage,
  });

  ErrorBody copyWith({
    String? message,
    String? rawMessage,
  }) =>
      ErrorBody(
        message: message ?? this.message,
        rawMessage: rawMessage ?? this.rawMessage,
      );

  factory ErrorBody.fromMap(Map<String, dynamic> json) => ErrorBody(
        message: json['message'],
        rawMessage: json['rawMessage'],
      );

  @override
  String toString() {
    return '{ message : ${message.toString()}, rawMessage : ${rawMessage.toString()}, }';
  }
}
