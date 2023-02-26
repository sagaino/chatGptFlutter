import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:inogpt/constants/api_constants.dart';
import 'package:inogpt/models/chat_models.dart';
import 'package:inogpt/models/model_models.dart';

class ApiServices {
  static Future<List<ModelModels>> getModels() async {
    try {
      final respone = await http.get(
        Uri.parse(
          "$BASE_URL/models",
        ),
        headers: {
          "Authorization": "Bearer $API_KEY",
        },
      );
      Map jsonRespone = jsonDecode(respone.body);

      if (jsonRespone["error"] != null) {
        // print("jsonRespone: ${jsonRespone["error"]['message']}");
        throw HttpException(jsonRespone["error"]['message']);
      }
      // print("jsonRespone $jsonRespone");
      // List temp = [];
      // for(var val in jsonRespone["data"]){
      //   temp.add(val);
      // }
      return ModelModels.modelFromSnapshot(jsonRespone["data"]);
    } catch (error) {
      log("error $error");
      rethrow;
    }
  }

  static Future<List<ChatModel>> sendMessage({
    required String message,
    required String modelId,
  }) async {
    try {
      final respone = await http.post(
        Uri.parse(
          "$BASE_URL/completions",
        ),
        headers: {
          "Authorization": "Bearer $API_KEY",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "model": modelId,
            "prompt": message,
            "max_tokens": 999,
          },
        ),
      );

      Map jsonRespone = jsonDecode(respone.body);

      if (jsonRespone["error"] != null) {
        throw HttpException(jsonRespone["error"]['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonRespone["choices"].length > 0) {
        // log("data: ${jsonRespone["choices"][0]["text"]}");
        chatList = List.generate(
          jsonRespone["choices"].length,
          (index) => ChatModel(
            msg: jsonRespone["choices"][index]["text"],
            chatIndex: 1,
          ),
        );
      }
      return chatList;
    } catch (e) {
      log("error $e");
      rethrow;
    }
  }
}
