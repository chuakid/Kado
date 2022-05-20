import 'package:flutter/material.dart';
import 'package:kado/src/database/db_service.dart';

class CreateCardStack extends StatefulWidget {
  const CreateCardStack({Key? key}) : super(key: key);

  @override
  State<CreateCardStack> createState() => _CreateCardStackState();
}

class _CreateCardStackState extends State<CreateCardStack> {
  String stackName = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Card Stack")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
                validator: (value) => value == "" ? "Enter a name" : null,
                autofocus: true,
                onChanged: (value) => {stackName = value})
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
                if (_formKey.currentState!.validate())
                  {
                    DBService.addStack(stackName).then(
                      (value) => {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('New stack added')),
                        ),
                        Navigator.pop(context)
                      },
                    )
                  }
              }),
    );
  }
}
