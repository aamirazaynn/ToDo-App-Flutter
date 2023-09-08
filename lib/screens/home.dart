import 'package:assignment4/providers/provider.dart';
import 'package:assignment4/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class home extends StatelessWidget {
  home({super.key});

  GlobalKey<FormState> k = GlobalKey<FormState>();
  GlobalKey<FormState> key = GlobalKey<FormState>();
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 234, 201, 54),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ToDoSearchDeleget());
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),

      body: Consumer<ToDosProvider>(builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
              itemCount: provider.toDos.length,
              itemBuilder: (context, index) {
                return Dismissible(
                    key: ValueKey(provider.toDos[index]),
                    onDismissed: (direction) => provider.remove(index),
                    child: ListTile(
                      leading: Checkbox(
                        value: provider.toDos[index].isDone,
                        activeColor: const Color.fromARGB(255, 234, 201, 54),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        onChanged: (value) {
                          provider.toggle(index);
                        },
                      ),
                      title: Text(
                        provider.toDos[index].title,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text('Edit To Do'),
                                  content: Form(
                                    key: key,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        TextFormField(
                                          initialValue:
                                              provider.toDos[index].title,
                                          decoration: const InputDecoration(
                                            label: Text('Edit'),
                                          ),
                                          validator: (value) {
                                            if (value.toString() ==
                                                provider.toDos[index].title) {
                                              return "You must make changes";
                                            } else {
                                              provider.update(
                                                  index, value.toString());
                                              return null;
                                            }
                                          },
                                        ),
                                        const SizedBox(height: 20),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancel')),
                                            const SizedBox(width: 20),
                                            ElevatedButton(
                                                onPressed: () {
                                                  if (key.currentState!
                                                      .validate()) {
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text('Update')),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                      },
                    ));
              }),
        );
      }),
      
      floatingActionButton:
          Consumer<ToDosProvider>(builder: (context, provider, child) {
        return FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 234, 201, 54),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                      title: const Text('Add To Do'),
                      content: Form(
                        key: k,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text('Enter To Do'),
                              ),
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "You must add ToDo to add";
                                }
                                text = value.toString();
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                const SizedBox(width: 20),
                                ElevatedButton(
                                    onPressed: () {
                                      if (k.currentState!.validate()) {
                                        provider.add(text);
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: const Text('Add')),
                              ],
                            )
                          ],
                        ),
                      ),
                    ));
          },
          child: const Icon(Icons.add),
        );
      }),
    );
  }
}
