import 'package:flutter/material.dart';
import '../../core/routing.dart';
class CustomLoader {
  static CustomLoader? _loader;

  CustomLoader._createObject();

  factory CustomLoader() {
    if (_loader != null) {
      return _loader!;
    } else {
      _loader = CustomLoader._createObject();
      return _loader!;
    }
  }

  static OverlayState? _overlayState;
  static  OverlayEntry? _overlayEntry;

  static  _buildLoader() {
    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              child: buildLoader(),
              color: Colors.black.withValues(alpha: 0.3),
            )
          ],
        );
      },
    );
  }

  static show({ BuildContext? context}) {
    _overlayState = Overlay.of(context??appNavigationKey.currentContext!);
    _buildLoader();
    _overlayState!.insert(_overlayEntry!);
  }

  static  hide() {
    try {
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
        _overlayEntry = null;
      }
    } catch (_) {}
  }

  static buildLoader() {
    return Center(
      child: Container(
        color: Colors.transparent,
        width: 70,
        child:  const Center(
          child:
          CircularProgressIndicator()

        ), //CircularProgressIndicator(),
      ),
    );
  }
}
