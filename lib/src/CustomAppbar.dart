import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

// class CustomHeader extends StatelessWidget {
//   final String title;

//   const CustomHeader({Key? key, required this.title}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 225, // Adjust the height as needed
//       decoration: const BoxDecoration(
//           //color: Colors.amber,
//           image: DecorationImage(
//               image: AssetImage("assets/images/img_group_10.png"),
//               fit: BoxFit.fill)),
//       child: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 35),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 15),
//                       child: Text(
//                         title,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// class CustomHeader extends StatelessWidget {
//   final String title;
//   final IconData floatingActionIcon;
//   final VoidCallback floatingActionOnPressed;

//   const CustomHeader({
//     Key? key,
//     required this.title,
//     required this.floatingActionIcon,
//     required this.floatingActionOnPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 225, // Adjust the height as needed
//       decoration: const BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage("assets/images/img_group_10.png"),
//               fit: BoxFit.fill)),
//       child: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 35),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 15),
//                       child: Text(
//                         title,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: Align(
//                 alignment: Alignment.bottomRight,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: FloatingActionButton(
//                     child: Icon(floatingActionIcon),
//                     onPressed: floatingActionOnPressed,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomHeader extends StatelessWidget {
//   final String title;
//   final IconData? floatingActionIcon;
//   final VoidCallback? floatingActionOnPressed;

//   const CustomHeader({
//     Key? key,
//     required this.title,
//     this.floatingActionIcon,
//     this.floatingActionOnPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 225, // Adjust the height as needed
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/images/img_group_10.png"),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 35),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 15),
//                       child: Text(
//                         title,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (floatingActionIcon != null && floatingActionOnPressed != null)
//               Expanded(
//                 child: Align(
//                   alignment: Alignment.bottomRight,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: FloatingActionButton(
//                       child: Icon(floatingActionIcon),
//                       onPressed: floatingActionOnPressed,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CustomHeader extends StatelessWidget {
//   final String title;
//   final IconData? actionIcon;
//   final VoidCallback? actionOnPressed;

//   const CustomHeader({
//     Key? key,
//     required this.title,
//     this.actionIcon,
//     this.actionOnPressed,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 225, // Adjust the height as needed
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage("assets/images/img_group_10.png"),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             const SizedBox(height: 35),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20.0),
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.arrow_back, color: Colors.white),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.only(right: 15),
//                       child: Text(
//                         title,
//                         textAlign: TextAlign.center,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ),
//                   if (actionIcon != null && actionOnPressed != null)
//                     IconButton(
//                       icon: actionIcon,
//                       onPressed: actionOnPressed,
//                     ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class CustomHeader extends StatelessWidget {
  final String title;
  final Widget? actionIcon;
  final VoidCallback? actionOnPressed;

  const CustomHeader({
    Key? key,
    required this.title,
    this.actionIcon,
    this.actionOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280, // Adjust the height as needed
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/img_group_10.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.white, size: 25),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 40),
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  if (actionIcon != null)
                    IconButton(
                      icon: actionIcon!,
                      onPressed: actionOnPressed,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// actions: [
//               if (coreRepository
//                   .checkMenuAccess(SecItemKeys.pingMessageAttachment))
//                 IconButton(
//                   onPressed: (() async {
//                     final attachments = await Navigator.pushNamed(
//                       context,
//                       RouteConstants.pingMediaAttachments,
//                       arguments:
//                           PingMediaAttachmentPageArguments(_mediaAttachments),
//                     ) as List<MediaAttachment>?;
//                     if (attachments != null) {
//                       _mediaAttachments = attachments;
//                     } else {
//                       _mediaAttachments.clear();
//                     }
//                     if (!mounted) return;
//                     context
//                         .read<NewPingCubit>()
//                         .addMediaAttachments(_mediaAttachments);
//                   }),
//                   tooltip: 'Add Media Attachments',
//                   icon: const Icon(Icons.attach_file),
//                 ),
//             ],