// ignore_for_file: deprecated_member_use

import 'package:crises_control/src/core/cubit/list_cubit.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SocialIntergrationsListPage extends StatelessWidget {
  const SocialIntergrationsListPage({
    super.key,
    required this.selectedSocialIntegrations,
  });
  final List<String> selectedSocialIntegrations;

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(language!.label_social_post),
      ),
      body: _SocialIntergrationsListBody(selectedSocialIntegrations),
    );
  }
}

class _SocialIntergrationsListBody extends StatefulWidget {
  const _SocialIntergrationsListBody(this.selectedSocialIntegrations);
  final List<String> selectedSocialIntegrations;

  @override
  State<_SocialIntergrationsListBody> createState() =>
      _SocialIntergrationsListBodyState();
}

class _SocialIntergrationsListBodyState
    extends State<_SocialIntergrationsListBody> {
  final _loadingOverlay = CCLoadingOverlay();
  final List<String> _selectedSocialIntegrations = [];
  final List<String> _allSocialIntergrations = [
    'Facebook',
    'Twitter',
    'WhatsApp'
  ];

  @override
  initState() {
    super.initState();
    _selectedSocialIntegrations.addAll(widget.selectedSocialIntegrations);
  }

  final List<String> _selectedSocialIntergrations = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ListCubit, ListState>(
      listener: (context, state) {
        if (state is ListLoading) {
          _loadingOverlay.show(context);
        } else {
          _loadingOverlay.hide();
        }
        if (state is ListError) {
          showDialog(
            context: context,
            builder: (context) => state.error.displayErrorAlerts(context),
          );
        }
        if (state is SocialIntergrationsLoaded) {
          _allSocialIntergrations.addAll(state.socialIntergrations);
        }
      },
      builder: (context, state) {
        if (state is SocialIntergrationsLoaded) {
          return WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, _selectedSocialIntegrations);
              return true;
            },
            child: ListView.builder(
              itemCount: _allSocialIntergrations.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(_allSocialIntergrations[index]),
                  value: _selectedSocialIntergrations
                      .contains(_allSocialIntergrations[index]),
                  onChanged: (value) {
                    if (value!) {
                      setState(() {
                        _selectedSocialIntergrations
                            .add(_allSocialIntergrations[index]);
                      });
                    } else {
                      setState(() {
                        _selectedSocialIntergrations
                            .remove(_allSocialIntergrations[index]);
                      });
                    }
                  },
                );
              },
            ),
          );
        }
        if (state is ListError) {
          return const EmptyState(
            text: "Unable To Load Social Media Providers",
            icon: null,
          );
        }
        return Container();
      },
    );
  }
}
