import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SosPageTwo extends StatefulWidget {
  const SosPageTwo({super.key});

  @override
  State<SosPageTwo> createState() => _SosPageTwoState();
}

class _SosPageTwoState extends State<SosPageTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'SOS Window View',
        height: 150.0,
        backgroundImagePath: 'assets/images/img_group_10.png',
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       // Handle action button press
        //     },
        //   ),
        // ],
      ),
      body: Stack(
        children: [
          Positioned(
            top:
                120, // Adjust the top position to place the search box under the Positioned widget
            left: 10,
            right: 10,
            child: Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                // child: TextField(
                //   decoration: InputDecoration(
                //     prefixIcon: Icon(
                //       Icons.search_rounded, // Example of a different icon
                //       size: 24.0,
                //       color: Color(0xff1760AB),
                //     ),
                //     hintText: 'Search...',
                //     filled: true,
                //     fillColor: Colors.white,
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(25),
                //       borderSide: BorderSide.none, // Remove the default border
                //     ),
                //     contentPadding:
                //         EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                //   ),
                // ),
              ),
            ),
          ),
          Positioned(
            top:
                200, // Adjust the top position to place the GridView below the search box
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 135, // Adjust height as needed
              // child: MyGridView(),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final String backgroundImagePath;
  final Widget? leading;
  final List<Widget>? actions;

  CustomAppBar({
    Key? key,
    required this.title,
    this.height = kToolbarHeight,
    required this.backgroundImagePath,
    this.leading,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          title,
          style: GoogleFonts.roboto(
              fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        ),
        centerTitle: true,
        leading: leading,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
