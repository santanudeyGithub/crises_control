import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/core.dart';
import 'package:crises_control/src/core/repository/crises_control_core_repository.dart';
import 'package:crises_control/src/core/router/route_constants.dart';
import 'package:crises_control/src/home/cubit/home_cubit.dart';
import 'package:crises_control/src/home/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => HomePage(),
    );
  }

  var customerId = '';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeLoaded) {
          if (state.appHome != null) {
            RepositoryProvider.of<CrisesControlCoreRepository>(context)
                .saveHomeData(state.appHome!);
          }
          var la1 = RepositoryProvider.of<CrisesControlCoreRepository>(context)
              .getCompanyParamValue(CompanyParamKeys.allowSocialPosting)
              .toBool();
          var la2 = RepositoryProvider.of<CrisesControlCoreRepository>(context)
              .checkMenuAccess(SecItemKeys.pingAudioMessage);
          customerId = state.loginData.customerId;
        }

        if (state is HomeLoggedOut) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            RouteConstants.customerIdPage,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        var language = AppLocalizations.of(context);
        return Scaffold(
          drawer: const SideDrawer(),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(screenHeight / 3),
            child: AppBar(
              title: Align(
                child: Center(
                  child: Text(
                    //customerId,
                    // language!.bb_home,
                    'Company Name',
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 22),
                  ),
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
              automaticallyImplyLeading: true,
              actions: [
                IconButton(
                  onPressed: () async => context.read<HomeCubit>().refresh(),
                  icon: const Icon(Icons.refresh),
                  color: Colors.white,
                )
              ],
              bottom: PreferredSize(
                preferredSize: const Size(double.infinity, 1.0),
                child: Visibility(
                  visible: state is HomeLoading,
                  child: const LinearProgressIndicator(),
                ),
              ),
              flexibleSpace: Stack(
                children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/img_group_10.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 125, left: 28, right: 15),
                      child: Container(
                        height: 400,
                        width: 358,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.5),
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            )
                          ],
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 166, top: 88, bottom: 0),
                    child: Positioned(
                      child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xffF2F2F2),
                          border: Border.all(
                            color: Color.fromARGB(
                                255, 255, 255, 255), // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 95,
                    left: 175,
                    child: ClipOval(
                      child: Container(
                        color: Color(0xff3E46F5),
                        width: 72,
                        height: 72,
                        alignment: Alignment.center,
                        child: Text(
                          'PD',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 175,
                    left: 168,
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            'Paul Davies',
                            //textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff1760AB),
                            ),
                          ),
                        ),
                        // Container(
                        //   child: Text(
                        //     'View Responses',
                        //     //textAlign: TextAlign.center,
                        //     style: GoogleFonts.roboto(
                        //       fontSize: 18,
                        //       fontWeight: FontWeight.w500,
                        //       color: Color(0xff3A3A3A),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 218, left: 48),
                    child: Container(
                      width: 155.0, // Width of the container
                      height: 93.0, // Height of the container
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 251, 255,
                            255), // Background color of the container
                        borderRadius: BorderRadius.circular(
                            20.0), // Circular border radius
                        border: Border.all(
                          color: Color(0xffF2F2F2), // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the content vertically
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 55),
                            child: Positioned(
                              child: Text(
                                'Incidents',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xff3A3A3A),
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Opacity(
                            opacity: 0.6,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 27),
                              child: Positioned(
                                child: Text(
                                  'Responsiveness',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromRGBO(11, 34, 60, 1),
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 26, left: 18, top: 10),
                            child: Positioned(
                              child: Container(
                                width: screenWidth *
                                    0.3, // 30% of the screen width
                                height: screenHeight *
                                    0.005, // 0.5% of the screen height
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(87.88),
                                          color: Color.fromRGBO(0, 182, 13, 1),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: screenWidth *
                                          0.068, // 6.8% from the left
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(0, 182, 13, 1),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: screenWidth *
                                          0.137, // 13.7% from the left
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(204, 204, 204, 1),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: screenWidth *
                                          0.206, // 20.6% from the left
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: const BoxDecoration(
                                          color:
                                              Color.fromRGBO(204, 204, 204, 1),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: screenWidth *
                                          0.275, // 27.5% from the left
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(87.88),
                                          color:
                                              Color.fromRGBO(204, 204, 204, 1),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 218, left: 212),
                    child: Container(
                      width: 155.0, // Width of the container
                      height: 93.0, // Height of the container
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 251, 255,
                            255), // Background color of the container
                        borderRadius: BorderRadius.circular(
                            20.0), // Circular border radius
                        border: Border.all(
                          color: Color(0xffF2F2F2), // Border color
                          width: 2.0, // Border width
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center the content vertically
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 55),
                            child: Positioned(
                              child: Text(
                                'Incidents',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Color(0xff3A3A3A),
                                  fontFamily: 'Roboto',
                                  fontSize: 14,
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.w600,
                                  height: 1,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Opacity(
                            opacity: 0.6,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 27),
                              child: Positioned(
                                child: Text(
                                  'Responsiveness',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color.fromRGBO(11, 34, 60, 1),
                                    fontFamily: 'Roboto',
                                    fontSize: 12,
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w500,
                                    height: 1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 26, left: 18, top: 10),
                            child: Positioned(
                              child: Container(
                                width: screenWidth *
                                    0.3, // 30% of the screen width
                                height: screenHeight *
                                    0.005, // 0.5% of the screen height
                                child: Stack(
                                  children: <Widget>[
                                    Positioned(
                                      top: 0,
                                      left: 0,
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(87.88),
                                          color: Color.fromRGBO(0, 182, 13, 1),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: screenWidth *
                                          0.068, // 6.8% from the left
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: const BoxDecoration(
                                          color: Color.fromRGBO(0, 182, 13, 1),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: screenWidth *
                                          0.137, // 13.7% from the left
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: const BoxDecoration(
                                          color: Color(0xffFFB500),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: screenWidth *
                                          0.206, // 20.6% from the left
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: const BoxDecoration(
                                          color: Color(0xffFFB500),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 0,
                                      left: screenWidth *
                                          0.275, // 27.5% from the left
                                      child: Container(
                                        width: screenWidth *
                                            0.063, // 6.3% of the screen width
                                        height: screenHeight *
                                            0.005, // 0.5% of the screen height
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(87.88),
                                          color: Color(0xffF01212),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: const Column(
            children: [
              HomeBody(),
            ],
          ),
          // bottomNavigationBar: BottomAppBar(
          //   height: screenHeight * 0.05, // 5% of the screen height
          //   color: const Color.fromRGBO(30, 96, 170, 1),
          //   child: Center(
          //     child: Text(
          //       CrisesControlVersions.appVersion,
          //       style: GoogleFonts.urbanist(
          //         color: const Color.fromARGB(255, 255, 255, 255),
          //         fontSize: screenHeight * 0.02, // 2% of the screen height
          //         fontWeight: FontWeight.w800,
          //       ),
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
