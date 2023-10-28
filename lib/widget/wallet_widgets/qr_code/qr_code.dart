import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeWidget extends StatelessWidget {
  final String qrData;
  final double qrSize;
  final Color qrBackgroundColor;
  final Color qrForegroundColor;

  const QRCodeWidget({
    required this.qrData,
    this.qrSize = 160,
    this.qrBackgroundColor = Colors.white,
    this.qrForegroundColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: qrSize,
      height: qrSize,
      child: QrImageView(
        data: qrData,
        version: QrVersions.auto,
        size: qrSize,
        backgroundColor: qrBackgroundColor,
        foregroundColor: qrForegroundColor,
      ),
    );
  }
}
