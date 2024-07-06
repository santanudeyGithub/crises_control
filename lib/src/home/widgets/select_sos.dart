import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/home/widgets/sos_1.dart';
import 'package:crises_control/src/home/widgets/sos_2.dart';
import 'package:crises_control/src/home/widgets/sos_3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectSOSPage extends StatefulWidget {
  const SelectSOSPage({super.key});

  @override
  State<SelectSOSPage> createState() => _SelectSOSPageState();
}

class _SelectSOSPageState extends State<SelectSOSPage> {
  final TextEditingController searchController = TextEditingController();
  List<String> _items = List.generate(10, (index) => 'Item $index');
  List<String> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = _items;
  }

  void _onSearch(String query) {
    setState(() {
      _filteredItems = _items
          .where((item) => item.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
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
            child: CustomHeader(
              title: language!.label_setting_sos,
              actionIcon: Container(
                width: 25.0,
                height: 25.0,
              ),
            ),
          ),
          Positioned(
            top:
                120, // Adjust the top position to place the search box under the Positioned widget
            left: 10,
            right: 10,
            child: Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search_rounded, // Example of a different icon
                      size: 24.0,
                      color: Color(0xff1760AB),
                    ),
                    hintText: 'Search...',
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none, // Remove the default border
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top:
                200, // Adjust the top position to place the GridView below the search box
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 135, // Adjust height as needed
              child: MyGridView(),
            ),
          ),
        ],
      ),
    );
  }
}

class MyGridView extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {'image': 'assets/images/SOS_1.png', 'text': 'SOS 1', 'page': SosPageOne()},
    {'image': 'assets/images/SOS_2.png', 'text': 'SOS 2', 'page': SosPageTwo()},
    {
      'image': 'assets/images/SOS_3.png',
      'text': 'SOS 3',
      'page': SosPageThree()
    },
    {
      'image': 'assets/images/SOS_4.png',
      'text': 'SOS 4',
      'page': SosPageThree()
    },
    {
      'image': 'assets/images/SOS_5.png',
      'text': 'SOS 5',
      'page': SosPageThree()
    },
    {
      'image': 'assets/images/SOS_6.png',
      'text': 'SOS 6',
      'page': SosPageThree()
    },
  ];

  void _onGridItemTap(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // Number of columns
        crossAxisSpacing: 10.0, // Spacing between columns
        mainAxisSpacing: 10.0, // Spacing between rows
        childAspectRatio: 1, // Aspect ratio of the grid items
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onGridItemTap(context, data[index]['page']),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image
                Image.asset(
                  data[index]['image'],
                  height: 90.0,
                  width: 90.0,
                ),
                SizedBox(height: 10.0),
                // Text
                Text(
                  data[index]['text'],
                  style: GoogleFonts.roboto(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff3A3A3A),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
