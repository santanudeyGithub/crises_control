import 'package:crises_control/src/CustomAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

class Language {
  final String name;
  final String icon;

  Language(this.name, this.icon);
}

class ChooseLanguage extends StatefulWidget {
  const ChooseLanguage({super.key});

  @override
  State<ChooseLanguage> createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  // List of languages
  List<Language> languages = [
    Language('English', 'assets/flags/arab.png'),
    Language('Spanish', 'assets/flags/english.png'),
    Language('French', 'assets/flags/french.png'),
    Language('German', 'assets/flags/german.png'),
    Language('German', 'assets/flags/polish.png'),
    Language('German', 'assets/flags/spanish.png'),
    Language('German', 'assets/flags/turkish.png'),
  ];
  Map<String, bool> selectedLanguages = {};

  @override
  void initState() {
    super.initState();
    // Initialize selectedLanguages map with false values
    for (var language in languages) {
      selectedLanguages[language.name] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var language = AppLocalizations.of(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomHeader(
              title: language!.title_language,
            ),
          ),
          Positioned(
            top: 120, // Adjust to control the overlap
            left: 16,
            right: 16,
            child: Container(
              height: 600,
              width: 300,
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
                mainAxisSize: MainAxisSize.min,
                children: languages.map((language) {
                  return CheckboxListTile(
                    title: Row(
                      children: [
                        Image.asset(
                          language.icon,
                          width: 45,
                          height: 45,
                        ),
                        SizedBox(width: 10),
                        Text(language.name),
                      ],
                    ),
                    value: selectedLanguages[language.name] ?? false,
                    onChanged: (bool? value) {
                      setState(() {
                        selectedLanguages[language.name] = value!;
                      });
                    },
                  );
                }).toList(),
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
