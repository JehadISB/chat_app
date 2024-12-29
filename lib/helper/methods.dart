import 'dart:developer';

import 'package:company_chat_app/models/message_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void ShowSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

List<MessageModel> fillMessagesList(List message) {
  List<MessageModel> messagesLists = [];
  for (int i = 0; i < message.length; i++) {
    // MessageModel.fromJson(message[i][kMessageField]);
    //messagesLists.add(message[i][kMessageField]);
    log("the !! ${message[i]}");
    messagesLists.add(MessageModel.fromJson(message[i]));
  }
  return messagesLists;
}
