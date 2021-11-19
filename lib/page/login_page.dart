import 'dart:convert';
import 'dart:developer' as developer;

import 'package:epsi_tchat/const_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecUserName = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Connexion"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const Spacer(),
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
                  onPressed: _login, child: const Text('SE CONNECTER')),
              ElevatedButton(
                  onPressed: ()=> Navigator.of(context).pushNamed("/register"), child: const Text('S\'INSCRIRE')),
            ],
          ),
        ),
      ),
    );
  }
  _login() async {
    //TODO récupérer les données depuis les tec envoyer ces données sur le serveur
    String username = tecUserName.text.trim();
    String passwd = tecPassword.text.trim();

    //TODO envoie des données
    http.Response response = await http.post(
        Uri.parse("https://flutter-learning.mooo.com/auth/local"),
        body: {
          "identifier": username,
          "password": passwd,
        }
    );

    if (response.statusCode == 200) {
      developer.log("Connexion success ${response.statusCode}");
      String jwt = jsonDecode(response.body)["jwt"];
      const FlutterSecureStorage()
          .write(key: ConstStorage.KEY_JWT, value: jwt).then((value) => Navigator.of(context).pushNamed("/home_page"),
          onError: (_, var1) => developer.log("Sauvegarde du token impossible"));
    } else {
      developer.log("Connexion error ${response.statusCode}");
    }
  }
}
