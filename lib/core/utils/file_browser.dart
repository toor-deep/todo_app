import 'dart:io';
import 'dart:math' as Math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../shared/app_constants.dart';
import '../../shared/widgets/platform_alert.dart';

class FileBrowser {

  static const platform = MethodChannel('com.novagems.app/camera');

  static Future<File?> getImageFromSource(ImageSource source) async {
    try {
      if (source == ImageSource.camera && Platform.isIOS) {
        // Request camera permission
        await Permission.camera.onGrantedCallback(() => null).request();
        // Call native iOS camera
        final String? filePath = await platform.invokeMethod('openCamera');
        if (filePath != null) {
          final file = File(filePath);
          return file;
        }
        return null;
      } else {
        // Use image_picker for gallery or Android
        await Permission.photos.onGrantedCallback(() => null).request();
        final picker = ImagePicker();
        XFile? selectedFile = await picker.pickImage(
          source: source,
          imageQuality: 30,
        );

        File? image;
        if (selectedFile != null) {
          image = File(selectedFile.path);
          return image;
        }
        return null;
      }
    } catch (e) {
      if (e is PlatformException) {
        if (e.code == 'photo_access_denied' || e.code == 'camera_access_denied') {
          PlatformAlert.showPlatformDialog(
            appNavigationKey.currentContext!,
            "Permission Denied",
            "Open the settings app to change the media access permission.",
            "Cancel",
            "Settings",
            onLeftButtonPressed: () {
              Navigator.pop(appNavigationKey.currentContext!);
            },
            onRightButtonPressed: () {
              Navigator.pop(appNavigationKey.currentContext!);
              openAppSettings();
            },
          );
        }
      }
      return null;
    }
  }

  static String formatBytes(int bytes, [int decimals = 2]) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    final i = (bytes != 0) ? (Math.log(bytes) / Math.log(1024)).floor() : 0;
    final size = bytes / Math.pow(1024, i);
    return '${size.toStringAsFixed(decimals)} ${suffixes[i]}';
  }

}
