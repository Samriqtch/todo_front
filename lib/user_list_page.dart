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

class UserListPage extends StatefulWidget {
  //const UserListPage({Key? key}) : super(key: key);
  final ApiService apiService = ApiService();

  @override
  // ignore: library_private_types_in_public_api
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List> futureUsers;
  Future<List> fetchUsers() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.76:3000/users'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  //Center(child: Text('Users',style: TextStyle(color: Colors.white),),)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Users',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        body: FutureBuilder<List>(
          future: futureUsers,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  print((snapshot.data![index]['firstName']));
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                      backgroundColor: const Color.fromARGB(255, 243, 245,
                          247), // Vous pouvez changer la couleur de fond ici
                    ),
                    title: Text(snapshot.data![index]['firstName']),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Naviguer vers la page de création d'utilisateur
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateUserPage()),
            );
          },
          child: Icon(Icons.edit), // Icône de crayon
          backgroundColor: const Color.fromARGB(255, 10, 10, 10),
          foregroundColor: Colors.white,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
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

class EditUserPage extends StatelessWidget {
  final Map<String, dynamic> user;

  const EditUserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Remplacez ceci par le code pour votre page d'édition de l'utilisateur
    return Scaffold(
        
        );
  }
}

/*class CreateUserPage extends StatelessWidget {
  const CreateUserPage({super.key});

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
}*/

/*class NotificationPage extends StatelessWidget {
  Future<List<dynamic>> getNotifications() async {
    final response =
        await http.get(Uri.parse('http://192.168.72.92:3000/notification'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load notification');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
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
            'Notifications',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String,dynamic>>>(
          future: getNotifications(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index]['id']),
                    //
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}');
            } else {
              return CircularProgressIndicator();
            }
          }),
    );
  }
  */
  getNotifications() {
  }
  



fetchNotifications() {
}

mixin list {}
