import 'package:assignment4/models/entities/todo_model.dart';
import '../models/model_logic/todo_logic.dart';
import 'package:flutter/material.dart';

class ToDoProvider extends ChangeNotifier {
  List<ToDoModel> toDos = [];

  Future<List<ToDoModel>> get() async {
    try {
      final response = await ToDoLogic.getToDo() as List<ToDoModel>;
      return response;
    } catch (e) {
      return [];
    }
  }

  Future add(ToDoModel toDo) async {
    try {
      await ToDoLogic.addToDo(toDo);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future delete(String id) async {
    try {
      await ToDoLogic.deleteToDo(id);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future update(String index, ToDoModel newTitle) async {
    try {
      await ToDoLogic.editToDo(index, newTitle);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ToDoModel>> search(String query) async {
    try {
      final response = await ToDoLogic.getToDo();
      return response
          .where((element) =>
              element.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future toggle(String id, ToDoModel todoModel) async {
    try {
      todoModel.checkBox = !todoModel.checkBox;
      await ToDoLogic.toggleToDo(id, todoModel);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
