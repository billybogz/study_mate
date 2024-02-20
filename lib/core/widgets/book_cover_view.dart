import 'package:flutter/material.dart';

class BookCoverView extends StatelessWidget {
  final double width;
  final double height;
  final Color? color;
  final String? text;

  const BookCoverView({
    super.key,
    this.width = 140,
    this.height = 210,
    this.color,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFD1C4E9),
            color ?? const Color(0xFFC5CAE9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 20,
            left: 10,
            child: Container(
              width: width - 20,
              height: height * 0.6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Center(child: Text(text?.toUpperCase() ?? '')),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 10,
            child: Container(
              width: width - 20,
              height: height * 0.2,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 10,
            child: Container(
              width: width - 20,
              height: height * 0.1,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
