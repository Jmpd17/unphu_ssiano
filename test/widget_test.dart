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

    expect(find.text('Aún no hay destinos disponibles'), findsOneWidget);
    expect(find.text('Encuentra tu camino en el campus'), findsNothing);

    await tester.tap(find.byTooltip('Volver al inicio'));
    await tester.pumpAndSettle();

    expect(find.text('Encuentra tu camino en el campus'), findsOneWidget);
    expect(find.text('Aún no hay destinos disponibles'), findsNothing);
  });
}
