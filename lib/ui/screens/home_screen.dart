import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/album.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Album> albums = [];

  void getData() async {
    try {
      var response =
          await Dio().get('https://jsonplaceholder.typicode.com/albums');
      var albumData = <Album>[];
      for (var i = 0; i < response.data.length; i++) {
        albumData.add(Album.fromJson(response.data[i]));
      }
      setState(() {
        albums = albumData;
      });
    } catch (e) {
      print(e.toString);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text("Flutter Test")),
      body: albums.isEmpty
          ? Center(
              child: Platform.isIOS
                  ? CupertinoActivityIndicator(
                      radius: 15
                    )
                  : CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: albums.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(albums[index].id.toString()),
                    ),
                    title: Text(
                      albums[index].title,
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
