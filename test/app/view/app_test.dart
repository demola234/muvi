import 'package:flutter_test/flutter_test.dart';
import 'package:moviex/app/app.dart';

void main() {
  group('App', () {
    testWidgets('renders Home Screen', (tester) async {
      await tester.pumpWidget(const App());
    });
  });
}
