import 'package:flutter/material.dart';

class myProfileView extends StatelessWidget {
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
                  //EdgeInsets.symmetric
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.indigo,
                    //backgroundImage: AssetImage('images/Mahmud_200.jpg'),
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
          ],
        ),
      ),
    );
  }
}


_getName()  {
  return 'Chloe';
}



