import 'package:flutter/material.dart';
import 'Authentication.dart';
import 'Mapping.dart';

void main() => runApp(BlogApp());

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "BlogApp",
      theme: new ThemeData(
        primarySwatch: Colors.pink
      ),
      home: MappingPage(auth: Auth(),),
    );
  }
}


