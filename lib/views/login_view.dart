import 'dart:developer';

import 'package:company_chat_app/helper/constants.dart';
import 'package:company_chat_app/helper/methods.dart';
import 'package:company_chat_app/views/chat_view.dart';
import 'package:company_chat_app/views/register_view.dart';
import 'package:company_chat_app/widgets/custom_button.dart';
import 'package:company_chat_app/widgets/custom_textFiled.dart';
import 'package:company_chat_app/widgets/custom_verticle_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});
  static const id = "Login_view";

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                const CustomVerticleSize(
                  height: 50,
                ),
                Image.asset(
                  KImageAnssets,
                  fit: BoxFit.fill,
                  height: 130,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Company chat",
                        style: TextStyle(
                          fontFamily: "PACIFICO",
                          fontSize: 24,
                          color: Colors.white,
                        )),
                  ],
                ),
                const CustomVerticleSize(
                  height: 50,
                ),
                const Row(
                  children: [
                    Text("LOGIN",
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                        )),
                  ],
                ),
                const CustomVerticleSize(),
                CustomTextFormfiled(
                  onChanged: (data) {
                    email = data;
                  },
                  hintText: "Email",
                ),
                const CustomVerticleSize(),
                CustomTextFormfiled(
                  onChanged: (data) {
                    password = data;
                  },
                  hintText: "Password",
                ),
                const CustomVerticleSize(),
                CustomButton(
                  title: "Login",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        log("in try");
                        UserCredential credential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: email!, password: password!);
                        log("end try");
                        ShowSnackBar(context, message: "Successfully");
                        Navigator.pushNamed(context, chatView.id);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          log("I'm here");
                          ShowSnackBar(context,
                              message: "No user found for that email");
                        } else if (e.code == 'wrong-password') {
                          log("I'm here");
                          ShowSnackBar(context,
                              message: "Wrong enterd password for that user");
                        }
                      } catch (ex) {
                        log("I'm here");
                        log(ex.toString());
                        print(ex.toString());
                        ShowSnackBar(context, message: ex.toString());
                      }
                      isLoading = false;
                      setState(() {});
                    } else {}
                  },
                ),
                const CustomVerticleSize(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => RegisterView())
                        //     );
                        Navigator.of(context).pushNamed(RegisterView.id);
                      },
                      child: const Text(
                        "   Register",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
