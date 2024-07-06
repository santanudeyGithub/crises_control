import 'package:crises_control/src/CustomAppbar.dart';
import 'package:flutter/material.dart';

class AssetWebsite extends StatefulWidget {
  const AssetWebsite({super.key});

  @override
  State<AssetWebsite> createState() => _AssetWebsiteState();
}

class _AssetWebsiteState extends State<AssetWebsite> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              //title: language!.title_incident_messages,
              title: 'Asset Website',
            ),
          ),
        ],
      ),
    );
  }
}
