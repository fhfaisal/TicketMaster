import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/my_model.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  static Future<void> initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<File?> pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      return File(pickedImage.path);
    }
    return null;
  }

  static Future<void> saveDataToPreferences(MyModel myModel, File? selectedImage) async {
    if (_prefs == null) {
      await initSharedPreferences();
    }

    _prefs?.setString('seat', myModel.seat ?? '');
    _prefs?.setString('row', myModel.row ?? '');
    _prefs?.setString('sec', myModel.sec ?? '');
    _prefs?.setString('showName', myModel.showName ?? '');
    _prefs?.setString('showDetails', myModel.showDetails ?? '');
    _prefs?.setString('showTime', myModel.showTime ?? '');

    if (selectedImage != null) {
      final appDir = await pathProvider.getApplicationDocumentsDirectory();
      final fileName = path.basename(selectedImage.path);
      final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_$fileName';
      final localPath = path.join(appDir.path, uniqueFileName);
      await selectedImage.copy(localPath);
      _prefs?.setString('imagePath', localPath);
    } else {
      _prefs?.remove('imagePath');
    }
  }

  static Future<void> loadDataFromPreferences(MyModel myModel) async {
    if (_prefs == null) {
      await initSharedPreferences();
    }

    myModel.seat = _prefs?.getString('seat') ?? myModel.seat;
    myModel.row = _prefs?.getString('row') ?? myModel.row;
    myModel.sec = _prefs?.getString('sec') ?? myModel.sec;
    myModel.showName = _prefs?.getString('showName') ?? myModel.showName;
    myModel.showDetails = _prefs?.getString('showDetails') ?? myModel.showDetails;
    myModel.showTime = _prefs?.getString('showTime') ?? myModel.showTime;
  }
  static Future<void> saveImageToFileSystem(File image) async {
    final appDir = await getApplicationSupportDirectory();
    final fileName = path.basename(image.path);
    final uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_$fileName';
    final localPath = path.join(appDir.path, uniqueFileName);
    final savedImage = await image.copy(localPath);
    // Save the image file path in shared preferences
    _prefs?.setString('imagePath', savedImage.path);
  }
  static Future<File?> loadImageFromFileSystem() async {
    final imagePath = _prefs?.getString('imagePath');
    if (imagePath != saveImageToFileSystem(imagePath as File)) {
      return File(imagePath!);
    }
    return null;
  }


}
