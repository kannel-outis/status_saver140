import 'package:permission_handler/permission_handler.dart';

class PermissionHandlers {
  static Future<bool> permissionHandler(Permission permit) async {
    // bool checkStatus = await permit.isUndetermined;
    // if (checkStatus == true) {
    //   await permit.request().then((v) {
    //     if (v == PermissionStatus.denied) {
    //       return _check = false;
    //     }
    //     return _check = true;
    //   });
    // }
    // return _check;

    var checkStatus = await permit.status;
    bool _check;

    switch (checkStatus) {
      case PermissionStatus.undetermined:
        await permit.request().then((v) {
          if (v == PermissionStatus.denied) {
            _check = false;
          } else {
            _check = true;
          }
        });
        break;
      case PermissionStatus.permanentlyDenied:
        _check = false;
        break;
      case PermissionStatus.granted:
        _check = true;
        break;
      case PermissionStatus.restricted:
        _check = false;
        break;
      case PermissionStatus.denied:
        await permit.request().then((v) {
          if (v == PermissionStatus.denied) {
            _check = false;
          } else {
            _check = true;
          }
        });
        break;
      default:
        _check = false;
    }
    return _check;
  }
}

// var checkStatus = await permit.status;

// switch (checkStatus) {
//   case PermissionStatus.undetermined:
//     await permit.request().then((value) => print(value));

//     break;
//   case PermissionStatus.permanentlyDenied:
//     return false;
//     break;
//   case PermissionStatus.restricted:
//     return false;
//     break;

//   case PermissionStatus.denied:
//     await permit.request().then((value) => print(value));
//     break;
//   case PermissionStatus.granted:
//     return true;
//     break;
// }
