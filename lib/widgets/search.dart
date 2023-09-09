import 'package:assignment4/providers/todo_provider.dart';
import 'package:assignment4/widgets/todo_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ToDoSearchDeleget extends SearchDelegate {
  Widget BuildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        query = value;
      },
      decoration: const InputDecoration(
        label: Text('Search'),
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = Provider.of<ToDoProvider>(context);

    return FutureBuilder(
        future: suggestions.search(query),
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
                      suggestions.delete(snapshot.data![index].id!);
                    },
                    child: ToDoWidget(
                      todoModel: snapshot.data![index],
                    ),
                  );
                });
          }
          return const Center(
            child: Text("No data"),
          );
        });

    // return Consumer<ToDosProvider>(
    //   builder: (context, provider, child) => ListView.builder(
    //       itemCount: suggestions.length,
    //       itemBuilder: (context, index) {
    //         return ListTile(
    //             title: Text(suggestions[index].title),
    //             leading: Checkbox(
    //               value: suggestions[index].isDone,
    //               activeColor: const Color.fromARGB(255, 234, 201, 54),
    //               shape: const RoundedRectangleBorder(
    //                 borderRadius: BorderRadius.all(
    //                   Radius.circular(5.0),
    //                 ),
    //               ),
    //               onChanged: (value) {
    //                 provider.toggle(provider.toDos.indexOf(suggestions[index]));
    //               },
    //             ));
    //       }),
    // );
  }
}
