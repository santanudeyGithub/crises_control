import 'package:crises_control/src/CustomAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OffDutySettingsPage extends StatefulWidget {
  const OffDutySettingsPage({super.key});

  @override
  State<OffDutySettingsPage> createState() => _OffDutySettingsPageState();
}

class _OffDutySettingsPageState extends State<OffDutySettingsPage> {
  Map<String, bool> _checkboxValues = {
    '15mi': false,
    '30mi': false,
    '45mi': false,
    '1hr': false,
    '1hr': false,
  };

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
              title: language!.label_setting_offcall,
            ),
          ),
          Positioned(
            top: 120, // Adjust to control the overlap
            left: 16,
            right: 16,
            child: Container(
              width: 200,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                // border: Border.all(
                //   color: Colors.black,
                //   width: 3,
                // ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Select the time and dates you are unavailable. \nYou will be excluded from receiving Notifications \n for that duration. ',
                  style: GoogleFonts.roboto(
                    fontSize: 14, // Bigger font size
                    color: Color(0xff0B223C),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 250, // Adjust to control the overlap
            left: 16,
            right: 16,
            child: Container(
              width: 200,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                // border: Border.all(
                //   color: Colors.black,
                //   width: 3,
                // ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Container(
                      child: Text(
                        'Select Time Interval',
                        style: GoogleFonts.roboto(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff3A3A3A),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _checkboxValues.keys.map((key) {
                      return Row(
                        children: [
                          Checkbox(
                            value: _checkboxValues[key],
                            onChanged: (bool? value) {
                              setState(() {
                                _checkboxValues[key] = value!;
                              });
                            },
                          ),
                          Text(
                            key,
                            style: TextStyle(fontSize: 18, color: Colors.black),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 390, // Adjust to control the overlap
            left: 16,
            right: 16,
            child: Container(
              width: 200,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                // border: Border.all(
                //   color: Colors.black,
                //   width: 3,
                // ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text(
                        textAlign: TextAlign.center,
                        'Select Date and Time Range',
                        style: GoogleFonts.roboto(
                          fontSize: 17, // Bigger font size
                          color: Color(0xff3A3A3A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, right: 170),
                    child: Container(
                      child: Text(
                        'Start Date and Time',
                        style: GoogleFonts.roboto(
                          fontSize: 17, // Bigger font size
                          color: Color(0xff3A3A3A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  CenteredLabelTextField(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 530, // Adjust to control the overlap
            left: 16,
            right: 16,
            child: Container(
              child: Column(
                children: [
                  Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 170),
                    child: Container(
                      child: Text(
                        'End Date and Time',
                        style: GoogleFonts.roboto(
                          fontSize: 17, // Bigger font size
                          color: Color(0xff3A3A3A),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  CenteredLabelTextField(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 800,
            left: 16,
            right: 16,
            child: ElevatedButton(
              onPressed: () {
                // Navigator.pop(context, _selectedDepartments);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xff2175D4), // Text color
                elevation: 5, // Elevation
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(8), // Button border radius
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 120, vertical: 15),
              ),
              child: Text(
                'save'.toUpperCase(),
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xffFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CenteredLabelTextField extends StatefulWidget {
  @override
  _CenteredLabelTextFieldState createState() => _CenteredLabelTextFieldState();
}

class _CenteredLabelTextFieldState extends State<CenteredLabelTextField> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String _selectedDate = '';
  String _selectedTime = '';

  Future<void> _selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);
      setState(() {
        _selectedDate = formattedDate;
        _dateController.text = _selectedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      String formattedTime = selectedTime.format(context);
      setState(() {
        _selectedTime = formattedTime;
        _timeController.text = _selectedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  height: 55,
                  child: Stack(
                    children: [
                      Center(
                        child: TextField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            // labelText: 'Select Date',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                          ),
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(FocusNode()); // Hide keyboard
                            _selectDate(context);
                          },
                        ),
                      ),
                      // Positioned.fill(
                      //   child: Align(
                      //     alignment: Alignment.center,
                      //     child: Text(
                      //       'Select Date',
                      //       style: TextStyle(color: Colors.grey),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 12), // Space between date and time pickers
              Expanded(
                child: Container(
                  height: 55,
                  child: Stack(
                    children: [
                      Center(
                        child: TextField(
                          controller: _timeController,
                          decoration: InputDecoration(
                            // labelText: 'Select Time',
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 15),
                          ),
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(FocusNode()); // Hide keyboard
                            _selectTime(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 20),
          // Text(
          //   'Selected Date: $_selectedDate',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
          // Text(
          //   'Selected Time: $_selectedTime',
          //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          // ),
        ],
      ),
    );
  }
}
