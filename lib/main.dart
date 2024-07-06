// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors, use_key_in_widget_constructors, use_super_parameters, constant_identifier_names, prefer_const_declarations, unused_element, sort_child_properties_last, sized_box_for_whitespace, prefer_final_fields, unused_local_variable, avoid_unnecessary_containers

import 'package:crises_control/src/account/account_repository.dart';
import 'package:crises_control/src/core/constants.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/repository/google_maps_repository.dart';
import 'package:crises_control/src/core/repository/location_repository.dart';
import 'package:crises_control/src/core/router/app_router.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/core/services/connectivity_service.dart';
import 'package:crises_control/src/core/services/contact_service.dart';
import 'package:crises_control/src/core/services/crises_control_rest_service.dart';
import 'package:crises_control/src/core/services/device_service.dart';
import 'package:crises_control/src/core/services/file_service.dart';
import 'package:crises_control/src/core/services/google_maps_rest_service.dart';
import 'package:crises_control/src/core/services/location_rest_service.dart';
import 'package:crises_control/src/core/services/location_service.dart';
import 'package:crises_control/src/core/services/oauth_service/oauth_service.dart';
import 'package:crises_control/src/core/services/page_cache_database.dart';
import 'package:crises_control/src/core/services/secure_storge_service.dart';
import 'package:crises_control/src/core/services/url_launcher_service.dart';
import 'package:crises_control/src/core/services/user_database_service.dart';
import 'package:crises_control/src/help/help_repository.dart';
import 'package:crises_control/src/help/help_rest_service.dart';
import 'package:crises_control/src/home/models/home_icon_model.dart';
import 'package:crises_control/src/home/models/home_page_cache.dart';
import 'package:crises_control/src/home/repository/home_repository.dart';
import 'package:crises_control/src/home/services/home_rest_service.dart';
import 'package:crises_control/src/incident/incident_repository.dart';
import 'package:crises_control/src/incident/services/incident_rest_service.dart';
import 'package:crises_control/src/login/bloc/customer_id_bloc/customer_id_bloc.dart';
import 'package:crises_control/src/login/repository/login_repository.dart';
import 'package:crises_control/src/login/services/authentication_database_service.dart';
import 'package:crises_control/src/login/services/authentication_service.dart';
import 'package:crises_control/src/login/services/biometric_service.dart';
import 'package:crises_control/src/login/services/login_rest_service.dart';
import 'package:crises_control/src/login/view/pages/customer_id_page.dart';
import 'package:crises_control/src/ping/bloc/bloc.dart';
import 'package:crises_control/src/ping/repository/ping_repository.dart';
import 'package:crises_control/src/ping/services/ping_rest_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crises_control/src/login/view/widgets/company_logo_widget.dart';

import 'src/ping/models/ping.dart';

Future<void> main() async {
  //Initializes Hive with a valid directory in your app files.
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  initialiseHiveAdapter();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MyApp(isLoggedIn: isLoggedIn),
  );
}

