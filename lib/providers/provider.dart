import 'package:assignment4/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToDosProvider extends ChangeNotifier {
  List<ToDoModel> toDos = [
    ToDoModel(title: 'Buy milk', isDone: true),
    ToDoModel(title: 'Buy eggs', isDone: false),
    ToDoModel(title: 'Buy bread', isDone: false),
  ];

  void add(String toDo){
    toDos.add(ToDoModel(title: toDo, isDone: false));
    notifyListeners();
  }

  void remove(int index){
    toDos.removeAt(index);
    notifyListeners();
  }

  void toggle(int index){
    toDos[index].isDone = !toDos[index].isDone;
    notifyListeners();
  }

  void update(int index, String newTitle){
    toDos[index].title = newTitle;
    notifyListeners();
  }

  List<ToDoModel> search(String query){
    List<ToDoModel> results = [];

    for (ToDoModel todo in toDos) {
      if (todo.title.toLowerCase().contains(query.toLowerCase())) {
        results.add(todo);
      }
    }
    
    return results;
  }
}
