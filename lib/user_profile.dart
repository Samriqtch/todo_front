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
import 'edit_user_page.dart';

class UserProfilPage extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserProfilPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Center(
          child: Text(
            'User Profile',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Color.fromARGB(255, 32, 32, 32),
                    width: 0.5,
                  ),
                ),
                child: Icon(Icons.person, size: 200),
              ),
            ),
            SizedBox(height: 16.0), // Add space between the fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('${user['firstName']}'),
                Text('${user['lastName']}'),
                Text('${user['age']}'),
              ],
            ),
            SizedBox(height: 16.0), // Add space between the fields
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditUserPage(user: {},)),
                  );
                },
                child: Text('Edit User', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 16.0), // Add space between the fields
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )
                  ),
                ),
                onPressed: () {
                  // Handle delete user action here
                },
                child: Text('Delete User', style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

