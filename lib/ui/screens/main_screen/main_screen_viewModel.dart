import 'package:permission_handler/permission_handler.dart';
import '../../../ui/screens/main_screen/permission_handler.dart';

import '../../../app/locator/locator.dart';
import '../../../models/error_model.dart';
import '../../../models/status_model.dart';
import '../../../services/internal.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:stacked/stacked.dart';

class MainScreenViewModel extends BaseViewModel {
  // final _getStatus = GetStatus();
  final _getStatus = locator<Internal>();
  List<StatusModel> _statusList;
  List<StatusModel> _savedStatusList;
  Exceptions _exceptions;
  int _index;
  bool _isPermitted;

  void getPermit() {
    PermissionHandlers.permissionHandler(Permission.storage).then((value) {
      if (value == true) {
        getStatus();
        getSavedStatus();
        notifyListeners();
        _isPermitted = true;
      } else {
        Fluttertoast.showToast(msg: "You have to Allow Permission");
        // exit(0);
      }
      print(value);
    });
  }

  List<StatusModel> getStatus() {
    try {
      _statusList = _getStatus.getAllStatus("WhatsApp/Media/.Statuses");
    } catch (e) {}
    return _statusList;
  }

  List<StatusModel> getSavedStatus() {
    return _savedStatusList =
        _getStatus.getAllStatus("status_saver140").reversed.toList();
  }

  Future<void> saveStatus(String path) async {
    try {
      await _getStatus.saveStatus(path: path).then((value) {
        getSavedStatus();
        if (value == true) {
          Fluttertoast.showToast(
              msg:
                  "Saved to /storage/emulated/0/status_saver140 /${path.substring(45)}");
        }
      });
    } on Exceptions {
      _exceptions = Exceptions(message: "Failed to Save File to Storage");
      Fluttertoast.showToast(msg: _exceptions.message);
    }
  }

  Future<void> deleteSavedStatus(String path, int index) async {
    try {
      await _getStatus.deleteSavedStatus(path).then((value) {
        _savedStatusList.removeAt(index);
        notifyListeners();
        Fluttertoast.showToast(msg: "Image deleted");
      });
    } on Exceptions {
      _exceptions = Exceptions(message: "Something went wrong");
      Fluttertoast.showToast(msg: _exceptions.message);
    }
  }

  void pageChange(int index) {
    this._index = index;
    notifyListeners();
  }

  int get index => _index;
  bool get isPermitted => _isPermitted;
  List<StatusModel> get statusList => _statusList;
  List<StatusModel> get savedStatusList => _savedStatusList;
}
