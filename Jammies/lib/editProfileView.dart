import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class editProfileView extends StatefulWidget {
  @override
  editProfileState createState() => editProfileState();
}
class editProfileState extends State<editProfileView> {
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
    else
      print(file.path
          .split("/")
          .last);
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path
        .split("/")
        .last;

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
          title: Text("My Profile"),
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


