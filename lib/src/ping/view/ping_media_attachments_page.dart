// ignore_for_file: use_build_context_synchronously

import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_alert_dialog.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/ping/cubit/media_attachments_cubit.dart';
import 'package:crises_control/src/ping/ping.dart';
import 'package:crises_control/src/ping/widgets/ping_media_attachments_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

///Ping list page responsible for displaying all of the users pings.
class PingMediAttachmentPage extends StatefulWidget {
  /// {@macro ping_page}
  const PingMediAttachmentPage({super.key, required this.mediaAttachments});
  final List<MediaAttachment> mediaAttachments;

  /// The static route for PingPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const PingMediAttachmentPage(mediaAttachments: []));
  }

  @override
  State<PingMediAttachmentPage> createState() => _PingMediAttachmentPageState();
}

class _PingMediAttachmentPageState extends State<PingMediAttachmentPage> {
  @override
  void initState() {
    super.initState();
  }

  onRecordAudio(BuildContext context) async {
    final mediaAttachment = await Navigator.pushNamed(
        context, RouteConstants.recordAudioPage,
        arguments: RecordAudioPageArguments('')) as MediaAttachment?;

    if (mediaAttachment != null) {
      if (!mounted) return;
      context
          .read<MediaAttachmentsCubit>()
          .addAudioMediaAttachment(mediaAttachment);
    }
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(language!.title_media_attachments_view),
      ),
      body:  PingMediaAttachmentsBody(mediaAttachments: widget.mediaAttachments),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Palette.primary,
        type: BottomNavigationBarType.fixed,
        unselectedFontSize: 8,
        selectedFontSize: 8,
        iconSize: 24,
        onTap: (index) {
          switch (index) {
            case 0:
              handleTakePictureOrVideo(context, language);
              break;
            case 1:
              handlePickFromGallery(context, language);
              break;
            case 2:
              onRecordAudio(context);
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.add_a_photo,
              color: Palette.primary,
            ),
            label: language.label_take_picture,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.add_photo_alternate,
              color: Palette.primary,
            ),
            label: language.label_pick_gallery,
          ),
          BottomNavigationBarItem(
            icon: const Icon(
              Icons.mic,
              color: Palette.primary,
            ),
            label: language.label_record_audio,
          ),
        ],
      ),
    );
  }

  Future<dynamic> handleTakePictureOrVideo(
      BuildContext context, AppLocalizations language) {
    return showDialog(
      context: context,
      builder: ((_) {
        return CCAlertDialog(
          title: language.photo_or_video,
          description: language.alert_attachment_type,
          actions: [
            TextButton(
              onPressed: (() async {
                context.read<MediaAttachmentsCubit>().takePicture(
                      fromGallery: false,
                      isVideo: true,
                      saveToGallery:
                          await _shouldSaveToGallery(context, language),
                    );

                if (!mounted) return;
                Navigator.pop(context);
              }),
              child: Text(language.video),
            ),
            TextButton(
              onPressed: (() async {
                context.read<MediaAttachmentsCubit>().takePicture(
                      fromGallery: false,
                      isVideo: false,
                      saveToGallery:
                          await _shouldSaveToGallery(context, language),
                    );

                if (!mounted) return;
                Navigator.pop(context);
              }),
              child: Text(language.photo),
            )
          ],
        );
      }),
    );
  }

  Future<dynamic> _shouldSaveToGallery(
      BuildContext context, AppLocalizations language) {
    return showDialog(
      context: context,
      builder: ((_) {
        return CCAlertDialog(
          title: language.save_to_gallery,
          description: language.alert_saveto_gallery,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(language.no),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(language.yes),
            )
          ],
        );
      }),
    );
  }

  Future<dynamic> handlePickFromGallery(
      BuildContext context, AppLocalizations language) {
    return showDialog(
      context: context,
      builder: ((_) {
        return CCAlertDialog(
          title: language.photo_or_video,
          description: language.alert_attachment_type_pick,
          actions: [
            TextButton(
              onPressed: (() {
                context.read<MediaAttachmentsCubit>().takePicture(
                    fromGallery: true, isVideo: true, saveToGallery: false);

                if (!mounted) return;
                Navigator.pop(context);
              }),
              child: Text(language.video),
            ),
            TextButton(
              onPressed: (() {
                context.read<MediaAttachmentsCubit>().takePicture(
                    fromGallery: true, isVideo: false, saveToGallery: false);

                if (!mounted) return;
                Navigator.pop(context);
              }),
              child: Text(language.photo),
            )
          ],
        );
      }),
    );
  }
}

