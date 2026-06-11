import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TextFieldDemo(),
    );
  }
}

class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({super.key});

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 350,
          child: TextField(
            controller: _controller,
            enableInteractiveSelection: true,
            contextMenuBuilder:
                (BuildContext context, EditableTextState editableTextState) {
                  return AdaptiveTextSelectionToolbar.editableText(
                    editableTextState: editableTextState,
                  );
                },
            decoration: const InputDecoration(
              labelText: 'Enter Text',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
