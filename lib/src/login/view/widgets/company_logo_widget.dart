import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class CompanyLogoView extends StatelessWidget {
  const CompanyLogoView({super.key, required this.height, required this.width});
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      child: CrisesControlLogoView(
        width: width,
        height: height,
      ),
    );
  }
}
