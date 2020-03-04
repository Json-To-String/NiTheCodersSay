import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class myProfileView extends StatelessWidget {

  final name = _getName();
  final bio = _getBio();
  //final genres = _getGenres();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: SafeArea(

      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment(1, 1),
              child: RaisedButton(
                color: Colors.red,
                child: Text("Edit"),
                onPressed: () {
                  Navigator.pushNamed(context, '/editProfileView');
                },
              ),
            ), Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.indigo,
                    //backgroundImage: AssetImage(''),
                  ),
                ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                name,
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Bio\n",
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                bio,
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "\nGenres\n",
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                _getGenres(),
              ),
            ),
          ],
            ),
      ),
        );
  }
}


_getName()  {
  return 'Chloe';
}

_getBio()  {
  return 'bio here';
}

_getGenres()  {
  return 'genres here';
}


