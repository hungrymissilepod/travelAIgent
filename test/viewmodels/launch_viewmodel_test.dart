import 'package:flutter_test/flutter_test.dart';
import 'package:travel_aigent/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('LaunchViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}