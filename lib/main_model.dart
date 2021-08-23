import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

final mainProvider = ChangeNotifierProvider<MainModel>(
  (ref) => MainModel(),
);

class MainModel extends ChangeNotifier {
  final box = Hive.box('todoList');
  List todoList = [];

  setTodoList() {
    todoList = box.get('todos');
  }

  void addTodo(todo) {
    todoList.add(todo);
    box.put('todos', todoList);
    notifyListeners();
  }

  void deleteTodo(int index) {
    todoList.removeAt(index);
    box.put('todos', todoList);
    notifyListeners();
  }
}
