import 'dart:developer';

import 'package:ai_detector/constant/const.dart';
import 'package:ai_detector/model/ai_res.dart';
import 'package:dio/dio.dart';

class DetectAIAPI {
  static Future<AIDetector> detectAI(String input) async {
    try {
      Dio dio = Dio(
        BaseOptions(
            baseUrl: Constant.BASE_URL,
            contentType: "application/json",
            receiveDataWhenStatusError: true),
      );
      final req = await dio.post('/roberta-base-openai-detector', data: {
        "inputs": input,
      });
      log(req.data.toString());
      final AIDetector res = AIDetector.fromJson(req.data[0][0]);
      return res;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
