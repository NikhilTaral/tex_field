import 'package:flutter/cupertino.dart';
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
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _fasttextController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  static Widget _copyPasteMenuBuilder(
    BuildContext context,
    EditableTextState editableTextState,
  ) {
    final TextSelection selection =
        editableTextState.textEditingValue.selection;
    final bool hasSelection = selection.isValid && !selection.isCollapsed;

    return AdaptiveTextSelectionToolbar.buttonItems(
      anchors: editableTextState.contextMenuAnchors,
      buttonItems: <ContextMenuButtonItem>[
        if (hasSelection)
          ContextMenuButtonItem(
            label: 'Copy',
            onPressed: () {
              editableTextState.copySelection(SelectionChangedCause.toolbar);
              ContextMenuController.removeAny();
            },
          ),
        ContextMenuButtonItem(
          label: 'Paste',
          onPressed: () async {
            final data = await Clipboard.getData(Clipboard.kTextPlain);
            final text = data?.text ?? '';

            debugPrint('Pasted: $text');

            editableTextState.pasteText(SelectionChangedCause.toolbar);

            ContextMenuController.removeAny();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Single TextField')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                textFormWidget(_fasttextController),
                SizedBox(height: 20),
                TextField(
                  controller: _textController,
                  enableInteractiveSelection: true,
                  contextMenuBuilder: _copyPasteMenuBuilder,
                  decoration: const InputDecoration(
                    labelText: 'Enter your text',
                    hintText: 'Type something here...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // Source - https://stackoverflow.com/q/65976071
  // Posted by DIVYANSHU SAHU, modified by community. See post 'Timeline' for change history
  // Retrieved 2026-06-11, License - CC BY-SA 4.0

  Widget textFormWidget(TextEditingController controller) {
    TextSelectionControls? _selectionControls;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        selectionControls: _selectionControls,
        enabled: true,
        enableInteractiveSelection: true,
        readOnly: false,
        textAlign: TextAlign.center,
        cursorWidth: 3,
        decoration: const InputDecoration(labelText: "stak1"),
      ),
    );
  }
}
// Source - https://stackoverflow.com/a/71912865
// Posted by Arenukvern
// Retrieved 2026-06-11, License - CC BY-SA 4.0

class AppCupertinoTextSelectionControls extends CupertinoTextSelectionControls {
  AppCupertinoTextSelectionControls({required this.onPaste});
  ValueChanged<TextSelectionDelegate> onPaste;
  @override
  Future<void> handlePaste(final TextSelectionDelegate delegate) {
    onPaste(delegate);
    return super.handlePaste(delegate);
  }
}

class AppMaterialTextSelectionControls extends MaterialTextSelectionControls {
  AppMaterialTextSelectionControls({required this.onPaste});
  ValueChanged<TextSelectionDelegate> onPaste;
  @override
  Future<void> handlePaste(final TextSelectionDelegate delegate) {
    onPaste(delegate);
    return super.handlePaste(delegate);
  }
}
