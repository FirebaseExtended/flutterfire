import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:e2e/e2e.dart';

void main() {
  E2EWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Enable ', (WidgetTester tester) async {
    final FirebasePerformance performance = FirebasePerformance.instance;
    performance.setPerformanceCollectionEnabled(true);
    expect(performance.isPerformanceCollectionEnabled(), completion(isFalse));
  });
}
