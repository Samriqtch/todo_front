import 'package:flutter/material.dart';
import 'package:todo_front/user_service.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserListPage extends StatefulWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List> futureUsers;

  Future<List> fetchUsers() async {
    final response = await http.get('http://localhost:3000/users' as Uri);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<List>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['name']),
                  subtitle: Text(snapshot.data![index]['firstname']),
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
            return const Text('Une erreur est survenue.');
          }

          // Par défaut, affichez un indicateur de chargement.
          return const CircularProgressIndicator();
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
