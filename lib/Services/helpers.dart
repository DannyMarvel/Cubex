import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Helpers {
  static Future<String> getFileString({required String filePath}) async {
    List<int> imageBytes = await File(filePath).readAsBytes();

    return base64Encode(imageBytes);
  }

  ///
  static showToast({
    required String message,
    bool? isError,
    bool fromTop = false,
  }) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: fromTop ? ToastGravity.TOP : ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: isError ?? false ? Colors.red : Colors.green.shade300,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
