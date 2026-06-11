import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

import 'package:flutter/material.dart';

void main() {
  ui_web.platformViewRegistry.registerViewFactory('html-input', (int viewId) {
    return html.InputElement()
      ..value = 'Test Copy Paste'
      ..style.width = '300px'
      ..style.height = '50px'
      ..style.fontSize = '16px';
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPage(),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          height: 60,
          child: HtmlElementView(viewType: 'html-input'),
        ),
      ),
    );
  }
}
