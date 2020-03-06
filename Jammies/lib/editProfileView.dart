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

  final bio = _getBio();
  final _formKey = GlobalKey<FormState>();
  //final bioController = new TextEditingController();
/*
  void initState() {
    bioController.text = bio;
    return super.initState();
  }
*/
  @override
  Widget build(BuildContext context) {
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  "\nBio\n",
                  style: TextStyle(fontWeight: FontWeight.bold)
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: TextFormField(
                //inputFormatters: <TextInputFormatter>[LengthLimitingTextInputFormatter(100)],
                  validator: (value) {
                    if(value.length == 0) {
                      return "Please enter a bio";
                    }
                    return null;
                  },
                  //controller: bioController,
                  obscureText: false,
                  initialValue: bio,
              ),
            ),
      Align(
        alignment: Alignment.bottomCenter,
        child: RaisedButton(
          child: Text("Submit"),
          color: Colors.teal[300],
          onPressed: () {
            _submitForm;
            Navigator.pushNamed(context, '/myProfileView');
          },
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

_submitForm() async {
}



