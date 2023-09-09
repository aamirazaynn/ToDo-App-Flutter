import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../models/entities/todo_model.dart';

class ToDoWidget extends StatelessWidget {
  ToDoModel todoModel;

  ToDoWidget({super.key, required this.todoModel});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ToDoProvider>(context);
    return ListTile(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Edit ToDo"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                            labelText: "Title", border: OutlineInputBorder()),
                        onChanged: (value) {
                          todoModel.title = value;
                        },
                        controller:
                            TextEditingController(text: todoModel.title),
                      ),
                    ],
                  ),
                  actions: [
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 234, 201, 54),
                                  )
                                ),
                              onPressed: () {
                                provider.update(
                                    todoModel.id!,
                                    ToDoModel(
                                        email: todoModel.email,
                                        checkBox: todoModel.checkBox,
                                        title: todoModel.title));
                                Navigator.pop(context);
                              },
                              child: const Text("Save"),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 234, 201, 54),
                                  )
                                ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ));
      },
      title: Text(
        todoModel.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      trailing: Text(
        todoModel.email,
        style: const TextStyle(fontSize: 15, color: Colors.grey),
      ),
      leading: Checkbox(
        value: todoModel.checkBox,
        activeColor: const Color.fromARGB(255, 234, 201, 54),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        onChanged: (value) {
          provider.toggle(
              todoModel.id!,
              ToDoModel(
                  email: todoModel.email,
                  checkBox: todoModel.checkBox,
                  title: todoModel.title));
        },
      ),
    );
  }
}
