import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class myProfileView extends StatelessWidget {

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
      ),
      body: Container(
        height: 1000,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 200,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.indigo,
                    //backgroundImage: AssetImage(''),
                  ),
                )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                _getName(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                _getName(),
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
                    : Image.file(file)// This doesn't work
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



