import 'package:flutter/material.dart';

class CreateUserPage extends StatelessWidget {
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
}
