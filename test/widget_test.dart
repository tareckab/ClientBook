import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ClientBook/main.dart';
import 'package:ClientBook/services/auth_service.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Inicialize o AuthService corretamente
    final auth = await AuthService.init();

    await tester.pumpWidget(MyApp(auth: auth));

    // ...restante do teste...
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
