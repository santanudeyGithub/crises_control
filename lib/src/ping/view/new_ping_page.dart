// ignore_for_file: use_build_context_synchronously

import 'package:crises_control/src/core/core.dart';
import 'package:crises_control/src/core/models/media_attachments.dart';
import 'package:crises_control/src/core/presentation/pages/lists/user_list_page.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/ping/bloc/bloc.dart';
import 'package:crises_control/src/ping/cubit/new_ping_cubit.dart';
import 'package:crises_control/src/ping/widgets/new_ping_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// The new ping page is where users can create and send new pings
class NewPingPage extends StatefulWidget {
  const NewPingPage({
    super.key,
    this.selectedUsers = const [],
  });
  final List<SelectedUser> selectedUsers;

  /// The static route for PingPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const NewPingPage());
  }

  @override
  State<NewPingPage> createState() => _NewPingPageState();
}

class _NewPingPageState extends State<NewPingPage> {
  List<MediaAttachment> _mediaAttachments = [];
  List<SelectedUser> _selectedUsers = [];

  @override
  Widget build(BuildContext context) {
    var coreRepository =
        RepositoryProvider.of<CrisesControlCoreRepository>(context);
    _selectedUsers = List.from(widget.selectedUsers);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title_new_ping),
        actions: [
          if (coreRepository.checkMenuAccess(SecItemKeys.pingMessageAttachment))
            IconButton(
              onPressed: (() async {
                final attachments = await Navigator.pushNamed(
                  context,
                  RouteConstants.pingMediaAttachments,
                  arguments:
                      PingMediaAttachmentPageArguments(_mediaAttachments),
                ) as List<MediaAttachment>?;
                if (attachments != null) {
                  _mediaAttachments = attachments;
                } else {
                  _mediaAttachments.clear();
                }
                if (!mounted) return;
                context
                    .read<NewPingCubit>()
                    .addMediaAttachments(_mediaAttachments);
              }),
              tooltip: 'Add Media Attachments',
              icon: const Icon(Icons.attach_file),
            ),
        ],
      ),
      body: NewPingView(selectedUsers: _selectedUsers),
    );
  }
}

class NewPingView extends StatelessWidget {
  const NewPingView({super.key, required this.selectedUsers});
  final List<SelectedUser> selectedUsers;

  @override
  Widget build(BuildContext context) {
    return NewPingBody(selectedUsers: selectedUsers);
  }
}
