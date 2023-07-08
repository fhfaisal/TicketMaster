import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:image_picker/image_picker.dart';
import 'package:ticketmaster/models/my_model.dart';
import 'package:ticketmaster/shared_preferences.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  MyModel myModel = MyModel();
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    SharedPreferencesService.loadDataFromPreferences(myModel);
  }

  Future<void> _pickImage() async {
    File? pickedImage = await SharedPreferencesService.pickImage();
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage;
      });
    }
  }

  Future<void> _updateValues() async {
    await SharedPreferencesService.saveDataToPreferences(myModel, selectedImage);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 16),
            selectedImage != null
                ? Image.file(selectedImage!)
                : Text('No image selected'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateValues,
              child: Text('Save Data'),
            ),
          ],
        ),
      ),
    );
  }
}
