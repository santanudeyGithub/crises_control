import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/home/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';

import 'widgets.dart';

class HomeBody extends StatefulWidget {
  /// {@macro home_body}
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  List<HomeIcon> _homeIcons = [];

  @override
  Widget build(BuildContext context) {
    void onReorder(int oldIndex, int newIndex) {
      setState(() {
        HomeIcon homeIcon = _homeIcons.removeAt(oldIndex);
        _homeIcons.insert(newIndex, homeIcon);
        context.read<HomeCubit>().onRearrangedItems(_homeIcons);
      });
    }

    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      handleStateChanges(state, context);
    }, builder: (context, state) {
      if (state is HomeLoaded) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: ReorderableWrap(
                  spacing: 5,
                  runSpacing: 5,
                  onReorder: onReorder,
                  children: _homeIcons = state.icons,
                ),
              ),
            ),
          ],
        );
      }
      if (state is HomeLoading) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: ReorderableWrap(
              spacing: 5,
              runSpacing: 5,
              onReorder: onReorder,
              enableReorder: false,
              children: state.homeIcons,
            ),
          ),
        );
      }
      if (state is HomeFailure) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: ReorderableWrap(
              spacing: 5,
              runSpacing: 5,
              onReorder: onReorder,
              // enableReorder: false,
              children: state.homeIcons,
            ),
          ),
        );
      }
      return Container();
    });
  }

  void handleStateChanges(HomeState state, BuildContext context) {
    if (state is HomeFailure) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error, context),
      );
    }

    if (state is HomeLoaded && state.appHome?.data.companyText != "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            state.appHome!.data.companyText,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          action: SnackBarAction(
            label: 'Dismiss',
            textColor: Colors.white,
            onPressed: () {},
          ),
        ),
      );
    }
  }
}
