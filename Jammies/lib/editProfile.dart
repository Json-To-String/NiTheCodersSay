import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:password/password.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';

class editProfile extends StatefulWidget {
  @override
  editProfileState createState() => editProfileState();
}

class editProfileState extends State<editProfile> {

  File file;

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _upload() {
    print("uploading: ");
    if (file == null) {
      print("Null file");
      return;
    }
    else print(file.path.split("/").last);
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    http.post('http://jam.smpark.in/login', body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
  }

  final _formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: Column(
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
              : Image.file(file)
        ],
      ),
    );
  }

  _submitForm() async {
    // Validate returns true if the form is valid, otherwise false.
  }

}
