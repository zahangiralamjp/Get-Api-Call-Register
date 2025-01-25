import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostRegisterScreen extends StatefulWidget {
  const PostRegisterScreen({super.key});

  @override
  State<PostRegisterScreen> createState() => _PostRegisterScreenState();
}

class _PostRegisterScreenState extends State<PostRegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  registerUser(String email, String password) async {
    Uri url = Uri.parse("https://reqres.in/api/register");
    //
    var data = {
      "email": email,
      "password": password,
    };
    try {
      var response = await http.post(url, body: data);
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        print(jsonData);
        print("Registered Successfully");
      } else {
        var error = jsonDecode(response.body);
        print("Unable to Register: ${error['error']}");
      }
    } catch (e) {
      print("Error:$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Post API"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: "User",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "Password",
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                registerUser(emailController.text.toString(),
                    passwordController.text.toString());
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blue),
                child: const Center(
                    child: Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}