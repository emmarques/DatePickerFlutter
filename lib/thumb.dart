import 'package:flutter/material.dart';

class ThumbIndicator extends StatelessWidget {
 const ThumbIndicator({
    Key? key,
    required this.size,
  }) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: const Image(
        image: AssetImage('images/earth.png'),
      ),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 4
          )
        ]
      ),
    );
  }
}