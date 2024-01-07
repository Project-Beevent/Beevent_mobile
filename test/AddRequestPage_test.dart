import 'package:flutter/material.dart';
import 'package:beevent_flutter/Model/Repository/DatabaseOperations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beevent_flutter/View/AddRequestPage.dart';

void main() {
  testWidgets('Clear Fields Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: AddRequestPage(userEmail: 'example@email.com'),
      ),
    );

    // Ensure the initial state is as expected.
    expect(find.text('Test Title'), findsNothing);
    expect(find.text('Test Description'), findsNothing);
    expect(find.text('A+'), findsNothing);
    expect(find.text('Ankara'), findsNothing);
    expect(find.text('Medilif'), findsNothing);

    // Ensure the 'Clear' button is on-screen.
    await tester.ensureVisible(find.text('Clear'));

    // Trigger the _clearFields method.
    await tester.tap(find.text('Clear'));
    await tester.pump();

    // Verify that the state is cleared.
    expect(find.text('Test Title'), findsNothing);
    expect(find.text('Test Description'), findsNothing);
    expect(find.text('A+'), findsNothing);
    expect(find.text('Ankara'), findsNothing);
    expect(find.text('Medilif'), findsNothing);
  });
}