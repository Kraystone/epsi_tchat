import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as developer;

import 'package:epsi_tchat/bo/message.dart';
import 'package:epsi_tchat/const_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<List<Message>> streamControllerMsg = StreamController();
  @override
  void initState() {
    super.initState();
    _getMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EpsiChat"),),
      body: StreamBuilder<List<Message>>(
        stream: streamControllerMsg.stream,
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
              // TODO: Handle this case.
              return const CircularProgressIndicator();
            case ConnectionState.waiting:
              // TODO: Handle this case.
              return const CircularProgressIndicator();
              break;
            case ConnectionState.active:
              // TODO: Handle this case.
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) => _buildListElement(snapshot.data![index]),
              );
            }
              return const CircularProgressIndicator();
            case ConnectionState.done:
              // TODO: Handle this case.
              return const CircularProgressIndicator();
          }
        }
      ),
    );
  }

  ListTile _buildListElement(Message list) {
    return ListTile(
      leading: const CircleAvatar(
        child: Text("AB"),
        backgroundColor: Colors.redAccent,),
      title: Row(
        children: const [
          Text("Mon pseudo"),
          Spacer(),
          Text("a 12h56")
        ],
      ),
      subtitle: const Text(
          "Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message Ceci est une long message "),
    );
  }
  Future<void> _getMessages() async {
    FlutterSecureStorage().read(key: ConstStorage.KEY_JWT).then(
            (jwt) {
          Future<Response> response =
          get(Uri.parse("https://flutter-learning.mooo.com/messages"),
              headers: {"Authorization": "Bearer $jwt"});
          response.then((response) => _analyzeResponseMsgs,
              onError: (error, Stacktrace) => log("Erreur response:"+error.toString())
          );
        },
        onError: (_,var1) => developer.log("Erreur getJwt:"+_.toString()));
  }
  void _analyzeResponseMsgs(Response response) {
      if(response.statusCode == 200) {
        String res = response.body;
        dynamic mapRes = jsonDecode(res);
        List<Message>  listMsg = List<Message>.from(mapRes.map((x) => Message.fromJson(x)));
        //TODO ajouter la list dans le stream
        streamControllerMsg.sink.add(listMsg);
      }
      else {
        developer.log("${response.statusCode} + ${response.reasonPhrase}");
      }
  }
}




