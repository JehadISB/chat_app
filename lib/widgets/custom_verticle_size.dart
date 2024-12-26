import 'package:flutter/material.dart';

class CustomVerticleSize extends StatelessWidget {
  const CustomVerticleSize({super.key, this.height});
  final double? height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 15,
    );
  }
}
