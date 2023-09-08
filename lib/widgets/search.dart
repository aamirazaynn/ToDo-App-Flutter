import 'package:assignment4/Models/model.dart';
import 'package:assignment4/providers/provider.dart';
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
    List<ToDoModel> suggestions =
        Provider.of<ToDosProvider>(context).search(query);

    return Consumer<ToDosProvider>(
      builder: (context, provider, child) => ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            return ListTile(
                title: Text(suggestions[index].title),
                leading: Checkbox(
                  value: suggestions[index].isDone,
                  activeColor: const Color.fromARGB(255, 234, 201, 54),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
                    provider.toggle(provider.toDos.indexOf(suggestions[index]));
                  },
                ));
          }),
    );
  }
}
