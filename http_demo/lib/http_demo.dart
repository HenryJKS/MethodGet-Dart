import 'dart:convert';

import 'package:http/http.dart' as http;

void main(List<String> arguments) {
  getTodo(1);
}

Future<ToDo?> getTodo(int id) async {
  final url = Uri.parse("https://jsonplaceholder.typicode.com/todos/$id");
  final response = await http.get(url);

  if (response.statusCode == 200) {
    final Map<String, dynamic> data = jsonDecode(response.body);
    final todo = ToDo.fromJson(data);
    return todo;
  }

  return null;
}

Future<List<ToDo>> getTodos() async {
  final url = Uri.parse("https://jsonplaceholder.typicode.com/todos/");
  final response = await http.get(url);

  if (response.statusCode ==  200) {
      final data = jsonDecode(response.body);
      final todos = data.map((map) => ToDo.fromJson(map)).toList();

      return todos;

  }

  return [];
}

class ToDo {
  int userId;
  int id;
  String title;
  bool completed;

  ToDo({
    required this.userId,
    required this.id,
    required this.title,
    this.completed = false,
  });

  factory ToDo.fromJson(Map<String, dynamic> map) {
    return ToDo(
      userId: map['userId'],
      id: map['id'],
      title: map['title'],
      completed: map['completed'],
    );
  }
}
