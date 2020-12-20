import 'package:flutter/services.dart';
import 'package:flutter_share_to_stories/share_to_stories.dart';
import 'package:flutter_test/flutter_test.dart' show TestWidgetsFlutterBinding;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MockMethodChannel mockMethodChannel;

  setUp(() {
    mockMethodChannel = MockMethodChannel();
    ShareToStories.CHANNEL.setMockMethodCallHandler((call) async {
      await mockMethodChannel.invokeMethod<void>(call.method, call.arguments);
    });
  });

  test("Share with nulls will throw an error", () {
    expect(
      () => ShareToStories.shareToInstagram(),
      throwsA(const TypeMatcher<AssertionError>()),
    );
  });
}

class MockMethodChannel extends Mock implements MethodChannel {}
