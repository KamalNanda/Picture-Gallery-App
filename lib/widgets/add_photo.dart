import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class AddPhotoCard extends StatefulWidget {
  Function addPickedImage;
  AddPhotoCard(this.addPickedImage, {Key? key}) : super(key: key);

  @override
  _AddPhotoCardState createState() => _AddPhotoCardState();
}

class _AddPhotoCardState extends State<AddPhotoCard> {
  File? _storedImage;

  Future<void> _pickImage(String source) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(
      source: source == 'camera' ? ImageSource.camera : ImageSource.gallery,
      maxWidth: 600,
    );
    setState(() {
      _storedImage = File(image!.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image!.path);
    final savedImage = await _storedImage!.copy('${appDir.path}/${fileName}');
    widget.addPickedImage(savedImage);

    Navigator.of(context).pop();
  }

  void _showModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Choose an Option',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            _pickImage('gallery');
                          },
                          child: Text(
                            'Add Photo from Gallery',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'OR',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _pickImage('camera');
                          },
                          child: Text(
                            'Take Photo from Camera',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showModal(context);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Color.fromRGBO(14, 116, 169, 0.5),
        child: _storedImage != null
            ? Image.file(_storedImage!, fit: BoxFit.cover)
            : Container(
                padding: EdgeInsets.all(20),
                child: Image.asset(
                  'assets/images/add.png',
                ),
              ),
      ),
    );
  }
}
