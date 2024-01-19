import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: TodoApp(),
  ));
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  Map<String, String> todos = {};

  TextEditingController idController = TextEditingController();
  TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  // Učitavanje podataka iz SharedPreferences
  _loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedTodos = prefs.getString('todos');
    if (storedTodos != null) {
      setState(() {
        todos = Map<String, String>.from(json.decode(storedTodos));
      });
    }
  }

  // Spremanje podataka u SharedPreferences
  _saveTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(todos);
    prefs.setString('todos', encodedData);
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Unos reyultata fizičkih testova'),
    ),
    body: ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        String key = todos.keys.elementAt(index);
        return ListTile(
          title: Text('$key: ${todos[key]}'),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                todos.remove(key);
                _saveTodos(); 
              });
            },
          ),
        );
      },
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _showAddTodoDialog,
      tooltip: 'Unos',
      child: Icon(Icons.add),
    ),
  );
}

void _showAddTodoDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Dodaj rezultat'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              controller: idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: textController,
              decoration: InputDecoration(labelText: 'rezultat'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Add'),
            onPressed: () {
              Navigator.of(context).pop();
              _addTodo();
            },
          )
        ],
      );
    },
  );
}

void _addTodo() {
  setState(() {
    String id = idController.text;
    String text = textController.text;
    if (id.isNotEmpty && text.isNotEmpty) {
      todos[id] = text;
      idController.clear();
      textController.clear();
      _saveTodos(); 
    }
  });
}}