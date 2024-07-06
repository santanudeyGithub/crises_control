// import 'package:crises_control/src/core/models/media_attachments.dart';
// import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
// import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
// import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
// import 'package:crises_control/src/core/router/route_constants.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// class IncidentMediaAssetsPage extends StatelessWidget {
//   const IncidentMediaAssetsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(language!.title_media_attachments_view),
//       ),
//       body: const IncidentMediaAssetsView(),
//     );
//   }
// }

// class IncidentMediaAssetsView extends StatelessWidget {
//   const IncidentMediaAssetsView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return ListView(
//       children: ListTile.divideTiles(
//         color: Colors.grey,
//         context: context,
//         tiles: [
//           ListTile(
//             onTap: () => _onTileSelected(MediaAttachmentType.website, context),
//             iconColor: Palette.primary,
//             leading: const Icon(Icons.language),
//             title: Text(language!.title_assets_website),
//             trailing: const Icon(Icons.navigate_next),
//           ),
//           ListTile(
//             onTap: () => _onTileSelected(MediaAttachmentType.document, context),
//             iconColor: Palette.primary,
//             leading: const Icon(Icons.description),
//             title: Text(language.title_assets_document),
//             trailing: const Icon(Icons.navigate_next),
//           ),
//           ListTile(
//             onTap: () => _onTileSelected(MediaAttachmentType.video, context),
//             iconColor: Palette.primary,
//             leading: const Icon(Icons.video_file),
//             title: Text(language.title_assets_videos),
//             trailing: const Icon(Icons.navigate_next),
//           ),
//           ListTile(
//             onTap: () => _onTileSelected(MediaAttachmentType.audio, context),
//             iconColor: Palette.primary,
//             leading: const Icon(Icons.audio_file),
//             title: Text(language.title_audio_asset),
//             trailing: const Icon(Icons.navigate_next),
//           ),
//         ],
//       ).toList(),
//     );
//   }

//   _onTileSelected(MediaAttachmentType type, BuildContext context) {
//     Navigator.pushNamed(
//       context,
//       RouteConstants.mediaAssetListView,
//       arguments: MediaAssetListViewArguments(
//         type,
//         [],
//       ),
//     );
//   }
// }

// class MediaAssetListView extends StatelessWidget {
//   const MediaAssetListView({
//     super.key,
//     required this.type,
//     required this.mediaAttachments,
//   });
//   final MediaAttachmentType type;
//   final List<MediaAttachment> mediaAttachments;

//   @override
//   Widget build(BuildContext context) {
//     var language = AppLocalizations.of(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           mediaAssetTypeToTitle(type, language!),
//         ),
//       ),
//       body: mediaAttachments.isNotEmpty
//           ? ListView.builder(
//               itemCount: mediaAttachments.length,
//               itemBuilder: (context, index) => ListTile(
//                 iconColor: Palette.primary,
//                 leading: Icon(mediaAssetTypeToIcon(type)),
//                 title: Text(mediaAttachments[index].fileName),
//                 trailing: const Icon(Icons.navigate_next),
//               ),
//             )
//           : EmptyState(text: language.no_data, icon: null),
//     );
//   }

//   static String mediaAssetTypeToTitle(
//     MediaAttachmentType type,
//     AppLocalizations locale,
//   ) {
//     switch (type) {
//       case MediaAttachmentType.website:
//         return locale.title_assets_website;
//       case MediaAttachmentType.document:
//         return locale.title_assets_document;
//       case MediaAttachmentType.video:
//         return locale.title_assets_videos;
//       case MediaAttachmentType.audio:
//         return locale.title_assets_audio;
//       case MediaAttachmentType.image:
//         return '';
//       default:
//         return '';
//     }
//   }

//   static IconData mediaAssetTypeToIcon(
//     MediaAttachmentType type,
//   ) {
//     switch (type) {
//       case MediaAttachmentType.website:
//         return Icons.language;
//       case MediaAttachmentType.document:
//         return Icons.description;
//       case MediaAttachmentType.video:
//         return Icons.video_file;
//       case MediaAttachmentType.audio:
//         return Icons.audio_file;
//       case MediaAttachmentType.image:
//         return Icons.image;
//     }
//   }
// }

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/incident/view/asset_website.dart';
import 'package:crises_control/src/incident/view/audio.dart';
import 'package:crises_control/src/incident/view/documents.dart';
import 'package:crises_control/src/incident/view/videos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class IncidentMediaAssetsPage extends StatelessWidget {
  const IncidentMediaAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      //appBar: AppBar(
      // title: Text(language!.title_media_attachments_view),
      //  ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(title: language!.title_media_attachments_view),
          ),
          Positioned(
            top: 185, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 50,
            child: Column(
              children: [
                Container(
                  width: 350,
                  height: 350,
                  child: const IncidentMediaAssetsView(),
                ),
              ],
            ),
          ),
        ],
      ),

      // const IncidentMediaAssetsView(),
    );
  }
}

