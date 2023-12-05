import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_service.dart';
import 'notification.dart';
import 'user_list_page.dart';
import 'user_service.dart';
import 'create_user.dart';

class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

  Future<List<dynamic>> postUsers() async {
    final response =
        await http.post(Uri.parse('http://192.168.1.72:3000/users'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load notification');
    }
  }

  @override
  Widget build(BuildContext context) {
    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final ageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Center(
            child: Text(
          'Create User',
          style: TextStyle(color: Colors.white),
        )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'First Name',
              ),
            ),
            SizedBox(height: 16.0), // Add space between the fields
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Last Name',
              ),
            ),
            SizedBox(height: 16.0), // Add space between the fields
            TextField(
              controller: ageController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
            ),
            SizedBox(height: 16.0), // Add space between the fields
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 14, 13, 13)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                ),
                onPressed: () async {
                  final response = await http.post(
                    Uri.parse('http://192.168.1.72:3000/users'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'firstName': firstNameController.text,
                      'lastName': lastNameController.text,
                      'age': ageController.text,
                    }),
                  );
                      if (response.statusCode == 201) {
                                // If the server returns a CREATED response, then parse the JSON.
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('User created successfully')),
                                );
                              } else {
                                // If the server did not return a CREATED response,
                                // then throw an exception.
                                throw Exception('Failed to create user');
                      }
                },
                child: Text('Save',
                    style: TextStyle(
                        color: const Color.fromARGB(255, 248, 244, 244))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
