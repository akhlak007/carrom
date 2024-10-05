import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Toast {
  static const int LENGTH_SHORT = 1;
  static const int LENGTH_LONG = 2;
  static const int BOTTOM = 0;
  static const int CENTER = 1;
  static const int TOP = 2;

  static void show(
      String msg,
      BuildContext context, {
        int duration = LENGTH_SHORT,
        int gravity = BOTTOM,
        Color backgroundColor = const Color(0xAA000000),
        Color textColor = Colors.white,
        double backgroundRadius = 20,
        Border? border,  // Nullable border
      }) {
    ToastView.dismiss();
    ToastView.createView(
      msg,
      context,
      duration,
      gravity,
      backgroundColor,
      textColor,
      backgroundRadius,
      border ?? Border.all(),  // Handle null case
    );
  }
}

class ToastView {
  factory ToastView() => _singleton;
  ToastView._internal();

  static final ToastView _singleton = ToastView._internal();

  static late OverlayState overlayState;
  static late OverlayEntry _overlayEntry;
  static bool _isVisible = false;

  static void createView(
      String msg,
      BuildContext context,
      int duration,
      int gravity,
      Color background,
      Color textColor,
      double backgroundRadius,
      Border border,
      ) async {
    overlayState = Overlay.of(context);
    if (overlayState == null) {
      throw Exception("No Overlay found in the widget tree.");
    }

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) => ToastWidget(
        widget: Container(
          width: MediaQuery.of(context).size.width,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(backgroundRadius),
                border: border,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
              child: Text(
                msg,
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(fontSize: 15, color: textColor),
              ),
            ),
          ),
        ),
        gravity: gravity,
      ),
    );

    _isVisible = true;
    overlayState.insert(_overlayEntry);
    await Future<dynamic>.delayed(
      Duration(seconds: duration == Toast.LENGTH_SHORT ? 1 : 2),
    );
    dismiss();
  }

  static void dismiss() {
    if (!_isVisible || _overlayEntry == null) {
      return;
    }
    _isVisible = false;
    _overlayEntry.remove();
  }
}

class ToastWidget extends StatelessWidget {
  const ToastWidget({
    required this.widget,
    required this.gravity,
  });

  final Widget widget;
  final int gravity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: gravity == Toast.TOP ? 50 : null,
      bottom: gravity == Toast.BOTTOM ? 50 : null,
      child: Material(
        color: Colors.transparent,
        child: widget,
      ),
    );
  }
}
