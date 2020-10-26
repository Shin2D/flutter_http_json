import 'dart:convert';

import 'package:flutter/material.dart';
//import 'wp-api.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

void main() => runApp(new MaterialApp(
  home: new HomePage(),
));

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {

  final String url = "https://api.androidhive.info/contacts/";
  List data;

  @override
  void initState(){
    super.initState();
    this.getJSONData();
  }

  Future<String> getJSONData() async{
    var response = await http.get(
    //Encode the URL
      Uri.encodeFull(url),
      //only accept json response
      headers: {"Accept": "application/json"}
    );
    
    print(response.body);
    
    setState(() {
      var convertDataToJson = json.decode(response.body);
      data = convertDataToJson['contacts'];
      //return convertDataToJson;

    });

    return "Success";
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Retrived Json Data via HTTP"),
      ),
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
        //itemCount: 2,
          itemBuilder: (BuildContext context, int index) {
            return new Container(
              child: new Center(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    new Card(
                      child: new Container(
                        child: new Text(data[index]['name']),
                        padding: const EdgeInsets.all(20.0)),
                      )
                  ],
                ),
              ),
            );
          },
      ),
    );
  }
}
