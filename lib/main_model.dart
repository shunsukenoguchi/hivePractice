import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

final mainProvider = ChangeNotifierProvider<MainModel>(
  (ref) => MainModel(),
);

class MainModel extends ChangeNotifier {
  final box = Hive.box('todoList');

  void addTodo(todo) {
    box.put('todo', todo);
    notifyListeners();
  }

  void deleteTodo() {
    box.delete('todo');
    print(box.get('todo'));
    notifyListeners();
  }
}
