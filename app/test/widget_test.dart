import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('Testiranje dodavanja zadatka', (WidgetTester tester) async {
    // Build naše aplikacije i pokreni prvi okvir.
    await tester.pumpWidget(TodoApp());

    // Proveri da naša lista zadataka počinje prazna.
    expect(find.text('Todo List with ID'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Otvori dijalog za dodavanje novog zadatka.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Proveri da je dijalog za dodavanje vidljiv.
    expect(find.text('Add a new todo'), findsOneWidget);

    // Unesi ID i tekst zadatka u tekstualna polja.
    await tester.enterText(find.byType(TextField).first, '1'); // Unesi ID
    await tester.enterText(find.byType(TextField).last, 'Testni zadatak'); // Unesi tekst zadatka

    // Tapni na dugme "Add".
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Proveri da je zadatak dodat u listu.
    expect(find.text('1: Testni zadatak'), findsOneWidget);
  });
}
