class AudioMessage {
  AudioMessage(this.audioMessageTitle, this.path);
  final String audioMessageTitle;
  final String path;

  static List<AudioMessage> mockAudioMessages = [
    AudioMessage('My audio title', 'path'),
    AudioMessage('My 21 audio title', 'path'),
    AudioMessage('My third audio title', 'path'),
    AudioMessage('My 23 audio title', 'path'),
  ];
}
