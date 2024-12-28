import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_chat_app/helper/constants.dart';
import 'package:company_chat_app/models/message_model.dart';
import 'package:company_chat_app/widgets/chatt_bubble.dart';
import 'package:flutter/material.dart';

class chatView extends StatelessWidget {
  const chatView({super.key});
  static const id = "Chat_view";
  @override
  Widget build(BuildContext context) {
    CollectionReference messagesCollection =
        FirebaseFirestore.instance.collection(kCollectionName);
    TextEditingController textEditingController = TextEditingController();
    // return FutureBuilder<QuerySnapshot>(
    return StreamBuilder<QuerySnapshot>(
        // future: messagesCollection.get(),
        stream: messagesCollection.orderBy(kCreatedAtField).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List lsitOfMessages = fillMessagesList(snapshot.data!.docs);
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                // centerTitle: true,

                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(KImageAnssets, fit: BoxFit.fill, height: 40),
                    const Text("Chat")
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        // reverse: false,
                        itemCount: lsitOfMessages.length,
                        itemBuilder: (context, index) {
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: ChatBuble(
                              messageModel: lsitOfMessages[index],
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextField(
                      controller: textEditingController,
                      onSubmitted: (data) {
                        messagesCollection.add({
                          kMessageField: data,
                          kCreatedAtField: DateTime.now(),
                        });
                        textEditingController.clear();
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "type message",
                          suffixIcon: IconButton(
                              onPressed: null, icon: Icon(Icons.send))),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Center(
              child: Text("There is no message"),
            );
          }
        });
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
}
