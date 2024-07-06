// ignore_for_file: use_super_parameters
import 'package:google_fonts/google_fonts.dart';
import 'package:crises_control/src/core/utils/colors_helper.dart';
import 'package:crises_control/src/core/utils/common.dart';
import 'package:flutter/material.dart';
import '../styles/text/material_colors_helper.dart';

class CrisesControlLogoView extends StatelessWidget {
  const CrisesControlLogoView({
    super.key,
    this.width = 260,
    this.height = 260,
  });
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Image(
        image:
            const AssetImage('assets/images/crises_control_logo_new_two.png'),
        width: width,
        height: height,
      ),
    );
  }
}

class CCDateTime extends StatelessWidget {
  const CCDateTime({
    Key? key,
    required this.date,
    this.hasAttachment = false,
  }) : super(key: key);

  final String date;
  final bool hasAttachment;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.schedule,
          size: 14,
          color: Colors.grey,
        ),
        const SizedBox(width: 2),
        Text(
          date,
          style:
              Theme.of(context).textTheme.bodySmall?.apply(color: Colors.grey),
        ),
        Visibility(
          visible: hasAttachment,
          child: const Icon(
            Icons.attach_file,
            size: 14,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

class MenuItemRow extends StatelessWidget {
  const MenuItemRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final Text text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Palette.primary,
        ),
        const SizedBox(width: 10),
        text
      ],
    );
  }
}

class TabBarItem extends StatelessWidget {
  const TabBarItem({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);
  final IconData icon;
  final Text text;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Palette.primary,
        ),
        text
      ],
    );
  }
}

class SelectionListTile extends StatelessWidget {
  const SelectionListTile(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap,
      this.prefixIcon});
  final String title;
  final IconData? prefixIcon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: prefixIcon != null
          ? Icon(
              prefixIcon,
              color: isSelected ? Palette.primary : null,
            )
          : null,
      title: Text(title),
      trailing: isSelected
          ? const Icon(
              Icons.check,
              color: Palette.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.searchTextController,
    required this.onClear,
    this.onChanged,
  });
  final TextEditingController searchTextController;
  final VoidCallback onClear;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide.none, // Remove the default border
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
            ),
          ),
        ),
        // SizedBox(width: 5.0),
        // Padding(
        //   padding: const EdgeInsets.only(left: 5),
        //   child: Image(
        //     image: AssetImage('assets/images/location_tracker.png'),
        //   ),
        // ),
      ],
    );
  }
}

class CustomImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final BoxFit fit;

  const CustomImageWidget({
    Key? key,
    required this.imagePath,
    this.width = 100.0,
    this.height = 100.0,
    this.fit = BoxFit.cover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: fit,
    );
  }
}

class SenderInfo extends StatelessWidget {
  const SenderInfo({
    Key? key,
    required this.senderName,
    required this.date,
    this.hasAttachment = false,
  }) : super(key: key);

  final String senderName;
  final String date;
  final bool hasAttachment;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CCAvatar(senderName: senderName),
        const SizedBox(width: 10),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(senderName),
                CCDateTime(date: date, hasAttachment: hasAttachment)
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class PingMsgInfo extends StatelessWidget {
  const PingMsgInfo({
    Key? key,
    required this.senderName,
    required this.date,
    this.hasAttachment = false,
  }) : super(key: key);

  final String senderName;
  final String date;
  final bool hasAttachment;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(senderName,
            style: GoogleFonts.urbanist(
              color: Color(0xff0B223C),
              fontSize: 22,
              fontWeight: FontWeight.w800,
            )),
        //CCDateTime(date: date, hasAttachment: hasAttachment),
      ],
    );
  }
}

class CCAvatar extends StatelessWidget {
  const CCAvatar({
    Key? key,
    required this.senderName,
    this.radius = 20,
    this.fontSize = 14,
  }) : super(key: key);

  final String senderName;
  final double radius;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: ColorsHelper.colorFor(senderName),
      child: Text(
        StringHelpers.getInitials(senderName),
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
  }
}
