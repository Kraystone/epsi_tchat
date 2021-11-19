import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //TODO Les controller de text pour recupérer les infos dans les controllers
  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecUserName = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("S'inscrire"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Spacer(),
              TextFormField(
                controller: tecEmail,
                decoration: const InputDecoration(
                    hintText: 'Email', prefixIcon: Icon(Icons.email)),
              ),
              TextFormField(
                controller: tecUserName,
                decoration: const InputDecoration(
                    hintText: 'Nom d\'utilisateur',
                    prefixIcon: Icon(Icons.person)),
              ),
              TextFormField(
                controller: tecPassword,
                obscureText: true,
                decoration: const InputDecoration(
                    hintText: 'Mot de passe', prefixIcon: Icon(Icons.password)),
              ),
              const Spacer(),
              OutlinedButton(
                  onPressed: ()=> Navigator.of(context).pushNamed("/login"), child: const Text('SE CONNECTER')),
              ElevatedButton(
                  onPressed: _register, child: const Text('S\'INSCRIRE')),
            ],
          ),
        ),
      ),
    );
  }

  _register() async {
    //TODO récupérer les données depuis les tec envoyer ces données sur le serveur
    String username = tecUserName.text.trim();
    String passwd = tecPassword.text.trim();
    String email = tecEmail.text.trim();

    //TODO envoie des données
    http.Response response = await http.post(
        Uri.parse("https://flutter-learning.mooo.com/auth/local/register"),
        body: {
          "username": username,
          "password": passwd,
          "email": email,
        }
    );

    if (response.statusCode == 200) {
      developer.log("Inscription success ${response.statusCode}");
    } else {
      developer.log("Inscription error ${response.statusCode}");
    }
  }
}

