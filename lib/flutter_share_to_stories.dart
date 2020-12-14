import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';

class ShareToStories {
  static const String CHANNEL_NAME = "vrk.tk/share_to_stories";
  static const MethodChannel CHANNEL = MethodChannel(CHANNEL_NAME);

  static Future<void> shareToInstagram({
    Uri backgroundAssetUri,
    Uri stickerAssetUri,
    Color topColor,
    Color bottomColor,
  }) async {
    assert(backgroundAssetUri != null || stickerAssetUri != null);
  }
}
