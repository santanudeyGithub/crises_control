// ignore_for_file: use_super_parameters

import 'package:crises_control/src/companies/models/company.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/home/home.dart';
import 'package:crises_control/src/home/models/drawer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'home_body.dart';

class SideDrawer extends StatelessWidget {
  const SideDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(
                    context,
                    RouteConstants.accountPage,
                  ),
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Color(0xFF024D85),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                            //height: 13,
                            ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, RouteConstants.accountPage),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: state.loginData.iconColor,
                                maxRadius: 25,
                                minRadius: 25,
                                child: Text(
                                  state.loginData.initials,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                state.loginData.fullName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.loginData.companyName,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              state.loginData.primaryEmail,
                              style: const TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Edit details',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                for (var item in DrawerItem.generateUsersDrawer(
                  context,
                  state.securityItems,
                  state.companies.length > 1,
                ))
                  DrawerItemTile(
                    item: item,
                    userCompanies: state.companies,
                  )
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}

class DrawerItemTile extends StatelessWidget {
  const DrawerItemTile(
      {Key? key, required this.item, required this.userCompanies})
      : super(key: key);
  final List<Company> userCompanies;
  final DrawerItem item;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: item.isEnabled,
      child: ListTile(
        title: Text(item.title),
        leading: Icon(
          item.icon.icon,
          color: const Color.fromRGBO(56, 166, 221, 1),
        ),
        trailing: const Icon(
          Icons.navigate_next_rounded,
          color: Palette.primary,
        ),
        onTap: () {
          if (item.type == DrawerItemTypes.awaitingIncident) {
            Navigator.pushNamed(context, DrawerItem.getRoute(item.type),
                arguments: IncidentsPageArgument(true));
          } else if (item.type == DrawerItemTypes.home) {
            Navigator.pop(context);
          } else if (item.type == DrawerItemTypes.logout) {
            context.read<HomeCubit>().logout();
          } else if (item.type == DrawerItemTypes.switchAccounts) {
            Navigator.pushNamed(context, DrawerItem.getRoute(item.type),
                arguments: CompaniesPageArguments(userCompanies));
          } else if (item.type == DrawerItemTypes.newPing) {
            Navigator.pushNamed(context, DrawerItem.getRoute(item.type),
                arguments: NewPingPageArguments(selectedUsers: []));
          } else {
            Navigator.pushNamed(context, DrawerItem.getRoute(item.type));
          }
        },
      ),
    );
  }
}
