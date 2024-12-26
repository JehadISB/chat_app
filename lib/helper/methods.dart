import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
