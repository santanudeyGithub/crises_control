// ignore_for_file: library_prefixes, deprecated_member_use

import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/cubit/list_cubit.dart';
import 'package:crises_control/src/core/models/communication_models/message_response.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart'
    as searchBar;

class AcknowledgeOptionsListPage extends StatefulWidget {
  const AcknowledgeOptionsListPage({
    super.key,
    required this.selectedAcknowledgeOptions,
  });
  final List<AcknowledgeOption> selectedAcknowledgeOptions;

  @override
  State<AcknowledgeOptionsListPage> createState() =>
      _AcknowledgeOptionsListPage();
}

class _AcknowledgeOptionsListPage extends State<AcknowledgeOptionsListPage> {
  final List<AcknowledgeOption> _selectedAcknowledgeOptions = [];
  List<AcknowledgeOption> _allAcknowledgeOptions = [];
  List<AcknowledgeOption> _searchResults = [];
  final TextEditingController _searchTextController = TextEditingController();
  final CCLoadingOverlay _ccLoadingOverlay = CCLoadingOverlay();

  @override
  void initState() {
    super.initState();
    _selectedAcknowledgeOptions.addAll(widget.selectedAcknowledgeOptions);
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(title: language!.label_acknowledge_options),
          ),
          Positioned(
            top: 135, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 50,
            child: Column(
              children: [
                searchBar.SearchBar(
                  searchTextController: _searchTextController,
                  onClear: () {
                    setState(() {
                      _searchTextController.clear();
                      _onSearchTextChanged('');
                    });
                  },
                  onChanged: (value) {
                    setState(() {
                      _onSearchTextChanged(value);
                    });
                  },
                ),
                Expanded(
                  child: WillPopScope(
                    onWillPop: () async {
                      Navigator.pop(context, _selectedAcknowledgeOptions);
                      return true;
                    },
                    child: BlocConsumer<ListCubit, ListState>(
                        listener: (context, state) {
                      if (state is AcknowledgeOptionsLoaded) {
                        _allAcknowledgeOptions = state.acknowledgeOptions;
                      }
                      if (state is ListError) {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              state.error.displayErrorAlerts(context),
                        );
                      }
                      if (state is ListLoading) {
                        _ccLoadingOverlay.show(context);
                      } else {
                        _ccLoadingOverlay.hide();
                      }
                    }, builder: (context, state) {
                      if (state is AcknowledgeOptionsLoaded) {
                        return Container(
                          margin: const EdgeInsets.only(
                              top: 0,
                              bottom: 32), // Adjust this to position the box
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: ListView.builder(
                            itemCount: _searchTextController.text.isNotEmpty
                                ? _searchResults.length
                                : state.acknowledgeOptions.length,
                            itemBuilder: ((context, index) {
                              var acknowledgeOption =
                                  _searchTextController.text.isNotEmpty
                                      ? _searchResults[index]
                                      : state.acknowledgeOptions[index];
                              var isSelected = _selectedAcknowledgeOptions
                                  .contains(acknowledgeOption);
                              return SelectionListTile(
                                isSelected: isSelected,
                                onTap: () {
                                  if (isSelected) {
                                    setState(() {
                                      _selectedAcknowledgeOptions
                                          .remove(acknowledgeOption);
                                    });
                                  } else {
                                    setState(() {
                                      _selectedAcknowledgeOptions
                                          .add(acknowledgeOption);
                                    });
                                  }
                                },
                                title: acknowledgeOption.responseLabel,
                              );
                            }),
                          ),
                        );
                      }
                      return Container();
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onSearchTextChanged(String text) async {
    setState(() {
      _searchResults = _allAcknowledgeOptions
          .where(
            (value) => (value.responseLabel
                    .toLowerCase()
                    .contains(text.toLowerCase()) ||
                value.responseLabel.toLowerCase().contains(text.toLowerCase())),
          )
          .toList();
    });
  }
}
