// ignore_for_file: deprecated_member_use, use_super_parameters

import 'dart:io';

import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/ping/cubit/media_attachments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:crises_control/src/ping/bloc/bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:video_player/video_player.dart';

class PingMediaAttachmentsBody extends StatefulWidget {
  const PingMediaAttachmentsBody({super.key, required this.mediaAttachments});
  final List<MediaAttachment> mediaAttachments;

  @override
  State<PingMediaAttachmentsBody> createState() =>
      _PingMediaAttachmentsBodyState();
}

class _PingMediaAttachmentsBodyState extends State<PingMediaAttachmentsBody> {
  @override
  void initState() {
    super.initState();
    context
        .read<MediaAttachmentsCubit>()
        .addAllAudioMediaAttachment(widget.mediaAttachments);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MediaAttachmentsCubit, MediaAttachmentsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.mediaAttachments.isEmpty) {
          return const MediaEmptyState();
        }
        return WillPopScope(
          onWillPop: () async {
            Navigator.pop(context, state.mediaAttachments);
            return true;
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
              itemCount: state.mediaAttachments.length,
              itemBuilder: ((context, index) {
                var attachment = state.mediaAttachments[index];
                switch (attachment.mediaAttachmentType) {
                  case MediaAttachmentType.image:
                    return _ImagePreview(attachment: attachment);
                  case MediaAttachmentType.video:
                    return VideoItem(attachment: attachment);
                  case MediaAttachmentType.audio:
                    return _AudioPreview(attachment: attachment);
                  default:
                    return Container();
                }
              }),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  color: Colors.grey,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _ImagePreview extends StatelessWidget {
  _ImagePreview({
    Key? key,
    required this.attachment,
  }) : super(key: key);

  final MediaAttachment attachment;
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Image.file(
            File(attachment.filePath),
            width: 100,
            height: 100,
          ),
          onPressed: () => Navigator.pushNamed(
              context, RouteConstants.photoViewerPage,
              arguments: PhotoViewerPageArguments(attachment.filePath)),
        ),
        TextButton(
          onPressed: () {
            editMediaTitle(context, attachment);
          },
          child: Text(
            attachment.title,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        const Spacer(),
        _DeleteButton(attachment: attachment),
      ],
    );
  }

  editMediaTitle(BuildContext context, MediaAttachment mediaAttachment) {
    var language = AppLocalizations.of(context);
    return showDialog(
      context: context,
      builder: (alertcontext) {
        return AlertDialog(
          title: Text(
            language!.enter_the_title_for_the_attachment,
          ),
          content: TextField(
            controller: _textEditingController,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  context.read<MediaAttachmentsCubit>().renameMediaAttachment(
                        mediaAttachment,
                        _textEditingController.text,
                      );
                  Navigator.pop(context);
                },
                child: Text(language.ok))
          ],
        );
      },
    );
  }
}

class _DeleteButton extends StatelessWidget {
  const _DeleteButton({
    Key? key,
    required this.attachment,
  }) : super(key: key);

  final MediaAttachment attachment;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context
          .read<MediaAttachmentsCubit>()
          .removeMediaAttachment(attachment),
      icon: const Icon(Icons.delete),
    );
  }
}

class _AudioPreview extends StatelessWidget {
  _AudioPreview({
    Key? key,
    required this.attachment,
  }) : super(key: key);

  final MediaAttachment attachment;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.audio_file),
          onPressed: () => Navigator.pushNamed(
              context, RouteConstants.recordAudioPage,
              arguments: RecordAudioPageArguments(attachment.filePath)),
        ),
        const SizedBox(width: 10),
        TextButton(
          onPressed: () {
            editMediaTitle(context, attachment);
          },
          child: Text(
            attachment.title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ),
        const Spacer(),
        _DeleteButton(attachment: attachment),
      ],
    );
  }

  editMediaTitle(BuildContext context, MediaAttachment mediaAttachment) {
    var language = AppLocalizations.of(context);
    return showDialog(
      context: context,
      builder: (alertcontext) {
        return AlertDialog(
          title: Text(
            language!.enter_the_title_for_the_attachment,
          ),
          content: TextField(
            controller: _textEditingController,
          ),
          actions: [
            TextButton(
                onPressed: () {
                  context.read<MediaAttachmentsCubit>().renameMediaAttachment(
                        mediaAttachment,
                        _textEditingController.text,
                      );
                  Navigator.pop(context);
                },
                child: Text(language.ok))
          ],
        );
      },
    );
  }
}

class MediaEmptyState extends StatelessWidget {
  const MediaEmptyState({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Column(
            children: [
              const Icon(
                Icons.upload_file,
                size: 150,
              ),
              const SizedBox(height: 5),
              Text(
                'Upload Media Attachments',
                style: Theme.of(context).textTheme.headline6,
              )
            ],
          ),
        ),
      ],
    );
  }
}

class VideoItem extends StatefulWidget {
  const VideoItem({super.key, required this.attachment});
  final MediaAttachment attachment;
  @override
  State<VideoItem> createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _controller;
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.attachment.filePath))
      ..initialize().then((_) {
        setState(() {}); //when your thumbnail will show.
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _controller.value.isInitialized
          ? SizedBox(
              width: 100.0,
              height: 100.0,
              child: VideoPlayer(_controller),
            )
          : const CircularProgressIndicator(),
      TextButton(
        onPressed: () => editMediaTitle(context, widget.attachment),
        child: Text(
          widget.attachment.title,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      const Spacer(),
      _DeleteButton(attachment: widget.attachment),
    ]);
  }

  editMediaTitle(BuildContext context, MediaAttachment mediaAttachment) {
    var language = AppLocalizations.of(context);
    return showDialog(
      context: context,
      builder: (alertcontext) {
        return AlertDialog(
          title: Text(language!.enter_the_title_for_the_attachment),
          content: TextField(
            onChanged: (value) {},
            controller: _textEditingController,
          ),
          actions: [
            TextButton(
                onPressed: () =>
                    context.read<MediaAttachmentsCubit>().renameMediaAttachment(
                          mediaAttachment,
                          _textEditingController.text,
                        ),
                child: Text(language.ok))
          ],
        );
      },
    );
  }
}
