import 'package:flutter/material.dart';
import 'package:satoshi/Utils/app_constants.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(AppConstants.loadingGif)
    );
  }
}
