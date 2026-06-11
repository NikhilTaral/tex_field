import 'package:flutter_test/flutter_test.dart';

import 'package:text_field/main.dart';

void main() {
  testWidgets('shows the editable text field', (WidgetTester tester) async {
    await tester.pumpWidget(const SimpleTextFieldApp());

    expect(find.text('Single TextField'), findsOneWidget);
    expect(find.text('Enter your text'), findsOneWidget);
    expect(find.text('Type something here...'), findsOneWidget);
  });
}
