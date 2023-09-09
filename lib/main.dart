import 'package:assignment4/providers/todo_provider.dart';
import 'package:assignment4/screens/login_page.dart';
import 'package:assignment4/screens/todos_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/handler/shared_prefference_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ToDoProvider()),
      ],
      child: FutureBuilder<bool>(
        future: SharedPreferencesHandler.isUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // You can show a loading indicator here if needed
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            print("11111111 " + snapshot.data.toString());
            final bool isLoggedIn = snapshot.data!;
            return MaterialApp(
              routes: {
                ToDosPage.id: (context) => ToDosPage(),
                Login.id: (context) => Login(),
              },
              initialRoute: isLoggedIn ? ToDosPage.id : Login.id,
              debugShowCheckedModeBanner: false,
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
