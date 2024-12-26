import 'package:company_chat_app/helper/constants.dart';
import 'package:company_chat_app/widgets/chatt_bubble.dart';
import 'package:flutter/material.dart';

class chatView extends StatelessWidget {
  const chatView({super.key});
  static const id = "Chat_view";
  @override
  Widget build(BuildContext context) {
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
          Expanded(child: ListView.builder(itemBuilder: (context, index) {
            return Align(alignment: Alignment.centerLeft, child: ChatBuble());
          })),
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
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
                  suffixIcon:
                      IconButton(onPressed: null, icon: Icon(Icons.send))),
            ),
          )
        ],
      ),
    );
  }
}