class IncidentMediaAssetsView extends StatelessWidget {
  const IncidentMediaAssetsView({super.key});

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Stack(
      children: [
        Positioned(
          // top: 300,
          child: Container(
            padding: const EdgeInsets.only(top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      //before onTap Method
                      // onTap: () =>
                      // _onTileSelected(MediaAttachmentType.website, context),

                      /////////////////////

                      //New implement onTap method just route the page normal
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AssetWebsite()),
                        );
                      },
                      child: Container(
                        width: 165,
                        height: 170,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 5),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage('assets/images/website.png'),
                                height: 100,
                                width: 100,
                              ),
                              const SizedBox(
                                height: 2,
                                width: 5,
                              ),
                              Text(
                                "Asset Website",
                                style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff0B223C)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      //before onTap Method
                      // onTap: () => _onTileSelected(
                      // MediaAttachmentType.document, context),

                      /////////////////////

                      //New implement onTap method just route the page normal
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Documents()),
                        );
                      },
                      child: Container(
                        width: 165,
                        height: 170,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 15,
                                spreadRadius: 5),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Image(
                                image: AssetImage(
                                    'assets/images/documentspng.png'),
                                height: 100,
                                width: 100,
                              ),

                              const SizedBox(
                                height: 2,
                                width: 5,
                              ),
                              Text(
                                "Documents",
                                style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xff0B223C)),
                              ),
                              // Padding(
                              //padding: const EdgeInsets.only(bottom: 10),
                              // child: Text("View"),
                              //),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(),
          child: Positioned(
            // top: 300,
            child: Container(
              padding: const EdgeInsets.only(top: 175),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        //before onTap Method
                        //onTap: () =>
                        //_onTileSelected(MediaAttachmentType.video, context),
                        /////////////////////

                        //New implement onTap method just route the page normal
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Videos()),
                          );
                        },

                        child: Container(
                          width: 165,
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 15,
                                    spreadRadius: 5),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/images/videopng.png'),
                                  height: 90,
                                  width: 90,
                                ),
                                const SizedBox(
                                  height: 2,
                                  width: 5,
                                ),
                                Text(
                                  "Videos",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff0B223C)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        // onTap: () =>
                        // _onTileSelected(MediaAttachmentType.audio, context),

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Audio()),
                          );
                        },
                        child: Container(
                          width: 165,
                          height: 170,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 5),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              children: [
                                Image(
                                  image:
                                      AssetImage('assets/images/audiopng.png'),
                                  height: 100,
                                  width: 100,
                                ),

                                const SizedBox(
                                  height: 2,
                                  width: 5,
                                ),
                                Text(
                                  "Audio",
                                  style: GoogleFonts.urbanist(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xff0B223C)),
                                ),
                                // Padding(
                                //padding: const EdgeInsets.only(bottom: 10),
                                // child: Text("View"),
                                //),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onTileSelected(MediaAttachmentType type, BuildContext context) {
    Navigator.pushNamed(
      context,
      RouteConstants.mediaAssetListView,
      arguments: MediaAssetListViewArguments(
        type,
        [],
      ),
    );
  }
}

class MediaAssetListView extends StatelessWidget {
  const MediaAssetListView({
    super.key,
    required this.type,
    required this.mediaAttachments,
  });
  final MediaAttachmentType type;
  final List<MediaAttachment> mediaAttachments;

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          mediaAssetTypeToTitle(type, language!),
        ),
      ),
      body: mediaAttachments.isNotEmpty
          ? ListView.builder(
              itemCount: mediaAttachments.length,
              itemBuilder: (context, index) => ListTile(
                iconColor: Palette.primary,
                leading: Icon(mediaAssetTypeToIcon(type)),
                title: Text(mediaAttachments[index].fileName),
                trailing: const Icon(Icons.navigate_next),
              ),
            )
          : EmptyState(text: language.no_data, icon: null),
    );
  }

  static String mediaAssetTypeToTitle(
    MediaAttachmentType type,
    AppLocalizations locale,
  ) {
    switch (type) {
      case MediaAttachmentType.website:
        return locale.title_assets_website;
      case MediaAttachmentType.document:
        return locale.title_assets_document;
      case MediaAttachmentType.video:
        return locale.title_assets_videos;
      case MediaAttachmentType.audio:
        return locale.title_assets_audio;
      case MediaAttachmentType.image:
        return '';
      default:
        return '';
    }
  }

  static IconData mediaAssetTypeToIcon(
    MediaAttachmentType type,
  ) {
    switch (type) {
      case MediaAttachmentType.website:
        return Icons.language;
      case MediaAttachmentType.document:
        return Icons.description;
      case MediaAttachmentType.video:
        return Icons.video_file;
      case MediaAttachmentType.audio:
        return Icons.audio_file;
      case MediaAttachmentType.image:
        return Icons.image;
    }
  }
}
