import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unphu_ssiano/main.dart';

void main() {
  testWidgets('Abre MAP y permite volver al inicio', (tester) async {
    await tester.pumpWidget(const UnphuSsianoApp());

    expect(find.text('UNPHU-SSIANO'), findsOneWidget);
    expect(find.text('Encuentra tu camino en el campus'), findsOneWidget);

    final exploreButton = find.text('Explorar el campus');
    await tester.ensureVisible(exploreButton);
    await tester.tap(exploreButton);
    await tester.pumpAndSettle();

    expect(find.text('Destinos de demostración'), findsOneWidget);
    expect(find.text('Encuentra tu camino en el campus'), findsNothing);

    await tester.tap(find.byTooltip('Volver al inicio'));
    await tester.pumpAndSettle();

    expect(find.text('Encuentra tu camino en el campus'), findsOneWidget);
    expect(find.text('Destinos de demostración'), findsNothing);
  });

  testWidgets('Filtra destinos y permite limpiar la búsqueda', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: CampusMapPage()));

    final searchField = find.byType(TextField);
    expect(find.text('5 resultados'), findsOneWidget);

    await tester.enterText(searchField, '  AULA  ');
    await tester.pump();
    expect(find.text('Aula A-101'), findsOneWidget);
    expect(find.text('Aula B-202'), findsOneWidget);
    expect(find.text('Biblioteca'), findsNothing);
    expect(find.text('2 resultados'), findsOneWidget);

    await tester.enterText(searchField, 'a-101');
    await tester.pump();
    expect(find.text('Aula A-101'), findsOneWidget);
    expect(find.text('Aula B-202'), findsNothing);
    expect(find.text('1 resultado'), findsOneWidget);

    await tester.enterText(searchField, 'zzzz');
    await tester.pump();
    expect(find.text('0 resultados'), findsOneWidget);
    expect(
      find.text('No encontramos coincidencias.\nPrueba otro nombre o código.'),
      findsOneWidget,
    );

    await tester.tap(find.byTooltip('Limpiar búsqueda'));
    await tester.pump();
    expect(find.text('5 resultados'), findsOneWidget);
    expect(find.text('Biblioteca'), findsOneWidget);
    expect(find.text('zzzz'), findsNothing);
  });
}
