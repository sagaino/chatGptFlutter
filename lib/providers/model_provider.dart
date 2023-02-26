import 'package:flutter/material.dart';
import 'package:inogpt/models/model_models.dart';
import 'package:inogpt/services/api_services.dart';

class ModelProvider with ChangeNotifier {
  String currentModel = "text-davinci-003";
  String get getCurrentModel {
    return currentModel;
  }

  void setCurrentModel(String newModel) {
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelModels> modelList = [];

  List<ModelModels> get getModelList {
    return modelList;
  }

  Future<List<ModelModels>> getAllModels () async {
    modelList = await ApiServices.getModels();
    return modelList;
  }
}
