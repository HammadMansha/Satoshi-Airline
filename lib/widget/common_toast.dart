
import 'package:flutter/material.dart';

class CustomToast {

  static void showToast({
    required BuildContext context,
    required String message,
    required String imagePath,
  }) {
    final overlay = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 100.0,
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        imagePath,
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        message,
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 1)).then((_) {
      overlayEntry!.remove();
    });
  }
}
