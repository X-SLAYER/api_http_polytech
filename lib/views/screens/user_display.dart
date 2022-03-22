import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:http_api_test/models/user.dart';
import 'package:http_api_test/services/http_service.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  State<UsersList> createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  List<User> usersList = [];

  displayUsers() {
    // await Future.delayed(const Duration(seconds: 3));
    setState(() {
      usersList.clear();
    });
    HttpService.userList().then((response) {
      log("$response");
      for (var json in (response as List<dynamic>)) {
        final thisUser = User.fromJson(json);
        setState(() {
          usersList.add(thisUser);
        });
      }
    }).catchError((error) {
      log("Error: $error");
    });
  }

  deleteUser(int id) {
    // await Future.delayed(const Duration(seconds: 3));
    HttpService.deleteUser(id).then((response) {
      FlutterToastr.show("User has been deleted successfully", context,
          duration: FlutterToastr.lengthShort, position: FlutterToastr.bottom);
      log("$response");
      displayUsers();
    }).catchError((error) {
      log("Error: $error");
    });
  }

  @override
  void initState() {
    super.initState();
    displayUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Users list")),
      body: usersList.isEmpty
          ? const Center(
              child: Text("No Users"),
            )
          : ListView.builder(
              itemCount: usersList.length,
              itemBuilder: (_, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Container(
                        width: 50.0,
                        height: 50.0,
                        child: Center(
                          child: Text(
                            usersList[index].name![0],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text(usersList[index].name ?? "Unknown"),
                      subtitle: Text(usersList[index].age.toString()),
                      trailing: GestureDetector(
                        onTap: () {
                          deleteUser(usersList[index].id!);
                        },
                        child: const Icon(
                          Icons.delete_forever,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    const Divider(thickness: 3),
                  ],
                );
              },
            ),
    );
  }
}
