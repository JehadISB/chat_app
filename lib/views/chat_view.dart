import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company_chat_app/helper/constants.dart';
import 'package:company_chat_app/helper/methods.dart';
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
    final _scrollController = ScrollController();
    var email = ModalRoute.of(context)!.settings.arguments;
    log("Email@@=>$email");
    // return FutureBuilder<QuerySnapshot>(
    return StreamBuilder<QuerySnapshot>(
        // future: messagesCollection.get(),
        stream: messagesCollection
            .orderBy(kCreatedAtField, descending: true)
            .snapshots(),
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
                    Image.asset(KImageAssets, fit: BoxFit.fill, height: 40),
                    const Text("Chat")
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        reverse: true,
                        itemCount: lsitOfMessages.length,
                        itemBuilder: (context, index) {
                          log("in list ${lsitOfMessages[index]}");
                          log("in list Message: ${lsitOfMessages[index].id}");
                          log("in list ID: ${lsitOfMessages[index].message}");
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: lsitOfMessages[index].id == email
                                ? ChatBuble(
                                    messageModel: lsitOfMessages[index],
                                  )
                                : ChatBubleFromFriend(
                                    messageModel: lsitOfMessages[index]),
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
                          kIdField: email,
                        });
                        textEditingController.clear();
                        _scrollController.animateTo(
                            // _scrollController.position.maxScrollExtent,
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor),
                          ),
                          hintText: "type message",
                          suffixIcon: const IconButton(
                              onPressed: null, icon: Icon(Icons.send))),
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                // centerTitle: true,

                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(KImageAssets, fit: BoxFit.fill, height: 40),
                    const Text("Chat")
                  ],
                ),
              ),
              body: const Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    Text("oops there was an error!, try agian"),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: kPrimaryColor,
                automaticallyImplyLeading: false,
                // centerTitle: true,

                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(KImageAssets, fit: BoxFit.fill, height: 40),
                    const Text("Chat")
                  ],
                ),
              ),
              body: const Center(
                child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ),
              ),
            );
          }
        });
  }
}
