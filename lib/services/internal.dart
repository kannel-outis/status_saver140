import 'dart:io';
import 'package:filesize/filesize.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import '.././models/error_model.dart';
import '.././models/status_model.dart';

abstract class Internal {
  List<StatusModel> getAllStatus(String path);
  Future<bool> saveStatus({String path});
  Future deleteSavedStatus(String path);
}

class GetStatus extends Internal {
  List<StatusModel> _statusList;
  @override
  List<StatusModel> getAllStatus(String path) {
    final Directory imgDir = Directory('/storage/emulated/0/$path');
    print("Nni");
    try {
      if (Directory("${imgDir.path}").existsSync()) {
        _statusList = imgDir
            .listSync()
            .map((fileEnt) => fileEnt.path)
            .where((imageName) => imageName.endsWith(".jpg"))
            .toList()
            .map((e) => StatusModel(
                name: e.split('/').last,
                path: e,
                size: (filesize(File(e).lengthSync())).toString(),
                modified: File(e).lastModifiedSync().toString()))
            .toList();
        return _statusList;
      }
    } catch (e) {
      print(e.toString());
    }
    return _statusList;
  }

  @override
  Future<bool> saveStatus({String path}) async {
    print(path);
    try {
      var fileSync = File(path).readAsBytesSync();
      await ImageGallerySaver.saveImage(
        fileSync,
        name: path.substring(45, 77),
      );
      return true;
    } catch (e) {
      throw Exceptions(message: e.toString());
    }
  }

  @override
  Future deleteSavedStatus(String path) async {
    try {
      await File(path).delete(recursive: true);
    } catch (e) {
      throw Exceptions(message: e.toString());
    }
  }
}
