import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/entities/todo_model.dart';
import '../widgets/todo_widget.dart';
import '../widgets/search.dart';
import '../providers/todo_provider.dart';
import '../models/handler/shared_prefference_handler.dart';
import 'login_page.dart';

class ToDosPage extends StatelessWidget {
  static String id = "toDosPage";

  @override
  Widget build(BuildContext context) {
    Future<String?> email = SharedPreferencesHandler.getEmailFromPreferences();
    var provider = Provider.of<ToDoProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 234, 201, 54),
        onPressed: () {
          String title = "";
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text("Add ToDo"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          onChanged: (value) {
                            title = value;
                          },
                          decoration: const InputDecoration(
                            labelText: "Enter title",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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
                                )),
                                child: const Text("Add"),
                                onPressed: () async {
                                  String? email = await SharedPreferencesHandler
                                      .getEmailFromPreferences();
                                  provider.add(ToDoModel(
                                    title: title,
                                    checkBox: false,
                                    email: email!,
                                  ));
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 234, 201, 54),
                                )),
                                child: const Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ],
                  ));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 234, 201, 54),
        title: const Text("Team ToDos"),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: ToDoSearchDeleget());
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      drawer: Drawer(
        shadowColor: Colors.black,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FutureBuilder(
            future: email,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else if (snapshot.hasData) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(snapshot.data.toString()),
                      leading: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 234, 201, 54),
                        child: Text(snapshot.data.toString()[0],
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                        onPressed: () async {
                          bool test =
                              await SharedPreferencesHandler.isUserLoggedIn();
                          print("333333333 $test");
                          await SharedPreferencesHandler
                              .deleteEmailFromPreferences();
                          bool test2 =
                              await SharedPreferencesHandler.isUserLoggedIn();
                          print("4444444444 $test2");
                          Navigator.pushReplacementNamed(context, Login.id);
                        },
                        child: const Text("Logout"))
                  ],
                );
              }
              return const Center(
                child: Text("No data"),
              );
            },
          ),
        ),
      ),
      body: FutureBuilder(
        future: provider.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(snapshot.data![index]),
                  onDismissed: (direction) {
                    provider.delete(snapshot.data![index].id!);
                  },
                  child: ToDoWidget(
                    todoModel: snapshot.data![index],
                  ),
                );
              },
            );
          }
          return const Center(
            child: Text("No data"),
          );
        },
      ),
    );
  }
}
