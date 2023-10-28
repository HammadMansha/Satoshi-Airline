import 'package:flutter/material.dart';

class CircularImageButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String imagePath; // Path to your app image
  final Color backgroundColor;
  final Color borderColor; // Color of the stroke

  CircularImageButton({
    required this.onPressed,
    required this.imagePath, // Pass the image path
    required this.backgroundColor,
    required this.borderColor, // Add borderColor parameter
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(50),
      // Adjust the radius to make it circular
      child: Container(
        width: 60, // Adjust the button's width
        height: 60, // Adjust the button's height
        decoration: BoxDecoration(
          shape: BoxShape.circle, // Make the container circular
          color: backgroundColor,
          border: Border.all(
              color: borderColor, // Set the color of the stroke
              width: 3.0,
              strokeAlign: 1),
        ),
        child: Center(
          child: Image.asset(
            width: 20,
            height: 25,
            imagePath, // Use the provided image path
            // Change the image color if needed
          ),
        ),
      ),
    );
  }
}
