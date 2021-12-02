import 'package:flutter/material.dart';
import 'dart:io';
import './widgets/add_photo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage('Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;
  MyHomePage(this.title, {Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<File> _pickedImages = [];

  void _addPickedImages(File pickedImage) {
    _pickedImages.add(pickedImage);
  }

  void _saveImages() {
    if (_pickedImages.length == 0) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Expanded(
                child: GridView.builder(
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return AddPhotoCard(_addPickedImages);
                  },
                ),
              ),
              RaisedButton(
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 60),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(36),
                    side: BorderSide(
                      color: Color.fromRGBO(14, 116, 169, 1),
                      width: 2,
                    )),
                onPressed: () {},
                child: Text(
                  'End Call',
                  style: TextStyle(
                      color: Color.fromRGBO(14, 116, 169, 1),
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
        ));
  }
}
