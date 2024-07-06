import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/presentation/styles/text/material_colors_helper.dart';
import 'package:crises_control/src/core/presentation/widgets/cc_activity_indicator.dart';
import 'package:crises_control/src/core/router/page_arguments/page_arguments.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/web_view/web_view_page.dart';
import 'package:crises_control/src/help/help.dart';
import 'package:crises_control/src/help/help_rest_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:share_plus/share_plus.dart';
import 'package:crises_control/src/CustomAppbar.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title: language!.title_help_and_support,
            ),
          ),
          Positioned(
            top: 150, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 0,
            child: HelpBody(language: language),
          ),
        ],
      ),
    );
  }
}

class HelpBody extends StatelessWidget {
  final AppLocalizations language;
  final CCLoadingOverlay _loadingOverlay = CCLoadingOverlay();

  HelpBody({super.key, required this.language});

  final InAppReview inAppReview = InAppReview.instance;

  @override
  // Widget build(BuildContext context) {
  //   return BlocConsumer<HelpCubit, HelpState>(
  //     listener: (context, state) {
  //       handleStateChanges(state, context);
  //     },
  //     builder: (context, state) {
  //       var language = AppLocalizations.of(context);
  //       return Container(
  //           margin: const EdgeInsets.all(16.0),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(16.0),
  //             color: Colors.white,
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.withOpacity(1),
  //                 spreadRadius: 2,
  //                 blurRadius: 5,
  //                 offset: Offset(0, 3), // changes position of shadow
  //               ),
  //             ],
  //           ),
  //           child: ClipRRect(
  //               borderRadius: BorderRadius.circular(16.0),
  //               child: SettingsList(
  //                 sections: [
  //                   SettingsSection(
  //                     tiles: <SettingsTile>[
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.support_agent,
  //                           color: Color.fromRGBO(56, 166, 221, 1),
  //                         ),
  //                         onPressed: (context) =>
  //                             context.read<HelpCubit>().callSupport(),
  //                         title:
  //                             const Text(SupportConstants.supportPhoneNumber),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.email,
  //                           color: Palette.primary,
  //                         ),
  //                         title: const Text(SupportConstants.supportEmail),
  //                         onPressed: (context) =>
  //                             context.read<HelpCubit>().emailSupport(),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.reviews,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language!.label_help_give_feedback),
  //                         onPressed: (_) => Navigator.pushNamed(
  //                             context, RouteConstants.feedbackPage),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.device_unknown,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.label_Devicesetting_Info),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.star,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.label_help_rate_app),
  //                         onPressed: (context) async {
  //                           if (await inAppReview.isAvailable()) {
  //                             inAppReview.requestReview();
  //                           }
  //                         },
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.share,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.title_refer_a_friend),
  //                         onPressed: (context) {
  //                           Share.share(
  //                             language.label_refer_text,
  //                             subject: language.label_refer_subject,
  //                           );
  //                         },
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.description,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.title_resources),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.gavel,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.title_terms_and_conditions),
  //                         onPressed: (context) =>
  //                             context.read<HelpCubit>().onPolicy(
  //                                   policyType: PolicyType.terms,
  //                                 ),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.phonelink_lock,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.label_help_privacy_policy),
  //                         onPressed: (context) =>
  //                             context.read<HelpCubit>().onPolicy(
  //                                   policyType: PolicyType.privacy,
  //                                 ),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.published_with_changes,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.label_help_whats_new),
  //                         onPressed: (context) => Navigator.pushNamed(
  //                           context,
  //                           RouteConstants.webViewPage,
  //                           arguments: WebViewPageArguments(
  //                             CrisesControlUrls.whatsNewurl,
  //                             language.label_help_whats_new,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               )));
  //     },
  //   );
  // }
  // Widget build(BuildContext context) {
  //   return BlocConsumer<HelpCubit, HelpState>(
  //     listener: (context, state) {
  //       handleStateChanges(state, context);
  //     },
  //     builder: (context, state) {
  //       var language = AppLocalizations.of(context);
  //       return Container(
  //         color: Colors.transparent, // Background color of the whole screen
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Container(
  //             decoration: BoxDecoration(
  //               color: Colors.white, // Set the background color here
  //               borderRadius: BorderRadius.circular(16.0),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey.withOpacity(0.5),
  //                   spreadRadius: 2,
  //                   blurRadius: 5,
  //                   offset: Offset(0, 3), // changes position of shadow
  //                 ),
  //               ],
  //             ),
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(16.0),
  //               child: SettingsList(
  //                 sections: [
  //                   SettingsSection(
  //                     tiles: <SettingsTile>[
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.support_agent,
  //                           color: Color.fromRGBO(56, 166, 221, 1),
  //                         ),
  //                         onPressed: (context) =>
  //                             context.read<HelpCubit>().callSupport(),
  //                         title:
  //                             const Text(SupportConstants.supportPhoneNumber),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.email,
  //                           color: Palette.primary,
  //                         ),
  //                         title: const Text(SupportConstants.supportEmail),
  //                         onPressed: (context) =>
  //                             context.read<HelpCubit>().emailSupport(),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.reviews,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language!.label_help_give_feedback),
  //                         onPressed: (_) => Navigator.pushNamed(
  //                             context, RouteConstants.feedbackPage),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.device_unknown,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.label_Devicesetting_Info),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.star,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.label_help_rate_app),
  //                         onPressed: (context) async {
  //                           if (await inAppReview.isAvailable()) {
  //                             inAppReview.requestReview();
  //                           }
  //                         },
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.share,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.title_refer_a_friend),
  //                         onPressed: (context) {
  //                           Share.share(
  //                             language.label_refer_text,
  //                             subject: language.label_refer_subject,
  //                           );
  //                         },
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.description,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.title_resources),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.gavel,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.title_terms_and_conditions),
  //                         onPressed: (context) =>
  //                             context.read<HelpCubit>().onPolicy(
  //                                   policyType: PolicyType.terms,
  //                                 ),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.phonelink_lock,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.label_help_privacy_policy),
  //                         onPressed: (context) =>
  //                             context.read<HelpCubit>().onPolicy(
  //                                   policyType: PolicyType.privacy,
  //                                 ),
  //                       ),
  //                       SettingsTile.navigation(
  //                         leading: const Icon(
  //                           Icons.published_with_changes,
  //                           color: Palette.primary,
  //                         ),
  //                         title: Text(language.label_help_whats_new),
  //                         onPressed: (context) => Navigator.pushNamed(
  //                           context,
  //                           RouteConstants.webViewPage,
  //                           arguments: WebViewPageArguments(
  //                             CrisesControlUrls.whatsNewurl,
  //                             language.label_help_whats_new,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget build(BuildContext context) {
    return BlocConsumer<HelpCubit, HelpState>(
      listener: (context, state) {
        handleStateChanges(state, context);
      },
      builder: (context, state) {
        var language = AppLocalizations.of(context);
        return Container(
          color: Colors.transparent, // Background color of the whole screen
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set the background color here
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: SettingsList(
                  sections: [
                    SettingsSection(
                      //titlePadding: EdgeInsets.all(16.0),
                      tiles: <SettingsTile>[
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.support_agent,
                            color: Color.fromRGBO(56, 166, 221, 1),
                          ),
                          onPressed: (context) =>
                              context.read<HelpCubit>().callSupport(),
                          title:
                              const Text(SupportConstants.supportPhoneNumber),
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.email,
                            color: Palette.primary,
                          ),
                          title: const Text(SupportConstants.supportEmail),
                          onPressed: (context) =>
                              context.read<HelpCubit>().emailSupport(),
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.reviews,
                            color: Palette.primary,
                          ),
                          title: Text(language!.label_help_give_feedback),
                          onPressed: (_) => Navigator.pushNamed(
                              context, RouteConstants.feedbackPage),
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.device_unknown,
                            color: Palette.primary,
                          ),
                          title: Text(language.label_Devicesetting_Info),
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.star,
                            color: Palette.primary,
                          ),
                          title: Text(language.label_help_rate_app),
                          onPressed: (context) async {
                            if (await inAppReview.isAvailable()) {
                              inAppReview.requestReview();
                            }
                          },
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.share,
                            color: Palette.primary,
                          ),
                          title: Text(language.title_refer_a_friend),
                          onPressed: (context) {
                            Share.share(
                              language.label_refer_text,
                              subject: language.label_refer_subject,
                            );
                          },
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.description,
                            color: Palette.primary,
                          ),
                          title: Text(language.title_resources),
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.gavel,
                            color: Palette.primary,
                          ),
                          title: Text(language.title_terms_and_conditions),
                          onPressed: (context) =>
                              context.read<HelpCubit>().onPolicy(
                                    policyType: PolicyType.terms,
                                  ),
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.phonelink_lock,
                            color: Palette.primary,
                          ),
                          title: Text(language.label_help_privacy_policy),
                          onPressed: (context) =>
                              context.read<HelpCubit>().onPolicy(
                                    policyType: PolicyType.privacy,
                                  ),
                        ),
                        SettingsTile.navigation(
                          leading: const Icon(
                            Icons.published_with_changes,
                            color: Palette.primary,
                          ),
                          title: Text(language.label_help_whats_new),
                          onPressed: (context) => Navigator.pushNamed(
                            context,
                            RouteConstants.webViewPage,
                            arguments: WebViewPageArguments(
                              CrisesControlUrls.whatsNewurl,
                              language.label_help_whats_new,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void handleStateChanges(HelpState state, BuildContext context) {
    if (state is HelpLoading) {
      _loadingOverlay.show(context);
    } else {
      _loadingOverlay.hide();
    }

    if (state is HelpPolicy) {
      var language = AppLocalizations.of(context);
      var title = (state.policyType == PolicyType.privacy)
          ? language!.label_help_privacy_policy
          : language!.title_terms_and_conditions;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => WebViewPage(
            title: title,
            url: state.url,
          ),
        ),
      );
    }

    Widget _buildListTile(BuildContext context,
        {required IconData icon,
        required Color color,
        required String text,
        void Function()? onTap}) {
      return ListTile(
        leading: Icon(icon, color: color),
        title: Text(text),
        onTap: onTap,
        horizontalTitleGap:
            16.0, // Increase this value to add more space between icon and text
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
      );
    }
  }
}
