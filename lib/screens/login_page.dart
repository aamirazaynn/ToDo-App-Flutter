import 'package:assignment4/screens/todos_page.dart';
import 'package:email_validator/email_validator.dart';
import '../models/handler/shared_prefference_handler.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  static String id = "login";
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> k = GlobalKey<FormState>();
  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: k,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/todo.png"),
            const SizedBox(
              height: 20,
            ),
            const Text("Login",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(20),
                )),
                hintText: "user@gmail.com",
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please enter your email";
                }
                if (!EmailValidator.validate(value)) {
                  return "Email is not valid";
                }
                return null;
              },
              controller: email,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(255, 234, 201, 54),
              )),
              child: const Text("Login"),
              onPressed: () async {
                if (k.currentState!.validate()) {
                  await SharedPreferencesHandler()
                      .saveEmailToPreferences(email.text);
                  Navigator.pushNamed(context, ToDosPage.id);
                }
              },
            ),
          ],
        ),
      ),
    ));
  }
}
