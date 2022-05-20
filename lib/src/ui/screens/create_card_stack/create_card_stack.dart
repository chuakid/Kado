import 'package:flutter/material.dart';

class CreateCardStack extends StatefulWidget {
  const CreateCardStack({Key? key}) : super(key: key);

  @override
  State<CreateCardStack> createState() => _CreateCardStackState();
}

class _CreateCardStackState extends State<CreateCardStack> {
  String cardText = "";
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
                autofocus: true, onChanged: (value) => {cardText = value})
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => {
                //upload to firebase
              }),
    );
  }
}
