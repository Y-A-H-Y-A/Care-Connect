import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  final String title;
  final String description;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSavedTodo;

  const TodoFormWidget({
    Key? key,
    this.title = '',
    this.description = '',
    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onSavedTodo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildTitle(),
          const SizedBox(height: 8),
          buildDescription(),
          const SizedBox(height: 32),
          buildButton(),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return TextFormField(
      maxLines: 1,
      initialValue: title,
      onChanged: onChangedTitle,
      validator: (title) {
        if (title!.isEmpty) {
          return 'The title cannot be empty';
        }
        return null;
      },
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Title',
      ),
    );
  }

  buildDescription() {
    return TextFormField(
      maxLines: 3,
      initialValue: description,
      onChanged: onChangedDescription,
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Description',
      ),
    );
  }

  buildButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onSavedTodo,
        child: const Text('save'),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xFF39729A)),
        ),
      ),
    );
  }
}
