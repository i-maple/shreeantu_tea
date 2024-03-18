import 'package:flutter/material.dart';

class SnackbarService {
  SnackbarService._();

  static showSuccessSnackbar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('🥳 $message'),
        backgroundColor: Colors.green,
      ),
    );
  }
  static showFailedSnackbar(BuildContext context, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('⚠️ $message'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
