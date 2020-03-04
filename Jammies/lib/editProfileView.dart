import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

class editProfileView extends StatefulWidget {
  @override
  editProfileState createState() => editProfileState();
}
class editProfileState extends State<editProfileView> {
  File file;

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _upload() async {
    print("uploading: ");
    if (file == null) {
      print("Null file");
      return;
    }

    print(file.path
        .split("/")
        .last);

    String fileName = file.path
        .split("/")
        .last;

    final prefs = await SharedPreferences.getInstance();

    String email = prefs.getString('email');
    String password = prefs.getString('password');


    var stream = new http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();

    var uri = Uri.parse('http://jam.smpark.in/upload');

    var request = new http.MultipartRequest("POST", uri);

    Map<String, String> header = {'email': email, 'password': password};

    var multipartFile = new http.MultipartFile('file', stream, length,
        filename: basename(file.path));

    print("File size: " + length.toString());

    request.files.add(multipartFile);
    request.headers.addAll(header);
    var response = await request.send();
    print(response.statusCode);

  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery
        .of(context)
        .size;
    var width = screenSize.width;
    var height = screenSize.height;
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit Profile"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
           Padding(
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
                  _getName(),
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
                _getBio(),
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
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: _choose,
                      child: Text('Choose Image'),
                    ),
                    SizedBox(width: 10.0),
                    RaisedButton(
                      onPressed: _upload,
                      child: Text('Upload Image'),
                    )
                  ],
                ),
                file == file
                    ? Text('No Image Selected')
                    : Image.file(file) // This doesn't work
              ],
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


