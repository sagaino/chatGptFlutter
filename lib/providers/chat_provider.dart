import 'package:flutter/material.dart';
import 'package:inogpt/models/chat_models.dart';

import '../services/api_services.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatList {
    return chatList;
  }

  void addUserMessage({
    required String msg,
  }) async {
    chatList.add(
      ChatModel(
        msg: msg.trim(),
        chatIndex: 0,
      ),
    );
    notifyListeners();
  }

  Future<void> sendMessage({required String msg, required String choosenModel}) async {
    chatList.addAll(
      await ApiServices.sendMessage(
        message: msg.trim(),
        modelId: choosenModel,
      ),
    );
    notifyListeners();
  }
}
