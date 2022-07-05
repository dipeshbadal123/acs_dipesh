import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

openDialog(String message) {
  Get.dialog(
    AlertDialog(
      title: const Text('Status'),
      content: Text(message.toString()),
      actions: [
        TextButton(
          child: const Text("Close"),
          onPressed: () => Get.back(),
        ),
      ],
    ),
  );
}
