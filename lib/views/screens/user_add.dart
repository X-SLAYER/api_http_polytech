import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http_api_test/services/http_service.dart';
import 'package:http_api_test/views/screens/user_display.dart';
import 'package:http_api_test/views/widgets/inpute_text.dart';

class UserAdd extends StatefulWidget {
  const UserAdd({Key? key}) : super(key: key);

  @override
  State<UserAdd> createState() => _UserAddState();
}

class _UserAddState extends State<UserAdd> {
  late TextEditingController _userController;
  late TextEditingController _passwordController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _userController = TextEditingController();
    _passwordController = TextEditingController();
  }

  addUser() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 3));
    HttpService.addUser(_userController.text, _passwordController.text)
        .then((response) {
      log("$response");
      setState(() {
        isLoading = false;
      });
    }).catchError((error) {
      log("Error: $error");
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add User")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add new user here",
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 25.0),
              ),
              const SizedBox(height: 25.0),
              TextInput(
                label: "Name",
                controller: _userController,
                icon: Icons.email,
              ),
              const SizedBox(height: 10.0),
              TextInput(
                label: "Age",
                controller: _passwordController,
                icon: Icons.lock,
              ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    addUser();
                  },
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : const Text(
                          "Add New User",
                          style: TextStyle(color: Colors.white),
                        ),
                  style: TextButton.styleFrom(
                      backgroundColor:
                          const Color.fromARGB(255, 113, 121, 128)),
                ),
              ),
              const SizedBox(height: 55.0),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const UsersList()));
                  },
                  child: const Text(
                    "Show All Users",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 58, 134, 201)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
