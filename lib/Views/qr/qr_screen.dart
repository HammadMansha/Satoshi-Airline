import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrScreen extends StatelessWidget {
  const QrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 260,
      width: Get.width / 2.0,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          QrImageView(
            data:
                'https://drive.google.com/drive/folders/1a7xkYSISvS6lFIOwLcA3YGKkWsUqQJxj?usp=sharing',
            version: QrVersions.auto,
            size: 200.0,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.android,
                color: Colors.green,
                size: 20,
              ),
              SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  "Download app now!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
