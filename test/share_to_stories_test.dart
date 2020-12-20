import 'package:flutter/services.dart';
import 'package:flutter_share_to_stories/share_to_stories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  MockMethodChannel mockMethodChannel;

  setUp(() {
    mockMethodChannel = MockMethodChannel();
    ShareToStories.CHANNEL.setMockMethodCallHandler((call) async {
      await mockMethodChannel.invokeMethod<void>(call.method, call.arguments);
    });
  });
}

class MockMethodChannel extends Mock implements MethodChannel {}
