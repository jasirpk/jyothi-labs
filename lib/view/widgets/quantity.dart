import 'package:flutter/material.dart';

class QuantityWidget extends StatelessWidget {
  final VoidCallback onpressed;
  final IconData icon;

  const QuantityWidget(
      {super.key, required this.onpressed, required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.shade200,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        iconSize: 18,
        icon: Icon(icon),
        onPressed: onpressed,
      ),
    );
  }
}
