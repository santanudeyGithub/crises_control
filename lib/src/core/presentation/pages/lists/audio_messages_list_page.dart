import 'package:crises_control/src/CustomAppbar.dart';
import 'package:crises_control/src/core/models/audio_message.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:crises_control/src/core/presentation/widgets/custom_widgets.dart'
    as searchBar;
import 'package:google_fonts/google_fonts.dart';

class AudioMessagesListPage extends StatefulWidget {
  const AudioMessagesListPage({Key? key, required this.selectedAudioMessages});
  final List<AudioMessage> selectedAudioMessages;

  @override
  State<AudioMessagesListPage> createState() => _AcknowledgeOptionsListPage();
}

class _AcknowledgeOptionsListPage extends State<AudioMessagesListPage> {
  final List<AudioMessage> _selectedAudioMessages = [];
  List<AudioMessage> _searchResults = [];
  final TextEditingController _searchTextController = TextEditingController();

  final List<Map<String, dynamic>> items = [
    {'type': 'text', 'content': 'My audio title'},
    {'type': 'custom', 'content': 'My 21 audio title'},
    {'type': 'text', 'content': 'My third audio title'},
    {'type': 'custom', 'content': 'My 23 audio title'},
  ];

  @override
  void initState() {
    super.initState();
    _selectedAudioMessages.addAll(widget.selectedAudioMessages);
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
              title: language!.label_audio_message,
            ),
          ),
          Positioned(
            top: 150, // Adjust to control the overlap
            left: 16,
            right: 16,
            bottom: 0,
            child: Column(
              children: [
                // searchBar.SearchBar(
                //   searchTextController: _searchTextController,
                //   onClear: (() {
                //     setState(() {
                //       _searchTextController.clear();
                //     });
                //   }),
                //   onChanged: (value) {
                //     setState(() {
                //       _onSearchTextChanged(value);
                //     });
                //   },
                // ),

                Container(
                  height: 475,
                  width: 378,
                  margin: const EdgeInsets.only(
                      top: 0, left: 15), // Adjust this to position the box
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: _buildItem(item),
                          ),
                        );
                      }),

                  // child: ListView.builder(
                  //   itemCount: _searchTextController.text.isNotEmpty
                  //       ? _searchResults.length
                  //       : AudioMessage.mockAudioMessages.length,
                  //   itemBuilder: ((context, index) {
                  //     var audioMessage = _searchTextController.text.isNotEmpty
                  //         ? _searchResults[index]
                  //         : AudioMessage.mockAudioMessages[index];
                  //     var isSelected =
                  //         _selectedAudioMessages.contains(audioMessage);
                  //     return SelectionListTile(
                  //       isSelected: isSelected,
                  //       onTap: () {
                  //         if (isSelected) {
                  //           setState(() {
                  //             _selectedAudioMessages.remove(audioMessage);
                  //           });
                  //         } else {
                  //           setState(() {
                  //             _selectedAudioMessages.add(audioMessage);
                  //           });
                  //         }
                  //       },
                  //       title: audioMessage.audioMessageTitle,
                  //     );
                  //   }),
                  // ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 35),
                  child: Container(
                    child: CustomFAB(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.mic),
      //   backgroundColor: Colors.white,
      // ),
    );
  }

  _onSearchTextChanged(String text) async {
    setState(() {
      _searchResults = AudioMessage.mockAudioMessages
          .where(
            (value) => (value.audioMessageTitle
                    .toLowerCase()
                    .contains(text.toLowerCase()) ||
                value.audioMessageTitle
                    .toLowerCase()
                    .contains(text.toLowerCase())),
          )
          .toList();
    });
  }

  Widget _buildItem(Map<String, dynamic> item) {
    switch (item['type']) {
      case 'text':
        return ListTile(
          // leading: Icon(item['icon'], color: Colors.blue),
          title: Text(item['content']),
        );
      // case 'image':
      // return ListTile(
      // leading: Icon(item['icon'], color: Colors.blue),
      //title: Image.network(item['content']),
      //   );
      case 'custom':
      default:
        return SizedBox.shrink(); // Return an empty widget for unknown types
    }
  }
}

class CustomListItem extends StatelessWidget {
  final String content;
  final IconData icon;

  CustomListItem({required this.content, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(content),
    );
  }
}

class CustomFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 75.0,
          height: 75.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 26, 130, 248)
                    .withOpacity(0.5)
                    .withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(
                color: Color(0xff1E60AA).withOpacity(0.3), width: 3.0),
            color: Colors.white, // FAB background color
          ),
        ),
        Image(
            image: AssetImage('assets/images/audio_speaker.png'),
            height: 35,
            width: 35),
        Padding(
          padding: const EdgeInsets.only(top: 120, bottom: 0),
          child: Container(
            child: Text(
              'Record Audio',
              style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
