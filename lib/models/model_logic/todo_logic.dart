import 'dart:convert';
import '../../constants/endPoints.dart';
import '../api_handler.dart';
import '../entities/todo_model.dart';

class ToDoLogic {
  static final ApiHandler apiHandler = ApiHandler();
  static Future getToDo() async {
    const url = BASE_URL + TODO_ENDPOINT;
    try {
      final response = await apiHandler.makeRequest(url);
      final mapResponse = jsonDecode(response.body) as List;

      return mapResponse.map((e) => ToDoModel.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  static Future deleteToDo(String id) async {
    String url = "$BASE_URL$TODO_ENDPOINT/$id";
    try {
      final response = await apiHandler.makeRequest(url, method: "DELETE");
      final mapResponse = jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  static Future addToDo(ToDoModel todoModel) async {
    String url = "$BASE_URL$TODO_ENDPOINT";
    try {
      final response = await apiHandler.makeRequest(url,
          body: todoModel.toJson(), method: "POST");
      final mapResponse = jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  static Future editToDo(String id, ToDoModel todoModel) async {
    String url = "$BASE_URL$TODO_ENDPOINT/$id";
    try {
      final response = await apiHandler.makeRequest(url,
          body: todoModel.toJson(), method: "PUT");
      final mapResponse = jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }

  static Future toggleToDo(String id, ToDoModel todoModel) async {
    String url = "$BASE_URL$TODO_ENDPOINT/$id";
    try {
      final response = await apiHandler.makeRequest(url,
          body: todoModel.toJson(), method: "PUT");
      final mapResponse = jsonDecode(response.body);
    } catch (e) {
      rethrow;
    }
  }
}
