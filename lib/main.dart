import 'package:company_chat_app/firebase_options.dart';
import 'package:company_chat_app/views/chat_view.dart';
import 'package:company_chat_app/views/login_view.dart';
import 'package:company_chat_app/views/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const CompanyChatApp());
}

class CompanyChatApp extends StatelessWidget {
  const CompanyChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: LoginView(),
      theme: ThemeData(useMaterial3: false),
      debugShowCheckedModeBanner: false,
      routes: {
        RegisterView.id: (context) => RegisterView(),
        LoginView.id: (context) => LoginView(),
        chatView.id: (context) => chatView(),
      },
      initialRoute: LoginView.id,
    );
  }
}
