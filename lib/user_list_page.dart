import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'api_service.dart';

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
    final response = await http.get(Uri.parse('http://192.168.1.106:3000/users'));

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
                  title: Text(snapshot.data![index]['firstName']),
//                  subtitle: Text(snapshot.data![index]['firstname']),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      // Ajoutez votre logique pour supprimer l'utilisateur ici
                    },
                  ),
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
              return Text('Une erreur est survenue: ${snapshot.error.toString()}');
          } else {
            return  Center (child: const CircularProgressIndicator());
          }   
        }, 
      
      ),
    );
  }
}

class EditUserPage extends StatelessWidget {
  final Map<String, dynamic> user;

  const EditUserPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Remplacez ceci par le code pour votre page d'édition de l'utilisateur
    return Scaffold();
  }
}
