import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plactice_hive/main_model.dart';

void main() async {
  ///ios,androidを判断してローカルストレージのパスを入手
  await Hive.initFlutter();

  await Hive.openBox('todoList');
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Settings',
      home: TodoPage(),
    );
  }
}

class TodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mainModel = context.read(mainProvider);
    final todoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hive TodoList Demo'),
      ),
      body: Center(
        child: Consumer(builder: (context, watch, child) {
          final List todoList = watch(mainProvider).todoList;
          mainModel.setTodoList();
          return Column(
            children: [
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term'),
                controller: todoController,
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return _todoItem(todoList[index]);
                  },
                  itemCount: todoList.length,
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mainModel.deleteTodo();
                  },
                  child: Text('削除')),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mainModel.addTodo(todoController.text);
          todoController.clear();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget _todoItem(String title) {
  return Container(
    decoration: new BoxDecoration(
        border: new Border(bottom: BorderSide(width: 1.0, color: Colors.grey))),
    child: ListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: 18.0),
      ),
      onTap: () {
        print("onTap called.");
      }, // タップ
      onLongPress: () {
        print("onLongTap called.");
      }, // 長押し
    ),
  );
}
