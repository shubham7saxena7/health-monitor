import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BPReaderApp(),
    );
  }
}

class BPReaderApp extends StatefulWidget {
  @override
  _BPReaderAppState createState() => _BPReaderAppState();
}

class _BPReaderAppState extends State<BPReaderApp> {
  File? _image;

  Future<void> _pickImage() async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      // Save the image to the photos gallery
      final savedImage = File(pickedImage.path);
      await savedImage
          .copy('${Directory.systemTemp.path}/bp_monitor_image.jpg');
      setState(() {
        _image = savedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BP Monitor Photo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? Text('No image selected.') : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Take Photo'),
            ),
          ],
        ),
      ),
    );
  }
}
