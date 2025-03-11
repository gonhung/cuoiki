import 'package:flutter_amazon_clone_bloc/src/data/datasources/api/chat_api.dart';
import 'package:http/http.dart' as http;

class ChatRepository {
  final ChatApi chatApi = ChatApi();

  Future<String> sendMessage({required String msg}) async {
    try {
      http.Response res = await chatApi.sendMessage(msg);

      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw Exception('Failed to fetch response: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
