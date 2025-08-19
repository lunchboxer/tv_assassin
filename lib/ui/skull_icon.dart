import 'package:flutter/material.dart';

class SkullIcon extends StatelessWidget {
  final double size;

  const SkullIcon({super.key, this.size = 24.0});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.tv_off, size: size);
  }
}