void initialiseHiveAdapter() {
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(HomePageCacheAdapter());
  }

  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(HomeIconModelAdapter());
  }

  if (!Hive.isAdapterRegistered(9)) {
    Hive.registerAdapter(PingDataAdapter());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key, required this.isLoggedIn});
  final bool isLoggedIn;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Responsible for app navigation
  late AppRouter _appRouter;
  final Client _client = Client();

  @override
  void initState() {
    super.initState();
    _initDependencies();
  }

  Future _initDependencies() async {
    _appRouter = AppRouter();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationService(_client),
        ),
        RepositoryProvider(
          create: (context) => OAuthSevrice(),
        ),
        RepositoryProvider(
          create: (context) => ConnectivityService(),
        ),
        RepositoryProvider(
          create: (context) => SecureStorageService(),
        ),
        RepositoryProvider(
          create: (context) => AuthenticationDatabaseService(
            RepositoryProvider.of<SecureStorageService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => LocationRestService(),
        ),
        RepositoryProvider(
          create: (context) => LocationRepository(
            RepositoryProvider.of<LocationRestService>(context),
            RepositoryProvider.of<AuthenticationDatabaseService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => LocationService(
            RepositoryProvider.of<LocationRepository>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => GoogleMapsRestService(),
        ),
        RepositoryProvider(
          create: (context) => GoogleMapsRepository(
            RepositoryProvider.of<GoogleMapsRestService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => AuthenticationDatabaseService(
            RepositoryProvider.of<SecureStorageService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => DeviceService(),
        ),
        RepositoryProvider(
          create: (context) => LoginRestService(
            _client,
            RepositoryProvider.of<SecureStorageService>(context),
            RepositoryProvider.of<AuthenticationDatabaseService>(context),
            RepositoryProvider.of<DeviceService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => PageCacheDatabase(),
        ),
        RepositoryProvider(
          create: (context) => UserDatabaseService(),
        ),
        RepositoryProvider(
          create: (context) => ContactService(
            RepositoryProvider.of<UserDatabaseService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => HomeRepository(
            RepositoryProvider.of<HomeRestService>(context),
            RepositoryProvider.of<PageCacheDatabase>(context),
            RepositoryProvider.of<AuthenticationDatabaseService>(context),
            RepositoryProvider.of<ContactService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => HomeRestService(),
        ),
        RepositoryProvider(
          create: (context) => LoginRepository(
            RepositoryProvider.of<AuthenticationService>(context),
            RepositoryProvider.of<AuthenticationDatabaseService>(context),
            RepositoryProvider.of<OAuthSevrice>(context),
            RepositoryProvider.of<SecureStorageService>(context),
            RepositoryProvider.of<LoginRestService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => BiometricService(),
        ),
        RepositoryProvider(
          create: (context) => FileService(),
        ),
        RepositoryProvider(
          create: (context) => UrlLauncherService(),
        ),
        RepositoryProvider(
          create: (context) => IncidentRestService(),
        ),
        RepositoryProvider(
          create: (context) => IncidentRepository(
            RepositoryProvider.of<IncidentRestService>(context),
            RepositoryProvider.of<AuthenticationDatabaseService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => CrisesControlRestService(
            _client,
            RepositoryProvider.of<SecureStorageService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => PingRestService(),
        ),
        RepositoryProvider(
          create: (context) => PingRepository(
            RepositoryProvider.of<PingRestService>(context),
            RepositoryProvider.of<AuthenticationDatabaseService>(context),
            RepositoryProvider.of<CrisesControlRestService>(context),
            RepositoryProvider.of<PageCacheDatabase>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => CrisesControlCoreRepository(
            RepositoryProvider.of<CrisesControlRestService>(context),
            RepositoryProvider.of<AuthenticationDatabaseService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => AccountRepository(
            RepositoryProvider.of<AuthenticationDatabaseService>(context),
          ),
        ),
        RepositoryProvider(
          create: (context) => HelpRestService(),
        ),
        RepositoryProvider(
          create: (context) => HelpRepository(
            RepositoryProvider.of<HelpRestService>(context),
            RepositoryProvider.of<AuthenticationDatabaseService>(context),
            RepositoryProvider.of<UrlLauncherService>(context),
          ),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: AppConstants.localizationsDelegates,
        supportedLocales: AppConstants.supportedLocales,
        theme: AppConstants.themeData,
        home: BlocProvider(
          create: (context) => CustomerIdBloc(
            RepositoryProvider.of<LoginRepository>(context),
          ),
          child: const CustomerIdPage(),
        ),
        onGenerateRoute: _appRouter.onGenerateRoute,
        initialRoute: widget.isLoggedIn
            ? RouteConstants.homePage
            //: RouteConstants.customerIdPage,   // Todo Set Splash Screen
            : RouteConstants.splashScreen1,
      ),
    );
  }
}

class SplashScreen1 extends StatefulWidget {
  @override
  _SplashScreen1State createState() => _SplashScreen1State();
}

// class _SplashScreen1State extends State<SplashScreen1> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 5), () {
//       Navigator.of(context)
//           .pushReplacementNamed(RouteConstants.onboardingScreen);
//     });
//   }

//   // @override
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     body: Center(
//   //       child: Text('Splash Screen 1'),
//   //     ),
//   //   );
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(
//                 height:
//                     100), // Add some spacing between the container and the text
//             SizedBox(
//               height: 400,
//               width: 450,
//               child: CompanyLogoView(
//                 height: 450, // Adjust the size of the logo as needed
//                 width: 450, // Adjust the size of the logo as needed
//               ),
//             ),
//             // body: Center(
//             //   child: Column(
//             //     mainAxisAlignment: MainAxisAlignment.center,
//             //     children: [
//             //       Container(
//             //         width: 250,
//             //         height: 250,
//             //         margin: EdgeInsets.only(top: 250.0),
//             //         decoration: const BoxDecoration(
//             //           // Removed 'const' as BoxDecoration doesn't support const
//             //           color: Colors.white, // Example color, adjust as needed
//             //         ),
//             //         child: const Column(
//             //           mainAxisAlignment: MainAxisAlignment.center,
//             //           children: [
//             //             //Spacer(), // Spacer to push CompanyLogoView to the top
//             //             CompanyLogoView(
//             //               height: 210,
//             //               width: 210,
//             //             ),
//             //             //Spacer(), // Spacer to push CompanyLogoView to the bottom
//             //           ],
//             //         ),
//             //       ),
//             SizedBox(
//                 height:
//                     250), // Add some spacing between the container and the text
//             Text(
//               'Version 6.0.0', // Change this to the version string you want to display
//               textAlign: TextAlign.center,
//               style: GoogleFonts.urbanist(
//                 color: Colors.black,
//                 fontSize: 14,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _SplashScreen1State extends State<SplashScreen1> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 5), () {
//       Navigator.of(context)
//           .pushReplacementNamed(RouteConstants.onboardingScreen);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Flexible(
//                       child: Container(
//                         constraints:
//                             BoxConstraints(maxHeight: 400, maxWidth: 450),
//                         child: CompanyLogoView(
//                           height: 300, // Adjust the size of the logo as needed
//                           width: 300, // Adjust the size of the logo as needed
//                         ),
//                       ),
//                     ),
//                     // SizedBox(
//                     //     height:
//                     //         20), // Add some spacing between the logo and the version text
//                     // Text(
//                     //   'Version 6.0.0', // Change this to the version string you want to display
//                     //   textAlign: TextAlign.center,
//                     //   style: GoogleFonts.urbanist(
//                     //     color: Colors.black,
//                     //     fontSize: 14,
//                     //     fontWeight: FontWeight.w800,
//                     //   ),
//                     // ),
//                     Align(
//                       alignment: Alignment.bottomCenter,
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 20.0),
//                         child: Text(
//                           'Version 6.0.0', // Change this to the version string you want to display
//                           textAlign: TextAlign.center,
//                           style: GoogleFonts.urbanist(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w800,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacementNamed(RouteConstants.onboardingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Container(
                        constraints:
                            BoxConstraints(maxHeight: 400, maxWidth: 450),
                        child: CompanyLogoView(
                          height: 300, // Adjust the size of the logo as needed
                          width: 300, // Adjust the size of the logo as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  CrisesControlVersions
                      .appVersion, // Change this to the version string you want to display
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Color(0xff898989),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const TWO_PI = 3.14 * 2;

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;
  bool isLoading = true;

  int totalPages = 4;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  void _navigateToMenuItemsListView(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/menu_items');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   final double size = 100.0;

  //   return Scaffold(
  //     body: Column(
  //       children: [
  //         Expanded(
  //           child: PageView.builder(
  //             controller: _pageController,
  //             itemCount: contents.length,
  //             onPageChanged: (int index) {
  //               setState(() {
  //                 currentIndex = index;
  //               });
  //             },
  //             itemBuilder: (_, i) {
  //               return Padding(
  //                 padding: const EdgeInsets.only(top: 95),
  //                 child: Column(
  //                   children: [
  //                     if (currentIndex < contents.length - 1)
  //                       Padding(
  //                         padding: const EdgeInsets.only(left: 318),
  //                         child: Container(
  //                           child: Padding(
  //                             padding: const EdgeInsets.only(),
  //                             child: TextButton(
  //                               onPressed: () {
  //                                 Navigator.of(context).pushReplacementNamed(
  //                                     RouteConstants.customerIdPage);
  //                               },
  //                               child: Text(
  //                                 'Skip',
  //                                 style: GoogleFonts.urbanist(
  //                                   color: Colors.black,
  //                                   fontSize: 20,
  //                                   fontWeight: FontWeight.w400,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     Image.asset(
  //                       contents[i].image,
  //                       height: 150,
  //                     ),
  //                     Container(
  //                       height: MediaQuery.of(context).size.height * 0.1,
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: List.generate(
  //                           contents.length,
  //                           (index) => buildDot(index, context),
  //                         ),
  //                       ),
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.only(
  //                           left: 0, right: 10, top: 15, bottom: 10),
  //                       child: Text(
  //                         contents[i].title,
  //                         textAlign: TextAlign.center,
  //                         style: GoogleFonts.urbanist(
  //                           fontSize: 25,
  //                           fontWeight: FontWeight.w700,
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       child: Text(
  //                         contents[i].titletwo,
  //                         style: GoogleFonts.urbanist(
  //                           fontSize: 25,
  //                           fontWeight: FontWeight.w700,
  //                         ),
  //                       ),
  //                     ),
  //                     const SizedBox(height: 20),
  //                     Text(
  //                       contents[i].description,
  //                       textAlign: TextAlign.center,
  //                       style: GoogleFonts.urbanist(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w400,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                     if (_currentPage + 1 != 4)
  //                       Positioned.fill(
  //                         bottom: 0.0,
  //                         child: Container(
  //                           margin: EdgeInsets.only(
  //                               top: 80.0), // Set the margin top here
  //                           child: Align(
  //                             alignment: Alignment.bottomCenter,
  //                             child: CircularPercentIndicator(
  //                               radius:
  //                                   40.0, // Increase the radius for better visibility
  //                               lineWidth: 6,

  //                               percent: (_currentPage + 1) / totalPages,

  //                               progressColor: Color(0xff16A1ED),

  //                               backgroundColor: Colors.white,

  //                               animation: true,

  //                               animationDuration: 500,

  //                               center: FloatingActionButton(
  //                                 onPressed: () {
  //                                   if (_currentPage < totalPages - 1) {
  //                                     _pageController.nextPage(
  //                                       duration:
  //                                           const Duration(milliseconds: 500),
  //                                       curve: Curves.easeInOut,
  //                                     );
  //                                   } else {
  //                                     _navigateToMenuItemsListView(context);
  //                                   }
  //                                 },
  //                                 child: const Icon(Icons.arrow_forward),
  //                                 backgroundColor: Color(0xff1E60AA),
  //                                 foregroundColor: Colors.white,
  //                                 shape: CircleBorder(),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       )
  //                   ],
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //         if (currentIndex == contents.length - 1)
  //           Padding(
  //             padding: const EdgeInsets.only(
  //               top: 20,
  //               bottom: 55,
  //               left: 20,
  //               right: 20,
  //             ),
  //             child: SizedBox(
  //               width: double.infinity,
  //               child: ElevatedButton(
  //                 onPressed: () {
  //                   Navigator.of(context).pushReplacementNamed(
  //                     RouteConstants.customerIdPage,
  //                   );
  //                 },
  //                 child: Text(
  //                   currentIndex == contents.length - 1
  //                       ? "Get Started"
  //                       : "Next",
  //                   style: TextStyle(color: Colors.white),
  //                 ),
  //                 style: ElevatedButton.styleFrom(
  //                   backgroundColor: Color.fromRGBO(30, 96, 170, 1),
  //                   minimumSize: Size.fromHeight(50),
  //                   shape: RoundedRectangleBorder(
  //                     borderRadius: BorderRadius.circular(
  //                       UIConstants.defaultCornerRadius,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final double size = 100.0;

    int totalPagesWithoutLastPage = contents.length - 1;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.only(top: 45),
                  child: Column(
                    children: [
                      if (currentIndex < totalPagesWithoutLastPage)
                        Padding(
                          padding: const EdgeInsets.only(left: 318),
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      RouteConstants.customerIdPage);
                                },
                                child: Text(
                                  'SKIP',
                                  style: GoogleFonts.roboto(
                                    color: Color(0xff1760AB),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      Image.asset(
                        contents[i].image,
                        height: 150,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            contents.length,
                            (index) => buildDot(index, context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 10, top: 15, bottom: 10),
                        child: Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),

                      // const SizedBox(height: 20),
                      Text(
                        contents[i].description,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      if (currentIndex != totalPagesWithoutLastPage)
                        Positioned.fill(
                          bottom: 0.0,
                          child: Container(
                            margin: EdgeInsets.only(
                                top: 80.0), // Set the margin top here
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: CircularPercentIndicator(
                                radius:
                                    40.0, // Increase the radius for better visibility
                                lineWidth: 6,
                                percent: (currentIndex + 1) / totalPages,
                                progressColor: Color(0xff16A1ED),
                                backgroundColor: Colors.white,
                                animation: true,
                                animationDuration: 500,
                                center: FloatingActionButton(
                                  onPressed: () {
                                    if (currentIndex < totalPages - 1) {
                                      _pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.easeInOut,
                                      );
                                    } else {
                                      _navigateToMenuItemsListView(context);
                                    }
                                  },
                                  child: const Icon(Icons.arrow_forward),
                                  backgroundColor: Color(0xff1E60AA),
                                  foregroundColor: Colors.white,
                                  shape: CircleBorder(),
                                ),
                              ),
                            ),
                          ),
                        )
                    ],
                  ),
                );
              },
            ),
          ),
          if (currentIndex == totalPagesWithoutLastPage)
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 100,
                left: 20,
                right: 20,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed(
                      RouteConstants.customerIdPage,
                    );
                  },
                  child: Text(
                    currentIndex == totalPagesWithoutLastPage
                        ? "GET STARTED"
                        : "NEXT",
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(30, 96, 170, 1),
                    minimumSize: Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        UIConstants.defaultCornerRadius,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10,
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

class SplashScreen2 extends StatefulWidget {
  @override
  _SplashScreen2State createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacementNamed(RouteConstants.customerIdPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen 2'),
      ),
    );
  }
}
