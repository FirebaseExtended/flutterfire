import 'package:flutter_test/flutter_test.dart';
import 'package:e2e/e2e.dart';

void main() {
  E2EWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Is true true?', (WidgetTester tester) async {
    expect(true, isTrue);
  });
}
