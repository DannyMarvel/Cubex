 import 'dart:convert';
import 'dart:io';

class Helpers{

  static Future<String> getFileString({required String filePath}) async {
   
  List<int> imageBytes = await File(filePath).readAsBytes();

  return base64Encode(imageBytes);

  }
}

