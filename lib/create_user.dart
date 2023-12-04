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
    Future<List<dynamic>> getNotifications() async {
    final response =
        await http.post(Uri.parse('http://192.168.1.76:3000/users'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load notification');
    }
  }

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
          'Create User',
          style: TextStyle(color: Colors.white),
        )),
        centerTitle: true,
      ),
      body: Center(
        child: Text('This is the Create User Page'),
      ),
    );
  }
}
