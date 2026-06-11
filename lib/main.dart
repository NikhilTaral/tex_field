import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SimpleTextFieldApp());
}

class SimpleTextFieldApp extends StatelessWidget {
  const SimpleTextFieldApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple TextField',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TextFieldScreen(),
    );
  }
}

class TextFieldScreen extends StatefulWidget {
  const TextFieldScreen({super.key});

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  // The controller gives you access to the text the user types
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    // Always dispose of the controller to prevent memory leaks
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single TextField')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: TextField(
            controller: _textController,
            decoration: const InputDecoration(
              labelText: 'Enter your text',
              hintText: 'Type something here...',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TextFieldDemo());
  }
}

class TextFieldDemo extends StatefulWidget {
  const TextFieldDemo({super.key});

  @override
  State<TextFieldDemo> createState() => _TextFieldDemoState();
}

class _TextFieldDemoState extends State<TextFieldDemo> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  // ── Copy/Paste-only context menu ──────────────────────────────────────────
  static Widget _copyPasteMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    final bool hasSelection =
        !editableTextState.textEditingValue.selection.isCollapsed &&
        editableTextState.textEditingValue.selection.isValid;

    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: [
        // Copy — only when something is selected
        if (hasSelection)
          ContextMenuButtonItem(
            label: 'Copy',
            onPressed: () {
              editableTextState.copySelection(SelectionChangedCause.toolbar);
              ContextMenuController.removeAny();
            },
          ),

        // Paste — always available
        ContextMenuButtonItem(
          label: 'Paste',
          onPressed: () async {
            final ClipboardData? data = await Clipboard.getData(
              Clipboard.kTextPlain,
            );
            if (data?.text != null) {
              editableTextState.pasteText(SelectionChangedCause.toolbar);
            }
            ContextMenuController.removeAny();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TextFormField Test')),
      body: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            autofocus: false,
            readOnly: false,
            textAlign: TextAlign.start,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            enableInteractiveSelection: true,
            // ── plug in the custom menu here ──
            contextMenuBuilder: _copyPasteMenuBuilder,
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
