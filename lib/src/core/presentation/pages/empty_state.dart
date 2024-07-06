// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.text, required this.icon});
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          Visibility(
            visible: icon != null,
            child: Icon(
              icon,
              size: 80,
            ),
          )
        ],
      ),
    );
  }
}
