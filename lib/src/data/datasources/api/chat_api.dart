import 'dart:convert';

import 'package:flutter_amazon_clone_bloc/src/utils/constants/strings.dart';
import 'package:flutter_amazon_clone_bloc/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class ChatApi {
  final client = http.Client();

  Future<http.Response> sendMessage(String msg) async {
    final token = await getToken();
    try {
      http.Response res = await client.post(Uri.parse(askAi),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
          body: jsonEncode({
            "msg": msg,
          }));

      return res;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
