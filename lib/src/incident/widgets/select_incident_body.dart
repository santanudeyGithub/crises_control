// ignore_for_file: use_super_parameters

//import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/errors/cc_error.dart';
import 'package:crises_control/src/core/presentation/pages/empty_state.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/incident/cubits/select_incident_cubit/select_incident_cubit.dart';
import 'package:crises_control/src/incident/models/incident_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class SelectIncidentBody extends StatefulWidget {
  const SelectIncidentBody({super.key});

  @override
  State<SelectIncidentBody> createState() => _SelectIncidentBodyState();
}

class _SelectIncidentBodyState extends State<SelectIncidentBody> {
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();
  late final String searchQuery;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectIncidentCubit, SelectIncidentState>(
      listener: (context, state) {
        handleStateChanges(state, context);
      },
      builder: (context, state) {
        if (state.incidentList != null) {
          return GridView.builder(
            //padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // maxCrossAxisExtent: 100.0,
              // crossAxisSpacing: 10.0, // Spacing between columns
              // mainAxisSpacing: 10.0, // Spacing between rows
              // childAspectRatio: 1.0,
              crossAxisCount: 3,
              mainAxisSpacing: 0,
              mainAxisExtent: 145,
              crossAxisSpacing: 0,
            ),
            itemCount: state.incidentList?.data.length,
            itemBuilder: ((context, index) {
              return SelectIncidentGridCell(
                incident: state.incidentList!.data[index],
              );
            }),
          );
        }
        return const EmptyState(text: "NO INCIDENTS", icon: null);
      },
    );
  }

  void handleStateChanges(SelectIncidentState state, BuildContext context) {
    if (state.error != null) {
      showDialog(
        context: context,
        builder: (context) => CCError.displayErrorAlert(state.error!, context),
      );
    }
    if (state.isLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }
  }
}

class SelectIncidentGridCell extends StatelessWidget {
  const SelectIncidentGridCell({
    Key? key,
    required this.incident,
  }) : super(key: key);
  final IncidentListDetail incident;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(
        context,
        RouteConstants.launchIncidentPage,
        arguments: LaunchIncidentPageArguments(incident.incidentId),
      ),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                  color: const Color.fromARGB(255, 237, 236, 236), width: 3),
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
            // child: const Padding(
            //  padding: EdgeInsets.all(8.0),
            //child: Image.network(
            //  incident.incidentIcon,
            // width: 60,
            // height: 60,
            //  errorBuilder: (context, error, stackTrace) {
            //  return Image.network(
            //   CrisesControlUrls.logo,
            //   width: 60,
            //   height: 60,
            //  );
            //  },
            //  loadingBuilder: (context, error, stackTrace) {
            //    return Image.network(
            //    CrisesControlUrls.logo,
            //  width: 60,
            //   height: 60,
            //  );
            //  },
            // ),
            // ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/images/img_settings_white_a700.svg',
                    height: 60,
                    width: 60,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.of(context).pushReplacementNamed(
                    // AppRoutes.homeScreenCopyFourScreen);
                  },
                  // child: const Text("AD Incident"),

                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text(
                      maxLines: 1,
                      // overflow: TextOverflow.ellipsis,
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.center,
                      incident.name,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.apply(color: Colors.black),
                      //style: TextStyle(fontSize: 10, color: Colors.black),
                    ),
                  ),
                ),
                // Text(
                //   maxLines: 4,
                //   overflow: TextOverflow.ellipsis,
                //   incident.name,
                //   style: Theme.of(context)
                //       .textTheme
                //       .bodySmall
                //       ?.apply(color: Colors.black),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
