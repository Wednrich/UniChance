import 'package:flutter_test/flutter_test.dart';
import 'package:grantmap/main.dart';

void main() {
  testWidgets('UniChance home screen renders', (WidgetTester tester) async {
    await tester.pumpWidget(const UniChanceApp());
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('UniChance'), findsOneWidget);
    expect(find.text('Грантты тексеру'), findsOneWidget);
    expect(
      find.text('ҰБТ балыңды енгіз де, грантқа мүмкіндігіңді анықта'),
      findsOneWidget,
    );
  });
}
