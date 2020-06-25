import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Authentication.dart';

class Homepage extends StatefulWidget {

  @override
  _HomepageState createState() => _HomepageState();

  Homepage({
    this.auth,
    this.onSignedOut,
  });

  final AuthImplementation auth;
  final VoidCallback onSignedOut;
}

class _HomepageState extends State<Homepage> {

  void _logOutUser() async {
    try{
      await widget.auth.signOut();
      widget.onSignedOut();
    }catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:new AppBar(
        title: new Text("Home"),
      ),
      body: new Container(

      ),
      bottomNavigationBar: new BottomAppBar(
        color: Colors.pink,
        child : new Container(
          margin: const EdgeInsets.only(left: 70, right: 70.0 ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.local_car_wash),
              iconSize: 30,
              color: Colors.white,
              onPressed: _logOutUser,
            ),
            new IconButton(
              icon: new Icon(Icons.add_a_photo),
              iconSize: 30,
              color: Colors.white,
              onPressed: null,
            ),

          ],
        ),
    )
      ),
    );
  }
}
