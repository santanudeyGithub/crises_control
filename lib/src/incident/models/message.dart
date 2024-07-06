class LibraryMessage {
  LibraryMessage({required this.title, required this.message});
  final String title;
  final String message;

  static List<LibraryMessage> mockMessages = [
    LibraryMessage(
      title: 'My Message',
      message: 'message from message library',
    ),
    LibraryMessage(
      title: 'Second Message',
      message: 'Second message from message library',
    ),
    LibraryMessage(
      title: 'Test Message',
      message: 'test message from message library',
    ),
  ];
}
