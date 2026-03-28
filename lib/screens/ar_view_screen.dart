import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ARViewScreen extends StatefulWidget {
  const ARViewScreen({super.key});

  @override
  State<ARViewScreen> createState() => _ARViewScreenState();
}

class _ARViewScreenState extends State<ARViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black);
  }

  @override
  Widget build(BuildContext context) {
    final placeName = ModalRoute.of(context)?.settings.arguments as String? ?? 'Nashik';
    
    final encodedName = Uri.encodeComponent('$placeName, Nashik');
    final url = 'https://www.google.com/maps/search/?api=1&query=$encodedName';
    _controller.loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        title: Text('AR/VR View: $placeName'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
