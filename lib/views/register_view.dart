import 'dart:developer';

import 'package:company_chat_app/helper/constants.dart';
import 'package:company_chat_app/helper/firebase/register.dart';
import 'package:company_chat_app/helper/methods.dart';
import 'package:company_chat_app/widgets/custom_button.dart';
import 'package:company_chat_app/widgets/custom_textFiled.dart';
import 'package:company_chat_app/widgets/custom_verticle_size.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterView extends StatefulWidget {
  RegisterView({super.key});

  static const String id = "Register_view";

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
                  "assets/images/cahtAppIcon.png",
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
                    Text("REGISTER",
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
                  title: "Register",
                  onTap: () async {
                    if (formKey.currentState!.validate()) {
                      isLoading = true;
                      setState(() {});
                      try {
                        await CreateAccount(context,
                            email: email!, password: password!);
                      } on FirebaseAuthException catch (ex) {
                        if (ex.code == 'weak-password') {
                          ShowSnackBar(context,
                              message: "The entered password is too weak");
                        } else if (ex.code == 'email-already-in-use') {
                          ShowSnackBar(context,
                              message:
                                  "The account already exists for that email");
                        }
                      } catch (e) {
                        ShowSnackBar(context, message: e.toString());
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
                      "Already have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => RegisterView())
                        //     );
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "   Login",
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
