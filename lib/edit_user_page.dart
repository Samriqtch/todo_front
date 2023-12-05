import 'package:flutter/material.dart';
import 'package:todo_front/user_service.dart';

import 'package:flutter/material.dart';

class EditUserPage extends StatefulWidget {
  final Map<String, dynamic> user;

  const EditUserPage({Key? key, required this.user}) : super(key: key);

  @override
  _EditUserPageState createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _ageController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(text: widget.user['firstName']);
    _lastNameController = TextEditingController(text: widget.user['lastName']);
    _ageController = TextEditingController(text: widget.user['age'].toString());
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
            'Edit Profil',
            style: TextStyle(color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
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
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                      ),
                    ),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                      ),
                    ),
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: 'Age',
                      ),
                    ),
ElevatedButton(
  onPressed: () {
    if (_formKey.currentState!.validate()) {
      // Show a dialog to confirm the action
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm'),
            content: Text('Do you want to save the changes?'),
            actions: <Widget>[
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Save'),
                onPressed: () {
                  // Update the user data
                  setState(() {
                    widget.user['firstName'] = _firstNameController.text;
                    widget.user['lastName'] = _lastNameController.text;
                    widget.user['age'] = int.parse(_ageController.text);
                  });

                  // Pop the dialog and the page to go back
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  },
  child: Text('Save'),
),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

