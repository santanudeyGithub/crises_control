import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/ping/bloc/bloc.dart';
import 'package:crises_control/src/ping/cubit/pings/pings_cubit.dart';
import 'package:flutter/material.dart';

import 'widgets.dart';

class PingListBody extends StatelessWidget {
  PingListBody({super.key});
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        context.read<PingsCubit>().loadAllPings(isRefresh: true);
        return Future.value();
      },
      child: BlocConsumer<PingsCubit, PingsState>(
        listener: (context, state) {
          handleStateChanges(state, context);
        },
        builder: (context, state) {
          if (state.pings.isNotEmpty) {
            // return ListView.separated(
            //   itemCount: state.pings.length,
            //   itemBuilder: (context, index) {
            //     return PingListTile(ping: state.pings[index]);
            //   },
            //   separatorBuilder: (BuildContext context, int index) {
            //     return const Divider();
            //   },
            // );
            return ListView.separated(
              itemCount: state.pings.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: const Color.fromARGB(255, 237, 236, 236),
                        width: 3),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: PingListTile(ping: state.pings[index]),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider();
              },
            );
          }
          if (state.action == PingsStateActions.empty) {
            return const Center(
              child: EmptyState(text: 'No Pings', icon: null),
            );
          }
          if (state.error != null) {
            return const Center(
              child: EmptyState(text: 'No Pings', icon: null),
            );
          }

          return Container();
        },
      ),
    );
  }

  void handleStateChanges(PingsState state, BuildContext context) {
    if (state.action == PingsStateActions.loading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }

    if (state.error != null) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error!, context),
      );
    }
  }
}
