import 'dart:async';
import 'dart:core';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_service.dart';
import 'notification.dart';
import 'user_list_page.dart';
import 'user_service.dart';
import 'create_user.dart';


class NotificationPage extends StatelessWidget {
  Future<List<dynamic>> getNotifications() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.76:3000/notification'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load notification');
    }
  }
  
  //Center(child: Text('Users',style: TextStyle(color: Colors.white),),)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Notification',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: FutureBuilder<List>(
          future: getNotifications(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  print((snapshot.data![index]['id'].toString()));
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                      backgroundColor: const Color.fromARGB(255, 243, 245,
                          247), // Vous pouvez changer la couleur de fond ici
                    ),
                    title: Text(snapshot.data![index]['id'].toString()),
//                  subtitle: Text(snapshot.data![index]['firstname']),
                    
                    onTap: () {
                      // Naviguez vers une nouvelle page pour éditer le profil de l'utilisateur
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditUserPage(user: snapshot.data![index]),
                        ),
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text(
                  'Une erreur est survenue: ${snapshot.error.toString()}');
            } else {
              return Center(child: const CircularProgressIndicator());
            }
          },
        ),

        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'User List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListPage()),
                );
                break;
              case 1:
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
                break;
            }
          },
        ));
  }
}
  getNotifications() {
  }
  



fetchNotifications() {
}

mixin list {}
