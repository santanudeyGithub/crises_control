import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DemoWebViewPage extends StatelessWidget {
  final String url;

  DemoWebViewPage({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Web View'),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
